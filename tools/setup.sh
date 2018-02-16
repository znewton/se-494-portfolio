#!/bin/bash

# global yarn installs
packages=( "browserify" "uglify-js" "watchify" )
for package in "${packages[@]}"; do
  sudo yarn global add "$package"
done
