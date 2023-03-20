FROM qcdis/miniconda3-naavre:v0.11 AS naavre-build

RUN conda env export --name venv > naavre-build-environment.yml
RUN cat naavre-build-environment.yml


FROM qcdis/miniconda3-multiply:v0.9

RUN conda install -c conda-forge mamba conda-merge conda-pack
COPY --from=naavre-build naavre-build-environment.yml naavre-build-environment.yml

RUN conda install -c conda-forge conda-merge conda-pack
RUN cat naavre-build-environment.yml
RUN conda install mamba -c conda-forge
RUN mamba env update -f naavre-build-environment.yml