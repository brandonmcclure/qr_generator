FROM python:3.13@sha256:b89c8a45626cd670f81e0504084362c7e88dd432090b08f6de1b7b047fcf6c4a
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]