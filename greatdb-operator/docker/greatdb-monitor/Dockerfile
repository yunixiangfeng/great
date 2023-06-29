FROM busybox

ADD init.sh /usr/bin/init.sh
RUN chmod +x /usr/bin/init.sh

COPY dashboards/*.json /tmp/
COPY rules/*.yaml /tmp/
COPY datasources/*.yaml /tmp/
COPY alerts/*.yaml /tmp/

ENTRYPOINT ["/usr/bin/init.sh"]
CMD ["GreatDB-Cluster", "/grafana-dashboard-definitions/greatdb/", "false", "/etc/prometheus"]
