FROM golang:alpine

RUN apk add --update \
    curl \
    make \
    git \ 
    tar && \
    rm -rf /var/cache/apk/*

WORKDIR /go/src/app
COPY . /go/src/app
RUN make geoip-download && make all

EXPOSE 8080
CMD ipd -f ./data/country.mmdb -c ./data/city.mmdb -l 0.0.0.0:8080 -r -p -t index.html --trusted-header=X-Real-IP
