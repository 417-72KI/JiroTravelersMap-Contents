FROM python@sha256:2081144b23b38daa7fae3b7ee4b42cf2f858d88b0452736274aafaba96f3a6b6

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
