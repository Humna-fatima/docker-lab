
ARG PYTHON_VERSION=3.14.0-alpine3.22

FROM python:${PYTHON_VERSION} AS build-image

WORKDIR '/app'

RUN apk add --no-cache linux-headers g++
RUN apk add --no-cache netcat-openbsd

COPY ./requirements.txt ./

RUN pip wheel --wheel-dir=/root/wheels -r requirements.txt


FROM python:${PYTHON_VERSION} AS production-image

RUN addgroup -S uwsgi && adduser -S uwsgi -G uwsgi
RUN apk add --no-cache netcat-openbsd
#RUN apt update && apt upgrade -y && apt install netcat-openbsd -y

WORKDIR '/app'

COPY --from=build-image /root/wheels /root/wheels

COPY --from=build-image /app/requirements.txt ./

RUN pip install --no-index --find-links=/root/wheels -r requirements.txt && rm -rf /root/wheels

COPY --chown=uwsgi:uwsgi . .

USER uwsgi

CMD ["uwsgi", "--ini", "app.ini"]







# ​FROM python:3.14.3-alpine3.23: Sets the base image. It uses a very lightweight version of Linux (Alpine) with Python pre-installed.
# ​WORKDIR '/app': Creates a directory named /app inside the container and sets it as the active working directory for all following commands.
# ​RUN apk add --no-cache linux-headers g++: Uses the Alpine package manager (apk) to install dependencies needed to compile C-based Python extensions (like uwsgi).
# ​RUN pip install Flask: Installs the Flask web framework.
# ​RUN pip install uwsgi: Installs the uWSGI application server.
# ​COPY ./ ./: Copies all files from your current local directory into the /app directory in the container.
# ​RUN addgroup -S uwsgi && adduser -S uwsgi -G uwsgi: Creates a system group and user named uwsgi for security purposes (so the app doesn't run as root).
# ​USER uwsgi: Switches the active user to uwsgi.
# ​CMD ["uwsgi", "--ini", "app.ini"]: The default command that runs when the container starts, launching the app using the configuration file.