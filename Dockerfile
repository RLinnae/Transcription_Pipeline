# Use an official Python runtime as a parent image
FROM python:3.9.18-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install ffmpeg for audio and video processing
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install Python dependencies, replacing 'whisper' with 'openai-whisper'
RUN pip install --no-cache-dir pydub yt_dlp openai-whisper noisereduce

# Due to the complexity of pyannote.audio and its dependencies, we recommend installing it separately to handle potential errors
RUN pip install --no-cache-dir pyannote.audio

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV MODEL_BASE_PATH /usr/src/app/models

# Run main.py when the container launches
CMD ["python", "./main.py"]