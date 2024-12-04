FROM python:3.13@sha256:061dfa2a69c174a42781e083ce72e9a4570a07b9efead37c433a8ccad045d3bf
COPY requirements.txt .
RUN apt-get update && \
	apt-get install -y apt-transport-https ca-certificates

RUN pip install --upgrade pip && \
	pip install -r requirements.txt --no-warn-script-location

WORKDIR /code

COPY . .

CMD ["python3", "/code/main.py"]