<?xml version="1.0" encoding="UTF-8"?>
<xl:export xmlns:xl="http://www.xebialabs.com/xl-export">
  <xl:metadata>
    <xl:exported-by>admin</xl:exported-by>
    <xl:exported-at>2019-10-04T13:04:27.009+0000</xl:exported-at>
    <xl:exported-format-version>9.0.5</xl:exported-format-version>
    <xl:encryption-key-fingerprint>75a69783f7141d2adfa359690aeaf03facaa3f7d</xl:encryption-key-fingerprint>
  </xl:metadata>
  <xl:exported-configuration-items exported-root-id="Environments">
    <udm.Environment id="Environments/UAT" created-by="admin" created-at="2019-10-04T11:09:40.520+0000" last-modified-by="admin" last-modified-at="2019-10-04T11:09:40.520+0000">
      <members>
        <ci ref="Infrastructure/mac/jboss.local" />
        <ci ref="Infrastructure/mac/jboss.{{clusteraddress}}.nip.io" />
        <ci ref="Infrastructure/mac/jboss.{{clusteraddress}}.xip.io" />
        <ci ref="Infrastructure/mac/mac-jboss" />
        <ci ref="Infrastructure/mac" />
      </members>
      <dictionaries />
      <triggers />
    </udm.Environment>
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
    <jbossdm.StandaloneServer id="Infrastructure/mac/jboss.local" created-by="admin" created-at="2019-10-04T11:09:33.237+0000" last-modified-by="admin" last-modified-at="2019-10-04T11:24:12.735+0000">
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
      <password>{aes:v0}1A1EPf/FBq+p2IuFvvXZiVh+MpnjrQUtuymBxPhH3P0=</password>
      <cliScriptPrefix>jboss-cli</cliScriptPrefix>
    </jbossdm.StandaloneServer>
  </xl:exported-configuration-items>

</xl:export>