FROM python:3.13@sha256:a4b2b11a9faf847c52ad07f5e0d4f34da59bad9d8589b8f2c476165d94c6b377
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]