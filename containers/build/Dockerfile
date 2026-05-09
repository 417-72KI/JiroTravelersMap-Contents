FROM python@sha256:48062459b592a77251858a5a640c098dfb6f72efc8ae85d9b30fb99b605e1890

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
