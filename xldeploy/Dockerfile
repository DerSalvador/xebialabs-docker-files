FROM xebialabs/xl-deploy:9.0.5-centos
COPY logback.xml /opt/xebialabs/xl-deploy-server/conf
# COPY deployit-license.lic /opt/xebialabs/xl-deploy-server/conf
RUN cat /opt/xebialabs/xl-deploy-server/conf/logback.xml
ENTRYPOINT ["/opt/xebialabs/tini","--","/opt/xebialabs/xl-deploy-server/bin/run-in-container.sh"]
