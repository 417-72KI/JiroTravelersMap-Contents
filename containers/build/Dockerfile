FROM python@sha256:6928095b5c67225857e608dd95271a81e8bb134e4bf7e7c305a9cdc2502a1d06

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
