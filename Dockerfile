FROM python:3.13@sha256:eb120d016adcbc8bac194e15826bbb4f1d1569d298d8817bb5049ed5e59f41d9
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]