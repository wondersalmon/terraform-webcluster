FROM nginx:latest
COPY conf.conf /etc/nginx/conf.d/conf.conf
COPY index.html /usr/share/nginx/html
COPY start-server.sh /usr/local/bin/start-server.sh
RUN chmod +x /usr/local/bin/start-server.sh
CMD ["/usr/local/bin/start-server.sh"]