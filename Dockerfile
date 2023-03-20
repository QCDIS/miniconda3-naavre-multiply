FROM qcdis/miniconda3-naavre AS naavre-build

RUN conda env export --name venv > naavre-build-environment.yml
RUN cat naavre-build-environment.yml


FROM qcdis/miniconda3-multiply

RUN conda install -c conda-forge mamba conda-merge conda-pack
COPY --from=naavre-build naavre-build-environment.yml naavre-build-environment.yml

RUN mamba install -c conda-forge conda-merge conda-pack
RUN cat naavre-build-environment.yml

RUN conda env update -f naavre-build-environment.yml