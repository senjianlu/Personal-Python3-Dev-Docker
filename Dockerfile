# 基础镜像系统版本为 selenium/standalone-chrome:4.16.0
FROM selenium/standalone-chrome:4.16.0

# 维护者信息
LABEL maintainer="Rabbir admin@cs.cheap"

# Docker 内用户切换到 root
USER root

# 配置 openssh-server
RUN apt-get update && apt-get install -y openssh-server
# 修改配置允许使用 root 用户登录，在最后一行添加 PermitRootLogin yes
RUN sed -i '$aPermitRootLogin yes' /etc/ssh/sshd_config
# 修改配置允许使用密码登录，在最后一行添加 PasswordAuthentication yes
RUN sed -i '$aPasswordAuthentication yes' /etc/ssh/sshd_config
# 启动 ssh 服务
RUN service ssh start

# 启动命令，执行 /opt/bin/entry_point.sh 脚本
ENTRYPOINT ["/opt/bin/entry_point.sh"]