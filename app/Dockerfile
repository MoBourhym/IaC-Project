# Use the official Node.js image as the base
FROM node:16

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the app code
COPY app.js ./

# Create a default .env file if one is not provided during deployment
RUN echo "APP_VERSION=v 1.0" > .env && \
    echo "PORT=3000" >> .env

# Expose the port your app runs on
EXPOSE 3000

# Command to run the app
CMD ["node", "app.js"]