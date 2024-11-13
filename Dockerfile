FROM python:3.13@sha256:e1b0f7dd93fcc8e34d15379c4e487cb69bf6e93088f0f8b24ef0d5137d7974cc
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]