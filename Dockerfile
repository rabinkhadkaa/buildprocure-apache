# Base Apache image
FROM httpd:2.4

# Enable required Apache modules
RUN sed -i '/LoadModule proxy_module/s/^#//g' conf/httpd.conf && \
    sed -i '/LoadModule proxy_fcgi_module/s/^#//g' conf/httpd.conf && \
    sed -i '/LoadModule ssl_module/s/^#//g' conf/httpd.conf && \
    sed -i '/LoadModule headers_module/s/^#//g' conf/httpd.conf

# Copy custom Apache config
COPY apache-config.conf /usr/local/apache2/conf/httpd.conf

# Copy SSL certificates
COPY cert/ /usr/local/apache2/conf/ssl/

# Expose ports
EXPOSE 80 443

CMD ["httpd-foreground"]
