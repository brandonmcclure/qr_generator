FROM python:3.13@sha256:ef3361c6ba7b5c8f5538ceb322e98bc7f93ba93e49492d92454db660dedb6389
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]