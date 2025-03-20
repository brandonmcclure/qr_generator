FROM python:3.13@sha256:8c55c44b9e81d537f8404d0000b7331863d134db87c1385dd0ec7fefff656495
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]