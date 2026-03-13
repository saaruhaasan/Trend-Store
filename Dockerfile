# Use Nginx to serve static files
FROM nginx:alpine

# Copy dist folder into Nginx's default html directory
COPY dist/ /usr/share/nginx/html

# Expose port 3000
EXPOSE 3000

# Override default Nginx config to listen on port 3000
RUN sed -i 's/listen       80;/listen       3000;/' /etc/nginx/conf.d/default.conf

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

