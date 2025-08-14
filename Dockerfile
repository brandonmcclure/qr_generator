FROM python:3.13@sha256:a66f18ee22c568a3d45191dfd70bdea2e1bd8d303f982ea1bca276a065285a21
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]