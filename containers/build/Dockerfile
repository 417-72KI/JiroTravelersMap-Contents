FROM python@sha256:cbb768ddb9e20b55a46e8c3cf9f4caeddd367bd3dc9838c90785ee32962454fa

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
