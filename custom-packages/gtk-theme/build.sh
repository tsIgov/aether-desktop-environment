#!/bin/sh
set -ueo pipefail
SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
OUTPUT_DIR="$SCRIPT_DIR/out/Igov-GTK"

mkdir -p $OUTPUT_DIR/gtk-3.0/
bash $SCRIPT_DIR/sass/parse-sass.sh $SCRIPT_DIR/sass/gtk3/gtk.scss $OUTPUT_DIR/gtk-3.0/gtk.css
cp -rf $SCRIPT_DIR/assets $OUTPUT_DIR/gtk-3.0

mkdir -p $OUTPUT_DIR/gtk-4.0/assets
bash $SCRIPT_DIR/sass/parse-sass.sh $SCRIPT_DIR/sass/gtk4/gtk.scss $OUTPUT_DIR/gtk-4.0/gtk.css
cp -rf $SCRIPT_DIR/assets $OUTPUT_DIR/gtk-4.0

cp -f $SCRIPT_DIR/index.theme $OUTPUT_DIR/index.theme
