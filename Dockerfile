FROM mhart/alpine-node:latest
MAINTAINER Jason Reeves <jason.reeves19@gmail.com>

WORKDIR /resume

# Install wkthml2pdf
RUN apk add --no-cache \
            xvfb \
            # Additionnal dependencies for better rendering
            ttf-freefont \
            fontconfig \
            dbus && \
    # Install wkhtmltopdf from `testing` repository
    apk add qt5-qtbase-dev \
            wkhtmltopdf \
            --no-cache \
            --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
            --allow-untrusted && \
    # Wrapper for xvfb
    mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin && \
    echo $'#!/usr/bin/env sh\n\
Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \n\
DISPLAY=:0.0 wkhtmltopdf-origin $@ \n\
killall Xvfb\
' > /usr/bin/wkhtmltopdf && \
    chmod +x /usr/bin/wkhtmltopdf

COPY mods/ /hmrmodpaper

RUN npm install -g hackmyresume && alias hmr='/usr/bin/hackmyresume'

ENTRYPOINT [ "hackmyresume" ]

