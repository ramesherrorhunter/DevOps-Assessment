# Use a lightweight Node.js image
FROM node:18-slim

# Set working directory inside the container
WORKDIR /app

# Copy only package.json and package-lock.json first for dependency installation
COPY package*.json ./

# Install dependencies (using cache for unchanged dependencies)
RUN npm install --production

# Copy the rest of the application files
COPY . .

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["node", "server.js"]
