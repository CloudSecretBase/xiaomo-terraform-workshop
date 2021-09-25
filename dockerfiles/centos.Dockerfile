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


# build命令
    # docker build -f centos.volume.Dockerfile -t xiaomo/mycentos .

# 运行
    # docker run -it --name mycentos1 xiaomo/mycentos:q:q
# feature
    # 默认工作目录在/usr/local
    # 默认安装了vim 因为安装了vim
    # 默认可以使用ifconfig 因为安装了net-tools