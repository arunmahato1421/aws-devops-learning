# Use Python as the base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy app code into container
COPY app.py /app/

# Set default command
# Set default command
CMD ["python", "app.py", "py"]
