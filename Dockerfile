FROM sissbruecker/linkding:1.29.0 AS original
LABEL org.opencontainers.image.authors="thenoseman"
LABEL org.opencontainers.image.description="Small optical adjustments of sissbruecker/linkding:latest"
WORKDIR /etc/linkding
COPY /etc/linkding .
RUN cat static/customized.css >> static/theme-light.css
