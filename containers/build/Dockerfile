FROM python@sha256:fe6ffb340c566fe7459832667da8b545896edb30c3dce0c3b1218ab4d377ba7d

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
