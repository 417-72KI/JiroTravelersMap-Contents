FROM 41772ki/swift-mint:6.3@sha256:a2bac682c92e099739c880ef332e46eb98a5cb48403f4be77c86509a852a65f8

ADD . /jtmcvalidator
WORKDIR /jtmcvalidator

RUN swift package resolve
RUN swift build -c release \
    && mv .build/release/jtmcvalidator /usr/local/bin \
    && rm -rf .build

ENTRYPOINT [ "jtmcvalidator" ]
CMD [ "/work/public/shop_list/origin.json" ]
