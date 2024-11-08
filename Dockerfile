FROM gitpod/openvscode-server:latest

USER root 

RUN apt-get update
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN apt-get install -y python3-venv
RUN apt-get install -y python3-opencv

RUN usermod --login mcodi openvscode-server 
RUN usermod -a -G users mcodi
RUN mkdir /home/codespace
RUN chown mcodi /home/codespace
RUN chown 777 /home/codespace

USER mcodi

ENV OPENVSCODE_SERVER_ROOT="/home/.openvscode-server"
ENV OPENVSCODE="${OPENVSCODE_SERVER_ROOT}/bin/openvscode-server"

SHELL ["/bin/bash", "-c"]
RUN \
    # Direct download links to external .vsix not available on https://open-vsx.org/
    # The two links here are just used as example, they are actually available on https://open-vsx.org/
    urls=(\
        https://open-vsx.org/api/googlecloudtools/cloudcode/2.20.0/file/googlecloudtools.cloudcode-2.20.0.vsix \
        https://open-vsx.org/api/ms-python/python/2024.18.0/file/ms-python.python-2024.18.0.vsix \
    )\
    # Create a tmp dir for downloading
    && tdir=/tmp/exts && mkdir -p "${tdir}" && cd "${tdir}" \
    # Download via wget from $urls array.
    && wget "${urls[@]}" && \
    # List the extensions in this array
    exts=(\
        # From https://open-vsx.org/ registry directly
        gitpod.gitpod-theme \
        # From filesystem, .vsix that we downloaded (using bash wildcard '*')
        "${tdir}"/* \
    )\
    # Install the $exts
    && for ext in "${exts[@]}"; do ${OPENVSCODE} --install-extension "${ext}"; done


EXPOSE 3000 8501 8502 8511 8512 8521 8522
ENTRYPOINT ["/bin/sh", "-c", "exec ${OPENVSCODE_SERVER_ROOT}/bin/openvscode-server --default-folder /home/codespace --host 0.0.0.0 --without-connection-token \"${@}\"", "--"]