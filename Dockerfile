# Use an official Node.js runtime as a parent image
FROM node:24.0.2-bookworm-slim

# Parchea GCC (CVE-2023-4039), login/passwd (CVE Arbitrary Code Injection) y luego actualiza el sistema
RUN apt-get update && \
    apt-get install --only-upgrade -y --no-install-recommends \
      gcc-12-base=12.2.0-14+deb12u1 \
      libgcc-s1=12.2.0-14+deb12u1 \
      libstdc++6=12.2.0-14+deb12u1 \
      login=1:4.13+dfsg1-1+deb12u1 \
      passwd=1:4.13+dfsg1-1+deb12u1 && \
    apt-get upgrade -y --no-install-recommends && \
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
CMD ["npm","start"]