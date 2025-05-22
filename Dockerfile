# Use an official Node.js runtime as a parent image
FROM node:24.0.2-bookworm-slim

# parchea la vulnerabilidad SNYK-DEBIAN12-SYSTEMD-5733385
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      systemd=249.12-1+deb12u2 && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]