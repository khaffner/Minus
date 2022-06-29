FROM python:3-slim-bullseye

RUN pip3 install gpiozero

COPY logger.py /app/logger.py

ENTRYPOINT [ "python3", "/app/logger.py" ]