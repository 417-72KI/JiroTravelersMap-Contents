FROM python@sha256:4d7dd74c5b2d3151fe58eb8ecc9c56be13471a240ce5423ba765b04f8f95ebe8

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
