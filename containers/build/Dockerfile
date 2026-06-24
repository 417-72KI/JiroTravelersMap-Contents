FROM python@sha256:1a644e11f327643c58d47b3aaf4632ba602da0da95d3e5845d85bd50d4be30e8

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
