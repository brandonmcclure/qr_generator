FROM python:3.13@sha256:6f244021b4eebc18b8b577ada606b5765b907bd547dacadfa132fe2acfa5f58f
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]