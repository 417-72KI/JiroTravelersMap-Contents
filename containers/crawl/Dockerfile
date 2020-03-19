FROM node:13.10

ADD . /work
WORKDIR /work

RUN npm i

ENTRYPOINT [ "npm", "start", "--" ]
CMD [ "/work/resources/crawled" ]
