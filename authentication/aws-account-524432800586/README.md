# 关于terraform cloud后端配置

https://www.terraform.io/language/settings/backends/remote

## 参考示例

```
$ git clone https://github.com/hashicorp/tfc-getting-started.git
$ cd tfc-getting-started
$ scripts/setup.sh
```

# 使用方式
```
terraform login # 会跳到登录页面然后生成一个token，把token粘贴到终端
terraform init # 下载需要的插件
terraform apply 
```