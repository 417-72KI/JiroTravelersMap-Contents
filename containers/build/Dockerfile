FROM python@sha256:5f1cdbcab9a50594a79502dd73e885456d2a2fc31f1a1fa18484815b37ee9152

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
