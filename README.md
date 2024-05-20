# QR Generator

This program provides a web interface to generate a QR code with an image embedded in it. I am attempting to create QR codes that are resilient to "quishing" attacks. I have QR codes that are deployed to public areas to send people to informational website. These QR codes are in areas where it is possible for someone to tamper with them by overlaying their own sticker/image.

## How to run

You only need `docker` to run this program. The following command will run it and make it accessible to http://localhost:3008 for you to use.

```
docker run -it --rm -p 127.0.0.1:3008:3008 bmcclure89/qr_generator:main
```

## How to build

To follow my build you will need [GNU Makefile](Makefile), and `docker`. With those dependencies, you can run `make` and it will build the docker image, and run the latest tag in interactive mode basically running the command above for you so you can see the logs from the app. 


You can run the python script without any of that, just create a venv (`python -m venv ".venv"`), activate it (`source .venv/bin/activate`), install pip requirements (`pip install -r requirements.txt`) and then run (`python main.py`)