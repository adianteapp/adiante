# Use a base image of Node.js
FROM node:18

# Set the environment variable to use the legacy provider for OpenSSL
ENV NODE_OPTIONS="--openssl-legacy-provider"

# Set the working directory inside the container
WORKDIR /:

# Copy the rest of the application files to the working directory
COPY . .

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the application dependencies
RUN npm  install

# Install the Vue CLI
RUN npm install -g @vue/cli-service

# Install the Vue compiler
RUN npm install -g @vue/compiler-sfc

RUN npm install path-browserify os-browserify

# Compile the TypeScript code to JavaScript
RUN npm run build

# Define the command that will run when the container starts
CMD ["npm", "run","serve"]