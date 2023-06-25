# Use a base image of Node.js
FROM node:latest

# Set the working directory inside the container
WORKDIR /

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the application dependencies
RUN npm install

# Copy the rest of the application files to the working directory
COPY . .

# Compile the TypeScript code to JavaScript
RUN npm run build

# Define the command that will run when the container starts
CMD ["node", "index.js"]
