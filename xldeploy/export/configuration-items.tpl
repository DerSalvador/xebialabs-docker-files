<?xml version="1.0" encoding="UTF-8"?>
<xl:export xmlns:xl="http://www.xebialabs.com/xl-export">
  <xl:metadata>
    <xl:exported-by>admin</xl:exported-by>
    <xl:exported-at>2019-10-04T13:04:27.009+0000</xl:exported-at>
    <xl:exported-format-version>9.0.5</xl:exported-format-version>
    <xl:encryption-key-fingerprint>75a69783f7141d2adfa359690aeaf03facaa3f7d</xl:encryption-key-fingerprint>
  </xl:metadata>
  <xl:exported-configuration-items exported-root-id="Environments">
    <udm.Environment id="Environments/PRD" created-by="admin" created-at="2019-10-04T11:09:40.520+0000" last-modified-by="admin" last-modified-at="2019-10-04T11:09:40.520+0000">
      <members>
        <!--ci ref="Infrastructure/mac/jboss.local" /-->
        <!--ci ref="Infrastructure/mac/jboss.{{clusteraddress}}.nip.io" /-->
        <ci ref="Infrastructure/mac/jboss.{{clusteraddress}}.xip.io" />
        <ci ref="Infrastructure/mac" />
      </members>
      <triggers />
      <dictionaries>
        <ci ref="Environments/PRD_DICT" />
      </dictionaries>
      <triggers>
        <ci ref="Configuration/FailedStepTrigger" />
      </triggers>
      <smtpServer ref="Configuration/PRD_SMTP_SERVER" />
    </udm.Environment>
    <udm.Dictionary id="Environments/PRD_DICT" created-by="admin" created-at="2019-10-10T08:03:55.409+0000" last-modified-by="admin" last-modified-at="2019-10-10T08:03:55.409+0000">
        <restrictToContainers />
        <restrictToApplications />
        <entries>
          <entry key="JBOSS_HOME">/opt/jboss/wildfly</entry>
          <entry key="message">Hello PRD ZKB!</entry>
        </entries>
        <encryptedEntries />
    </udm.Dictionary>
    <udm.Environment id="Environments/UAT" created-by="admin" created-at="2019-10-04T11:09:40.520+0000" last-modified-by="admin" last-modified-at="2019-10-04T11:09:40.520+0000">
      <members>
        <!--ci ref="Infrastructure/mac/jboss.local" /-->
        <!--ci ref="Infrastructure/mac/jboss.{{clusteraddress}}.nip.io" /-->
        <ci ref="Infrastructure/mac/jboss.{{clusteraddress}}.xip.io" />
        <ci ref="Infrastructure/mac" />
      </members>
      <triggers />
      <dictionaries>
        <ci ref="Environments/UAT_DICT" />
      </dictionaries>
      <triggers>
        <ci ref="Configuration/FailedStepTrigger" />
      </triggers>
      <smtpServer ref="Configuration/UAT_SMTP_SERVER" />
    </udm.Environment>
    <udm.Dictionary id="Environments/UAT_DICT" created-by="admin" created-at="2019-10-10T08:03:55.409+0000" last-modified-by="admin" last-modified-at="2019-10-10T08:03:55.409+0000">
        <restrictToContainers />
        <restrictToApplications />
        <entries>
          <entry key="JBOSS_HOME">/opt/jboss/wildfly</entry>
          <entry key="message">Hello UAT ZKB!</entry>
        </entries>
        <encryptedEntries />
    </udm.Dictionary>
  </xl:exported-configuration-items>
  <xl:exported-configuration-items exported-root-id="Infrastructure">
    <overthere.SshHost id="Infrastructure/mac" created-by="admin" created-at="2019-10-04T11:09:33.237+0000" last-modified-by="admin" last-modified-at="2019-10-04T11:09:33.237+0000">
      <tags>
        <value>petstore</value>
      </tags>
      <os>UNIX</os>
      <puppetPath>/usr/local/bin</puppetPath>
      <connectionType>INTERACTIVE_SUDO</connectionType>
      <address>{{hostip}}</address>
      <port>22</port>
      <username>root</username>
      <privateKeyFile>/opt/xebialabs/xl-deploy-server/id_rsa</privateKeyFile>
      <sudoUsername>root</sudoUsername>
    </overthere.SshHost>
 <jbossdm.StandaloneServer id="Infrastructure/mac/jboss.local" created-by="admin" created-at="2019-10-14T17:16:21.755+0000" last-modified-by="admin" last-modified-at="2019-10-14T17:16:21.755+0000">
      <tags>
        <value>petstore</value>
      </tags>
      <home>/opt/jboss/wildfly</home>
      <port>9990</port>
      <enableDaemon>true</enableDaemon>
      <commandExecutionMode>CLI_COMMANDS</commandExecutionMode>
      <adminHostAddress>192.168.1.20</adminHostAddress>
      <username>admin</username>
      <password>{aes:v0}3ZY/noV0UTCzbX2xGqbiVjoXmgbdslV18UMM5XTI5As=</password>
      <cliScriptPrefix>jboss-cli</cliScriptPrefix>
    </jbossdm.StandaloneServer>
    <jbossdm.StandaloneServer id="Infrastructure/mac/jboss.{{clusteraddress}}.nip.io" created-by="admin" created-at="2019-10-04T11:09:33.237+0000" last-modified-by="admin" last-modified-at="2019-10-04T11:24:12.735+0000">
      <tags>
        <value>petstore</value>
      </tags>
      <home>/opt/jboss/wildfly</home>
      <port>80</port>
      <enableDaemon>true</enableDaemon>
      <commandExecutionMode>CLI_COMMANDS</commandExecutionMode>
      <adminHostAddress>jboss.{{clusteraddress}}.nip.io</adminHostAddress>
      <username>admin</username>
      <password>{aes:v0}wyoI5G4fDaNgUEqg7bSm9rX2BZoGVdss+EZwMZ1NWeI=</password>
      <cliScriptPrefix>jboss-cli</cliScriptPrefix>
    </jbossdm.StandaloneServer>
    <jbossdm.StandaloneServer id="Infrastructure/mac/jboss.{{clusteraddress}}.xip.io" created-by="admin" created-at="2019-10-04T11:24:45.007+0000" last-modified-by="admin" last-modified-at="2019-10-04T11:25:19.683+0000">
      <tags>
        <value>petstore</value>
      </tags>
      <home>/opt/jboss/wildfly</home>
      <port>80</port>
      <enableDaemon>true</enableDaemon>
      <commandExecutionMode>CLI_COMMANDS</commandExecutionMode>
      <adminHostAddress>jboss.{{clusteraddress}}.xip.io</adminHostAddress>
      <username>admin</username>
      <password>{aes:v0}E06DkSRjreo6Q5NDOopPNqpbj8EQLSbQrbkBWnLO5Nc=</password>
      <cliScriptPrefix>jboss-cli</cliScriptPrefix>
    </jbossdm.StandaloneServer>
    <jbossdm.StandaloneServer id="Infrastructure/mac/mac-jboss" created-by="admin" created-at="2019-10-04T11:09:33.237+0000" last-modified-by="admin" last-modified-at="2019-10-04T11:09:33.237+0000">
      <tags>
        <value>petstore</value>
      </tags>
      <home>/opt/jboss/wildfly</home>
      <port>9990</port>
      <enableDaemon>true</enableDaemon>
      <commandExecutionMode>CLI_COMMANDS</commandExecutionMode>
      <adminHostAddress>{{hostip}}</adminHostAddress>
      <username>admin</username>
      <password>{aes:v0}wyoI5G4fDaNgUEqg7bSm9rX2BZoGVdss+EZwMZ1NWeI=</password>
      <cliScriptPrefix>jboss-cli</cliScriptPrefix>
    </jbossdm.StandaloneServer>
  </xl:exported-configuration-items>
