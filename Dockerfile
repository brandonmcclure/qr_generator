FROM python:3.13@sha256:e95be020750503923c5d4f51a56ab8f5b21e40cdce66fb7000e270df68d04f8e
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]