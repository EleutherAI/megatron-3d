FROM nvcr.io/nvidia/pytorch:20.12-py3

RUN apt-get update -y && \
    apt-get install -y git pdsh htop tmux openssh-server vim && \
    python -m pip install --upgrade pip && \
    pip install gpustat

RUN mkdir -p ~/.ssh /app /job && \
    echo 'Host *' > ~/.ssh/config && \
    echo '    StrictHostKeyChecking no' >> ~/.ssh/config && \
    echo 'AuthorizedKeysFile     .ssh/authorized_keys' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'export PDSH_RCMD_TYPE=ssh' >> ~/.bashrc

WORKDIR /app

COPY requirements.txt /app
RUN pip install -r requirements.txt

