#!/bin/bash
set -e

# +------
# Usage:
#     data "external" "your_data_name" {
#       program = ["bash", "your/path/to/scripts/get_vpc.sh"]
#       query = {
#         profile  = "profile name"
#         vpc_name = "vpc name"
#       }
#     }
# +--
# Input:
#   - $profile,   ex. 'g123-pro'
#   - $vpc_name,  ex. 'g123-auth'
# +--
# Output:
#     data.external.your_data_name.result
#     {
#       "cidr"                = "10.201.1.0/24"
#       "id"                  = "vpc-06d3573cf1e78641f"
#       "name"                = "g123-auth"
#       "route_table_default" = "rtb-0fe56afde72c7b8c3"
#       "subnet_az_a"         = "subnet-0895338876c83972a"
#       "subnet_az_c"         = "subnet-070b6f02d42ba925f"
#       "subnet_az_d"         = "subnet-015732062403d60f6"
#     }
# +------

# Extract arguments from the input query (please brew install jq)
# jq to ensure the values are properly quoted and escaped for consumption by the shell
eval "$(jq -r '@sh "PROFILE=\(.profile) VPC_NAME=\(.vpc_name)"')"

# Bash to retrieve values
vpc_id=$(aws --profile $PROFILE ec2 describe-vpcs |jq -j --arg VPC_NAME "$VPC_NAME" '.Vpcs[]? | select(.Tags[]? | select(.Value == $VPC_NAME and .Key == "Name")).VpcId')
vpc_cidr=$(aws --profile $PROFILE ec2 describe-vpcs |jq -j --arg VPC_NAME "$VPC_NAME" '.Vpcs[]? | select(.Tags[]? | select(.Value == $VPC_NAME)).CidrBlock')
public_subnets=$(aws --profile $PROFILE ec2 describe-subnets |jq -j --arg VPC_ID "$vpc_id" '.Subnets[]? |  select(.VpcId == $VPC_ID) | select(.Tags[]? | select(.Value | contains ("public")))' | jq -s '.' | jq -r '[.[].SubnetId]')
private_subnets=$(aws --profile $PROFILE ec2 describe-subnets |jq -j --arg VPC_ID "$vpc_id" '.Subnets[]? |  select(.VpcId == $VPC_ID) | select(.Tags[]? | select(.Value | contains ("private")))' | jq -s '.' | jq -r '[.[].SubnetId]')
intra_subnets=$(aws --profile $PROFILE ec2 describe-subnets |jq -j --arg VPC_ID "$vpc_id" '.Subnets[]? |  select(.VpcId == $VPC_ID) | select(.Tags[]? | select(.Value | contains ("intra")))' | jq -s '.' | jq -r '[.[].SubnetId]')
subnet_az_a=$(aws --profile $PROFILE ec2 describe-subnets |jq -j --arg VPC_ID "$vpc_id" '.Subnets[]? | select(.VpcId == $VPC_ID and .AvailabilityZone == "ap-northeast-1a").SubnetId' |sed 's/subnet/delete/2' |sed 's/delete.*//g')
subnet_az_c=$(aws --profile $PROFILE ec2 describe-subnets |jq -j --arg VPC_ID "$vpc_id" '.Subnets[]? | select(.VpcId == $VPC_ID and .AvailabilityZone == "ap-northeast-1c").SubnetId' |sed 's/subnet/delete/2' |sed 's/delete.*//g')
subnet_az_d=$(aws --profile $PROFILE ec2 describe-subnets |jq -j --arg VPC_ID "$vpc_id" '.Subnets[]? | select(.VpcId == $VPC_ID and .AvailabilityZone == "ap-northeast-1d").SubnetId' |sed 's/subnet/delete/2' |sed 's/delete.*//g')
route_table_default=$(aws --profile $PROFILE ec2 describe-route-tables |jq -j --arg VPC_ID "$vpc_id" '.RouteTables[]? | select(.VpcId == $VPC_ID and (.Associations[]? | select(.Main == true)))'.RouteTableId)
route_tables_public=$(aws --profile $PROFILE ec2 describe-route-tables |jq -j --arg VPC_ID "$vpc_id" '.RouteTables[]? | select(.VpcId == $VPC_ID and (.Tags[]? | select(.Value | contains("public"))))' | jq -s '.' | jq -r '[.[].RouteTableId]')
route_tables_private=$(aws --profile $PROFILE ec2 describe-route-tables |jq -j --arg VPC_ID "$vpc_id" '.RouteTables[]? | select(.VpcId == $VPC_ID and (.Tags[]? | select(.Value | contains("private"))))' | jq -s '.' | jq -r '[.[].RouteTableId]')
route_tables_intra=$(aws --profile $PROFILE ec2 describe-route-tables |jq -j --arg VPC_ID "$vpc_id" '.RouteTables[]? | select(.VpcId == $VPC_ID and (.Tags[]? | select(.Value | contains("intra"))))' | jq -s '.' | jq -r '[.[].RouteTableId]')
cidr_public=$(aws --profile $PROFILE ec2 describe-subnets |jq -j --arg VPC_ID "$vpc_id" '.Subnets[]? |  select(.VpcId == $VPC_ID) | select(.Tags[]? | select(.Value | contains ("public")))' | jq -s '.' | jq -r '[.[].CidrBlock]')
cidr_private=$(aws --profile $PROFILE ec2 describe-subnets |jq -j --arg VPC_ID "$vpc_id" '.Subnets[]? |  select(.VpcId == $VPC_ID) | select(.Tags[]? | select(.Value | contains ("private")))' | jq -s '.' | jq -r '[.[].CidrBlock]')
cidr_intra=$(aws --profile $PROFILE ec2 describe-subnets |jq -j --arg VPC_ID "$vpc_id" '.Subnets[]? |  select(.VpcId == $VPC_ID) | select(.Tags[]? | select(.Value | contains ("intra")))' | jq -s '.' | jq -r '[.[].CidrBlock]')

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n \
  --arg id "$vpc_id" \
  --arg name "$VPC_NAME" \
  --arg cidr "$vpc_cidr" \
  --arg public_subnets "$public_subnets" \
  --arg private_subnets "$private_subnets" \
  --arg intra_subnets "$intra_subnets" \
  --arg subnet_az_a "$subnet_az_a" \
  --arg subnet_az_c "$subnet_az_c" \
  --arg subnet_az_d "$subnet_az_d" \
  --arg route_table_default "$route_table_default" \
  --arg route_tables_public "$route_tables_public" \
  --arg route_tables_private "$route_tables_private" \
  --arg route_tables_intra "$route_tables_intra" \
  --arg cidr_public "$cidr_public" \
  --arg cidr_private "$cidr_private" \
  --arg cidr_intra "$cidr_intra" \
  '{"id":$id, "name":$name, "cidr":$cidr, "public_subnets": $public_subnets, "private_subnets": $private_subnets, "intra_subnets": $intra_subnets, "subnet_az_a":$subnet_az_a, "subnet_az_c":$subnet_az_c, "subnet_az_d":$subnet_az_d, "route_table_default":$route_table_default, "route_tables_public":$route_tables_public, "route_tables_private":$route_tables_private, "route_tables_intra":$route_tables_intra, "cidr_public":$cidr_public, "cidr_private":$cidr_private, "cidr_intra":$cidr_intra}'
