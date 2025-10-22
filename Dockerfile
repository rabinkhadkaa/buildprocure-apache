# Base Apache image
FROM httpd:2.4

# Enable required Apache modules
RUN sed -i '/LoadModule proxy_module/s/^#//g' conf/httpd.conf && \
    sed -i '/LoadModule proxy_fcgi_module/s/^#//g' conf/httpd.conf && \
    sed -i '/LoadModule ssl_module/s/^#//g' conf/httpd.conf && \
    sed -i '/LoadModule headers_module/s/^#//g' conf/httpd.conf

# Copy your custom config into "extra" (so it doesn’t overwrite core config)
COPY apache-config.conf /usr/local/apache2/conf/extra/buildprocure.conf

# Include it from the main Apache config
RUN echo "ServerName buildprocure.com" >> /usr/local/apache2/conf/httpd.conf && \
echo "\n# Include BuildProcure configuration\nInclude conf/extra/buildprocure.conf" >> /usr/local/apache2/conf/httpd.conf

# Copy SSL certificates
COPY cert/ /usr/local/apache2/conf/ssl/
COPY . /var/www/html/
# Expose ports
EXPOSE 80 443

CMD ["httpd-foreground"]
