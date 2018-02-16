#!/bin/bash

if [ ! "$0" = "./tools/js.sh" ]; then
  echo "Please run './tools/js.sh' from the project directory."
  exit
fi
PROJECT_DIR="`pwd`"

SCRIPT="$PROJECT_DIR/lib/index.js"
BUILD="$PROJECT_DIR/public/bundle.min.js"

if [ -f "$BUILD" ]; then
  rm "$BUILD"
fi
touch "$BUILD"
if [ -f "$SCRIPT" ]; then
  rm "$SCRIPT"
fi
touch "$SCRIPT"

# clear file
> "$SCRIPT"

cd "$PROJECT_DIR/lib"
for file in js/*
do
  echo "require('${file%.*}');"
done
cd $PROJECT_DIR

cat "$SCRIPT"

if [ "$1" = "-b" ]; then
  browserify "$SCRIPT" -o "uglifyjs -cm > $BUILD"
else
  watchify "$SCRIPT" -o "uglifyjs -cm > $BUILD"
fi
