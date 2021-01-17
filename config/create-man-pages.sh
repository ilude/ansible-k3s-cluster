#!/bin/bash
sudo apk update
sudo apk add --no-cache mandoc man-pages less less-doc

# https://georgegarside.com/blog/technology/alpine-linux-install-all-man-pages/
sudo apk list -I |
  sed -rn '/-doc/! s/([a-z-]+[a-z]).*/\1/p' |
  awk '{ print system("apk info \""$1"-doc\" > /dev/null") == 0 ? $1 "-doc" : "" }' |
  xargs sudo apk add