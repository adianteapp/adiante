# Use a base image of Node.js
FROM node:18

# Set the working directory inside the container
WORKDIR /:

# Copy the rest of the application files to the working directory
COPY . .

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the application dependencies
RUN npm  install -g typescript

# Compile the TypeScript code to JavaScript
RUN npm run build

# Define the command that will run when the container starts
CMD ["npm", "start"]

# To build the image, run: docker build -t adnt/adiante-patient-backend .