# ---
# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = merge(local.default_tags, tomap({ "Name" = "eks-vpc" }), {
    Name                 = "eks-vpc"
    git_commit           = "d7ef81dda8108ae72532cd8fcb27277523383fa3"
    git_file             = "modules/eks/vpc.tf"
    git_last_modified_at = "2021-10-08 10:47:45"
    git_last_modified_by = "ko.h@ctw.inc"
    git_modifiers        = "ko.h"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "3ae4e793-69ed-4ee0-89c1-d5e93abf3fbf"
  })
}

# ---
# Subnet
resource "aws_subnet" "sn" {
  count             = var.num_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index % var.num_subnets)
  tags = merge(local.default_tags, tomap({ "Name" = "eks-sn" }), {
    Name                 = "eks-sn"
    git_commit           = "d7ef81dda8108ae72532cd8fcb27277523383fa3"
    git_file             = "modules/eks/vpc.tf"
    git_last_modified_at = "2021-10-08 10:47:45"
    git_last_modified_by = "ko.h@ctw.inc"
    git_modifiers        = "ko.h"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "7841714d-92bc-4acf-b204-d8ac11b3f27f"
  })
}

# ---
# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(local.default_tags, tomap({ "Name" = "eks-igw" }), {
    Name                 = "eks-igw"
    git_commit           = "d7ef81dda8108ae72532cd8fcb27277523383fa3"
    git_file             = "modules/eks/vpc.tf"
    git_last_modified_at = "2021-10-08 10:47:45"
    git_last_modified_by = "ko.h@ctw.inc"
    git_modifiers        = "ko.h"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "4cd219d4-473f-4fb5-9a01-dd08f9e5b54d"
  })
}

# ---
# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(local.default_tags, tomap({ "Name" = "eks-rt" }), {
    Name                 = "eks-rt"
    git_commit           = "d7ef81dda8108ae72532cd8fcb27277523383fa3"
    git_file             = "modules/eks/vpc.tf"
    git_last_modified_at = "2021-10-08 10:47:45"
    git_last_modified_by = "ko.h@ctw.inc"
    git_modifiers        = "ko.h"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "1b2c5c33-64ec-4af5-a290-ce834e809ce7"
  })
}

resource "aws_route_table_association" "rta" {
  count          = var.num_subnets
  subnet_id      = element(aws_subnet.sn.*.id, count.index)
  route_table_id = aws_route_table.rt.id
}

# ---
# Security Group
resource "aws_security_group" "eks-master" {
  name        = "eks-master-sg"
  description = "EKS master security group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, tomap({ "Name" = "eks-master-sg" }), {
    Name                 = "eks-master-sg"
    git_commit           = "d7ef81dda8108ae72532cd8fcb27277523383fa3"
    git_file             = "modules/eks/vpc.tf"
    git_last_modified_at = "2021-10-08 10:47:45"
    git_last_modified_by = "ko.h@ctw.inc"
    git_modifiers        = "ko.h"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "c297d86f-54c3-443e-9b39-98e328a1cc07"
  })
}

resource "aws_security_group" "eks-node" {
  name        = "eks-node-sg"
  description = "EKS node security group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "Allow cluster master to access cluster node"
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.eks-master.id]
  }

  ingress {
    description     = "Allow cluster master to access cluster node"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.eks-master.id]
    self            = false
  }

  ingress {
    description = "Allow inter pods communication"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, tomap({ "Name" = "eks-node-sg" }), {
    Name                 = "eks-node-sg"
    git_commit           = "d7ef81dda8108ae72532cd8fcb27277523383fa3"
    git_file             = "modules/eks/vpc.tf"
    git_last_modified_at = "2021-10-08 10:47:45"
    git_last_modified_by = "ko.h@ctw.inc"
    git_modifiers        = "ko.h"
    git_org              = "houko"
    git_repo             = "terraform-aws"
    yor_trace            = "436e64e0-78cf-4261-a0ae-bcd08e41777f"
  })
}