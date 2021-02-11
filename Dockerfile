FROM nvcr.io/nvidia/pytorch:20.12-py3

RUN apt-get update -y && \
    apt-get install -y git pdsh htop tmux && \
    python -m pip install --upgrade pip && \
    pip install gpustat

RUN mkdir -p ~/.ssh /app /job /build_dir && \
    echo 'Host *' > ~/.ssh/config && \
    echo '    StrictHostKeyChecking no' >> ~/.ssh/config && \
    echo 'AuthorizedKeysFile     .ssh/authorized_keys' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'export PDSH_RCMD_TYPE=ssh' >> ~/.bashrc

WORKDIR /build_dir

COPY requirements.txt /build_dir
RUN pip install -r requirements.txt
RUN pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" git+https://github.com/NVIDIA/apex.git

WORKDIR /app

