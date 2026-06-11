FROM python@sha256:90d5306545870da68636de2a12ba9132388714fb5f7077cb914c0e30a96d7de4

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
