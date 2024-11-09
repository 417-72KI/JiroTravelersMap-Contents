FROM 41772ki/swift-mint:6.0

ADD . /jtmcvalidator
WORKDIR /jtmcvalidator

RUN swift package resolve
RUN swift build -c release \
    && mv .build/release/jtmcvalidator /usr/local/bin \
    && rm -rf .build

ENTRYPOINT [ "jtmcvalidator" ]
CMD [ "/work/public/shop_list/origin.json" ]
