FROM python:3.14@sha256:049247cbb7ce998685d780c9d5325781a7429bc6693bbfab86bcb8e36e7a059e
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]