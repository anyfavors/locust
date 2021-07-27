FROM alpine:3.14

COPY . /build

RUN apk update && apk add python3

RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev g++ make build-base libzmq zeromq-dev py3-pip python3-dev \
     && pip install cython wheel && cd /build && pip install . && rm -rf /build && apk del .build-deps gcc musl-dev libffi-dev g++ make build-base libzmq zeromq-dev py3-pip python3-dev

EXPOSE 8089 5557

RUN adduser -D locust
USER locust
WORKDIR /home/locust
ENTRYPOINT ["locust"]

# turn off python output buffering
ENV PYTHONUNBUFFERED=1
