FROM alpine:3.14

COPY . /build

RUN apk update && apk add python3

RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev g++ make build-base libzmq zeromq-dev \
     && pip install cython && cd /build && pip install . && rm -rf /build && apk del .build-deps gcc musl-dev libffi-dev g++ make build-base libzmq zeromq-dev

EXPOSE 8089 5557

RUN useradd --create-home locust
USER locust
WORKDIR /home/locust
ENTRYPOINT ["locust"]

# turn off python output buffering
ENV PYTHONUNBUFFERED=1
