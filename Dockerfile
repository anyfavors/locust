FROM python:3.9.6-alpine3.14

COPY . /build

RUN apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev g++ make py3-zmq \
     && pip install cython && cd /build && pip install . && rm -rf /build && apk del .build-deps gcc musl-dev libffi-dev g++ make py3-zmq

EXPOSE 8089 5557

RUN useradd --create-home locust
USER locust
WORKDIR /home/locust
ENTRYPOINT ["locust"]

# turn off python output buffering
ENV PYTHONUNBUFFERED=1
