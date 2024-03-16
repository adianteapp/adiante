# Use a base image of Node.js
FROM node:18

# Set the environment variable to use the legacy provider for OpenSSL
ENV NODE_OPTIONS="--openssl-legacy-provider"

# Set the working directory inside the container
WORKDIR /:


# Set the environment variables
ENV VUE_APP_BACKEND_BASE_URL=http://localhost:8082/adiante/patient

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


# Compile the TypeScript code to JavaScript
RUN npm run build

# Define the command that will run when the container starts
CMD ["npm", "run","serve"]

## To build the image run: docker buil  d -t adnt/adiante-patient .