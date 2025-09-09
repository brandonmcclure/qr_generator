FROM python:3.13@sha256:e8fd0c972ceb973066265ed2ea7235b502c736a283993524ac58e42becd5d9f8
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]