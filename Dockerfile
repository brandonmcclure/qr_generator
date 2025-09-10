FROM python:3.13@sha256:35c05b6d32b11a1a8134f35dd0db68ef6fbb21ce62934a7aec6d50977915a92c
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]