<xl:exported-configuration-items exported-root-id="Configuration">
    <trigger.EmailNotification id="Configuration/FailedEmailAction" created-by="admin" created-at="2019-10-20T09:57:44.551+0000" last-modified-by="admin" last-modified-at="2019-10-20T10:17:06.059+0000">
      <toAddresses>
        <value>filekeys@gmail.com</value>
      </toAddresses>
      <fromAddress>mellouk@filekeys.com</fromAddress>
      <subject>Application ${deployedApplication.version.application.name} failed.</subject>
      <sendContentAsHtml>true</sendContentAsHtml>
      <body>&lt;h1&gt;Deployment of ${deployedApplication.version.application.name} has failed on environment ${deployedApplication.environment.name}&lt;/h1&gt;</body>
      <mailServer ref="Configuration/UAT_SMTP_SERVER" />
    </trigger.EmailNotification>
    <trigger.StepTrigger id="Configuration/FailedStepTrigger" created-by="admin" created-at="2019-10-20T10:00:26.715+0000" last-modified-by="admin" last-modified-at="2019-10-20T10:00:26.715+0000">
      <actions>
        <ci ref="Configuration/FailedEmailAction" />
      </actions>
      <fromState>ANY</fromState>
      <toState>FAILED</toState>
    </trigger.StepTrigger>
    <mail.SmtpServer id="Configuration/PRD_SMTP_SERVER" created-by="admin" created-at="2019-10-10T13:58:44.481+0000" last-modified-by="admin" last-modified-at="2019-10-10T13:59:42.972+0000">
      <host>smtp.eu.mailgun.org</host>
      <port>587</port>
      <username>postmaster@io.brokerme.club</username>
      <password>{aes:v0}vpgjyY2K+kVIc1WiTppUjJKIK+TJLBzIziz1E2TGG+s=</password>
      <fromAddress>postmaster@io.brokerme.club</fromAddress>
      <testAddress>filekeys@gmail.com</testAddress>
      <smtpProperties />
    </mail.SmtpServer>
    <mail.SmtpServer id="Configuration/UAT_SMTP_SERVER" created-by="admin" created-at="2019-10-10T13:58:44.481+0000" last-modified-by="admin" last-modified-at="2019-10-10T13:59:42.972+0000">
      <host>mail.filekeys.com</host>
      <port>25</port>
      <username>mellouk</username>
      <password>{aes:v0}vpgjyY2K+kVIc1WiTppUjJKIK+TJLBzIziz1E2TGG+s=</password>
      <fromAddress>mellouk@filekeys.com</fromAddress>
      <testAddress>filekeys@gmail.com</testAddress>
      <smtpProperties />
    </mail.SmtpServer>
  </xl:exported-configuration-items>
</xl:export>
