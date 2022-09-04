FROM ubuntu:20.04

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y inotify-tools nginx pandoc python3 python-is-python3 && \
    sed -i 's@root /var/www/html@root /doc/public@' /etc/nginx/sites-available/default
COPY . /doc
RUN bash -c "sed -i 's/\r//g' /doc/{generator/,}*.sh"
WORKDIR /doc

EXPOSE 80

ENV REQUIRE_NGINX=yes
CMD ["/doc/watch-and-rebuild.sh"]
