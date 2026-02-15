# Use a specific LTS version for stability
FROM node:24-slim

# Install any extra system dependencies if needed (optional)
# RUN apt-get update && apt-get install -y git python3

# Set the working directory inside the container
WORKDIR /src

# Keep the container running so we can exec into it
CMD ["tail", "-f", "/dev/null"]