#!/bin/bash
set -e
set -x
# these are travis encrypted in the env section
docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS
echo "$TRAVIS_PULL_REQUEST = $TRAVIS_PULL_REQUEST"
echo "{DOCKERHUB_REPO}\/ = ${DOCKERHUB_REPO}\/"
docker images | grep ${DOCKERHUB_REPO}\/ | grep -v deps | grep -v \<none\> | awk '{print $1 ":" $2}'
if [ "$TRAVIS_PULL_REQUEST" = "false" ]; then
    # l8r also check $TRAVIS_REPO_SLUG so we only push to dockerhub on master
    docker images | grep ${DOCKERHUB_REPO}\/ | grep -v deps | grep -v \<none\> | awk '{print $1 ":" $2}' | xargs docker push
else
    print "No Pushy, TRAVIS_PULL_REQUEST=$TRAVIS_PULL_REQUEST"

fi
