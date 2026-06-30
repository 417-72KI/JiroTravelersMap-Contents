FROM python@sha256:09b29c360b84742bf98eba40b214f7f6b4b53286bb2c8a8b5b1afa188a8d9c0e

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
