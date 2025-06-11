FROM python:3.13@sha256:307a3e44b2a6c7d9c5fbb8c3a6c46c4c1535cde8eeb85a3ccb3513862f20aaad
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]