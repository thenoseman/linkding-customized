FROM sissbruecker/linkding:latest AS original
LABEL org.opencontainers.image.authors="thenoseman"
LABEL org.opencontainers.image.description="Small optical adjustments of sissbruecker/linkding:latest"
WORKDIR /etc/linkding
COPY /etc/linkding .
RUN cat static/customized.css >> static/theme-light.css
