FROM python@sha256:5c485439db26ba10745100656f6712d662075edb7ec6861dda715bcdfe579b29

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
