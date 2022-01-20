FROM centos

MAINTAINER xiaomo<xiaomo@xiaomo.info>

ENV MYPATH /usr/local

WORKDIR $MYPATH

RUN yum -y install vim
RUN yum -y install net-tools

EXPOSE 80

CMD echo $MYPATH
CMD echo "---end---"
ENTRYPOINT ["ls","-a"]
CMD /bin/bash


# build命令(用户名/镜像名:版本号)
    # docker build -f centos.Dockerfile -t xiaomoinfo/mycentos:v1.0.0 .

# 运行(用户名/镜像名:版本号)
    # docker run -it --name mycentos1 xiaomoinfo/mycentos:v1.0.0

# 登陆
    # docker login

# 推送(用户名/镜像名:版本号)
    # docker push xiaomoinfo/mycentos:v1.0.0

# feature
    # 默认工作目录在/usr/local
    # 默认安装了vim 因为安装了vim
    # 默认可以使用ifconfig 因为安装了net-tools