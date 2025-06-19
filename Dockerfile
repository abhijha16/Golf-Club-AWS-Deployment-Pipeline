# Use the Official Nginx image
FROM nginx:alpine

# Remove the default Nginx Static Content
RUN rm -rf /usr/share/nginx/html/*

# Copying My Website Files to the Container
COPY . /usr/share/nginx/html

# Expose Port 80 (default for HTTP)
EXPOSE 80

# No need to define CMD - Nginx starts automatically
