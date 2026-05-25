FROM python@sha256:250e5c97be05e1eb2272fbdbd810dfd638f9012e1e6f65c99390ad3239943a08

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
