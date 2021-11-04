#!/bin/bash

PRJROOT="$PWD"
GOMAIN="$PWD/cmd/uri-one"

cd $PWD

back() {
  rm -rf $PRJROOT/build/bin/uri-one_*

  go generate ./...

  GO111MODULE=on GOOS=linux GOARCH=amd64 go build -o $PRJROOT/build/bin/uri-one_amd64 $GOMAIN
  GO111MODULE=on GOOS=windows GOARCH=amd64 go build -o $PRJROOT/build/bin/uri-one_windows64.exe $GOMAIN
  GO111MODULE=on GOOS=darwin GOARCH=amd64 go build -o $PRJROOT/build/bin/uri-one_macos $GOMAIN
}

front() {
  cd web && npm ci --no-delete --cache=/tmp && npm run build
}

case $1 in
back)
  back
  ;;
front)
  front
  ;;
*)
  echo "front or back"
  ;;
esac
