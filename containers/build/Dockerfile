FROM python@sha256:2a8b92a1e9eb6ef2c888eb7e6c91283788c6d613fdc8fc22e12346aff7c4406d

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
