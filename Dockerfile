FROM golang:1.10-alpine3.7 AS builder 

ADD . /go/src/github.com/lwander/k8s-demo

RUN go install github.com/lwander/k8s-demo

ADD ./content  /content

RUN mv /go/bin/k8s-demo  /demo/

#Package
#Use scratch image
FROM scratch
WORKDIR /root/
COPY --from=builder /demo .
EXPOSE 8000
CMD ["/root/k8s-demo"]
