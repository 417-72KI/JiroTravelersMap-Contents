FROM python@sha256:288157085f183c0000cb14cbf5c81d304f2dcdc4c386578a0c1bd214d178f7a4

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
