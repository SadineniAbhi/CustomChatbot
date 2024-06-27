# Use Ubuntu as a parent image
FROM ubuntu:latest

# Set environment variables
ENV OPENAI_API_KEY=""
ENV DefaultLangchainUserAgent=""

# Update package index and install necessary packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git
RUN  apt-get install -y python3-venv
RUN python3 -m venv /opt/venv


# Copy ChatBot directory into the container at /ChatBot
COPY ChatBot /ChatBot
WORKDIR /ChatBot

RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install -r requirements.txt

# Add the virtual environment's bin directory to the PATH
ENV PATH="/opt/venv/bin:$PATH"


# Copy context.txt into the container (adjust path if needed)
COPY context.txt /ChatBot/rag/content.txt

# Expose the Flask port (if using Flask)
EXPOSE 5000

# Command to run the Flask application (adjust as needed)
CMD ["/opt/venv/bin/python3", "app.py"]
