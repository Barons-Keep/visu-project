#!/bin/bash -ex

# arguments
EDITOR_ENABLED=false
DEV_TOOLS=false

# parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
  -e|--editor)
    EDITOR_ENABLED=true
    shift
    ;;
  -d|--devtools)
    DEV_TOOLS=true
    shift
    ;;
  *)
    echo "Unknown option: $1"
    exit 1
    ;;
  esac
done

# sync yyp with gm_modules
echo "\n🌐 Sync yyp with gm_modules\n==========================="
gm-cli sync

# remove visu editor files form gm_modules
if [[ "$EDITOR_ENABLED" == false ]]; then
  echo "\n🗑️ Remove editor sources\n========================"
  find "./gm_modules/visu/src/editor" -type f -name "*.gml" | while read -r file; do
    : > "$file"
    echo "   Emptied: $file"
  done
fi

# install track in yyp
echo "\n🔧 Install track folder\n========================"
rm -rf ./yyp/datafiles/track
cp -rv ./gm_modules/track/resource/datafiles/track/ ./yyp/datafiles/track/

# install dev tools
if [[ "$DEV_TOOLS" == true ]]; then
  echo "\n🔧 Install dev tools\n===================="
  cp -rv ./gm_modules/visu/resource/datafiles/README.md ./yyp/datafiles
  cp -rv ./gm_modules/visu/resource/datafiles/package-gm.json ./yyp/datafiles
  cp -rv ./gm_modules/visu/resource/datafiles/setup.sh ./yyp/datafiles
  cp -rv ./gm_modules/visu/resource/datafiles/log.sh ./yyp/datafiles
fi