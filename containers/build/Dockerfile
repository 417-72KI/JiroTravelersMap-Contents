FROM python@sha256:3c737d592b9e137029b9f3fd3bfc50d0de7f41c3334f4212db563ff9eaa1f856

RUN apt-get update \
    && apt-get install -y jq

RUN pip install yq

COPY main.sh /usr/local/bin

ENTRYPOINT [ "main.sh" ]
