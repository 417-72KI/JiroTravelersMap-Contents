FROM node:12.9

ADD . /work
WORKDIR /work

RUN npm i

ENTRYPOINT [ "npm", "start", "--" ]
CMD [ "/work/resources/crawled" ]
