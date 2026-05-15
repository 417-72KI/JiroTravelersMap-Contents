FROM python@sha256:89a288a9a9e9141b9f0c51744c358138da6369897792f1af3f5425e407d9529a

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
