FROM condaforge/mambaforge:22.11.1-4

RUN conda install -c conda-forge conda-merge conda-pack yq
RUN wget https://raw.githubusercontent.com/QCDIS/NaaVRE/main/environment.yml -O naa-vre-environment.yml
RUN wget https://raw.githubusercontent.com/QCDIS/NaaVRE/main/docker/MULTIPLY/environment.yaml -O multiply-environment.yml
RUN conda-merge naa-vre-environment.yml multiply-environment.yml > merged-environment.yaml
#RUN yq eval 'del(.dependencies[] | select(.pip != null))' merged-environment.yaml

RUN mamba env update --name venv -f merged-environment.yaml -c conda-forge

RUN conda-pack -n venv -o /tmp/env.tar && \
    mkdir /venv && cd /venv && tar xf /tmp/env.tar && \
    rm /tmp/env.tar
RUN /venv/bin/conda-unpack

