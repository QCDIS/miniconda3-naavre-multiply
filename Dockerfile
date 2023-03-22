FROM condaforge/mambaforge:22.11.1-4

RUN conda install -c conda-forge conda-merge conda-pack mamba
RUN cat environment.yaml
RUN conda env update --name venv -f environment.yaml

