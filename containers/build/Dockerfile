FROM python@sha256:2ca6cda25055227533141435ab8ec0dd3afd9165d78d8bf0f58c8d959d57b9fc

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
