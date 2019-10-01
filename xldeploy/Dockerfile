FROM xebialabs/xl-deploy:9.0.5-centos
USER root
COPY conf /opt/xebialabs/xl-deploy-server/conf
COPY conf/logback.xml /opt/xebialabs/xl-deploy-server/conf
COPY conf/deployit-license.lic /opt/xebialabs/xl-deploy-server/conf
COPY conf/deployit.conf /opt/xebialabs/xl-deploy-server/conf
RUN find /opt/xebialabs/xl-deploy-server/conf

ENTRYPOINT ["/opt/xebialabs/tini","--","/opt/xebialabs/xl-deploy-server/bin/run-in-container.sh"]
