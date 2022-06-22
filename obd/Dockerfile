FROM python:3-slim-bullseye

RUN pip install obd

COPY logger.py /app/logger.py

ENTRYPOINT [ "python3", "/app/logger.py" ]