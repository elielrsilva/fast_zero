FROM python:3.10-slim
ENV POETRY_VIRTUALENVS_CREATE=false

WORKDIR app/
COPY . .

RUN pip install poetry

# Instale gcc e python3-dev antes de poetry install
RUN apt-get update && \
    apt-get install -y gcc python3-dev && \
    apt-get clean

RUN poetry config installer.max-workers 10
RUN poetry install --no-interaction --no-ansi

EXPOSE 8000
CMD poetry run uvicorn --host 0.0.0.0 fast_zero.app:app
