FROM python:3.13@sha256:bd520537b75ab1285266e9238fd4f921ae809e52f68ef3827cbcf36fdad373f0
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]