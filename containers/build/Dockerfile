FROM python@sha256:d158a97d809b7678f4383cabbaf4d8f0974579ebad98f30ca6aa1bf3d850cab8

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
