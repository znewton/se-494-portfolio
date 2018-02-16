#!/bin/bash

if [ ! "$0" = "./tools/sass.sh" ]; then
  echo "Please run './tools/sass.sh' from the project directory."
  exit
fi
PROJECT_DIR="`pwd`"

STYLE="$PROJECT_DIR/lib/index.scss"
BUILD="$PROJECT_DIR/public/styles.css"

if [ -f "$BUILD" ]; then
  rm "$BUILD"
fi
touch "$BUILD"
if [ -f "$STYLE" ]; then
  rm "$STYLE"
fi
touch "$STYLE"

# clear file
> "$STYLE"

cd "$PROJECT_DIR/lib"
for file in styles/*
do
  echo "@import \"$(sed 's/_//' <<< "${file%.*}")\";" >> "$STYLE"
done
cd $PROJECT_DIR

if [ $1 == "-b" ]; then
  sass "$STYLE" "$BUILD"
else
  sass --watch "$STYLE":"$BUILD"
fi
