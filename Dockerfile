FROM python:3.13@sha256:bc336add24c507d3a11b68a08fe694877faae3eab2d0e18b0653097f1a0db9f3
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]