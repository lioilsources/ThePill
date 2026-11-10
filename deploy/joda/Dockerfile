# Runtime image for JODA. The binary is cross-compiled on the Mac
# (`make -C core joda-bin`: CGO_ENABLED=0, linux/amd64), so JODA never runs a Go build.
FROM gcr.io/distroless/static-debian12:nonroot
COPY bin/pill-core /usr/local/bin/pill-core
EXPOSE 8090
ENTRYPOINT ["/usr/local/bin/pill-core"]
