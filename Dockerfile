FROM fluent/fluentd:v1.2-onbuild

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
USER root

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install \
         fluent-plugin-kubernetes_metadata_filter \
         fluent-plugin-concat \
         fluent-plugin-kafka \
         fluent-plugin-rewrite-tag-filter \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.4.0/cache/*.gem
           
COPY entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh
