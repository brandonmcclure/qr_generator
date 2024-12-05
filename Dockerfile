FROM python:3.13@sha256:220d07595f288567bbf07883576f6591dad77d824dce74f0c73850e129fa1f46
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]