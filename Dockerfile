FROM python:3.13@sha256:653b0cf8fc50366277a21657209ddd54edd125499d20f3520c6b277eb8c828d3
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]