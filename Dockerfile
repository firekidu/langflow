FROM python:3.10-slim

WORKDIR /app

# Copy the source code
COPY . .

# Install dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev || pip install -e .

# Expose port
EXPOSE 7860

# Run Langflow
CMD ["langflow", "run", "--host", "0.0.0.0", "--port", "7860"]
