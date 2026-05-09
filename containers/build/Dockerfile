FROM python@sha256:511f025a0718f01b977d5ad572bc431745b31887ceccc538c85b87e82ad2956f

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
