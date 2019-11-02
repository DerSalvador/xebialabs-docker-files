#!/bin/bash
CONTAINER="${container.name}"

case "$CONTAINER" in 
	*jboss*)
                URL="${deployedApplication.environment.dictionaries[0].entries['PETSTORE_SMOKETEST_URL']}"
		if [ -z "$URL" ]
		then
		    echo "usage: smoketest.sh <url>"
		    exit 1
		fi

		status=`curl --silent --head $URL | head -1 | cut -f 2 -d' '`

		if [ "$status" != "200" ]
		then
		    echo "status was other than '200': was '$status'"
		    exit 1
		else
		   echo "Smoke Test Successful with Code: $status"
		fi
	;;
	*)  echo "No smoke test for container $CONTAINER"
	;;
esac
