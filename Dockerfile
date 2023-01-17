# Create Project Dockerfile
FROM python:3.9-alpine3.13 
LABEL maintainer="wayne"

ENV PYTHONUNBUFFERED 1


# Copy the requirements.txt file from local machine to /tmp/requirements.txt to the docker image
# Then copy the app directory to /app inside the container
COPY ./requirements.txt /tmp/requirements.txt 
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# Add a run comand that will install some dependencies on our machine
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user
