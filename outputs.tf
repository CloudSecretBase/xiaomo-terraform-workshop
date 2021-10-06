output "WEB_IP" {
  value       = module.nginx-server.ip
  description = "nginx web server ip address"
}

output "ss_IP" {
  value       = module.ss-server.ip
  description = "shadowsocks server ip address"
}