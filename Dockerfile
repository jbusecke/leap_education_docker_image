# From https://github.com/2i2c-org/coessing-image/blob/55adca9b2caa1c886a3340ff9668fea3785727cc/Dockerfile
FROM pangeo/pangeo-notebook:latest #they used a fixed tag, but I think we do not want that?

USER root
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH ${NB_PYTHON_PREFIX}/bin:$PATH

# Needed for apt-key to work
RUN apt-get update -qq --yes > /dev/null && \
    apt-get install --yes -qq gnupg2 > /dev/null

USER ${NB_USER}

COPY environment.yml /tmp/

RUN mamba env update --name ${CONDA_ENV} -f /tmp/environment.yml

# Remove nb_conda_kernels from the env for now
RUN mamba remove -n ${CONDA_ENV} nb_conda_kernels

# wonder how much of the other stuff from https://github.com/2i2c-org/coessing-image/blob/55adca9b2caa1c886a3340ff9668fea3785727cc/Dockerfile
# we need here. Test bare bones for now.
