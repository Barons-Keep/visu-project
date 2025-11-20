#!/bin/bash -ex

# arguments
CLEAN_GM_MODULES=false
EDITOR_ENABLED=false

# parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
  -c|--clean)
    CLEAN_GM_MODULES=true
    shift
    ;;
  -e|--editor)
    EDITOR_ENABLED=true
    shift
    ;;
  *)
    echo "Unknown option: $1"
    exit 1
    ;;
  esac
done

# init gm_modules
if [[ "$CLEAN_GM_MODULES" == true ]]; then
  echo "Remove gm_modules"
  rm -rf ./gm_modules
fi
gm-cli install

# remove visu editor files form gm_modules
if [[ "$EDITOR_ENABLED" == false ]]; then
  echo "Remove editor sources"
  find "./gm_modules/visu/src/editor" -type f -name "*.gml" | while read -r file; do
    : > "$file"
    echo "Emptied: $file"
  done
fi

# sync gm_modules with yyp
gm-cli sync

# install track in yyp
rm -rf ./visu-project/yyp/datafiles/track
cp -rv ./gm_modules/track/resource/datafiles/track/ ./visu-project/yyp/datafiles/track/

