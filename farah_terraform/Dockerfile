FROM python:3.7

# Make a directory for our application
RUN mkdir /app
WORKDIR /app

# Copy our source code
COPY neptune.py .

# Install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt


# Run the application
EXPOSE 5000
CMD ["python", "/app/neptune.py"]
