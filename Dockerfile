FROM python:3.13@sha256:a8aab6d8cce4d31c10dda046d6d940fc30b64de3438f7969f0db0ab19f3469f9
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]