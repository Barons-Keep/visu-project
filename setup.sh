#!/bin/bash -e

echo -e "\n\n⬆️  Setup is starting\n===================="

# arguments
EDITOR_ENABLED=false
DEV_TOOLS=false
VERBOSE=""

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
  -v|--verbose)
    VERBOSE="-v"
    shift
    ;;
  *)
    echo -e "\nUnknown option: $1\n"
    exit 1
    ;;
  esac
done

# sync yyp with gm_modules
echo -e "\n🌐 Sync yyp with gm_modules\n==========================="
gm-cli sync

# remove visu editor files form gm_modules
if [[ "$EDITOR_ENABLED" == false ]]; then
  echo -e "\n🗑️  Remove editor sources\n========================"
  find "./gm_modules/visu/src/editor" -type f -name "*.gml" | while read -r file; do
    : > "$file"
  #if [[ "$VERBOSE" == "-v" ]]; then
    echo -e "📄 Emptied: $file"
  #fi
  done
fi

# install track in yyp
echo -e "\n🔧 Install track folder\n========================"
rm -rf ./yyp/datafiles/track
cp -r $VERBOSE ./gm_modules/track/resource/datafiles/track/ ./yyp/datafiles/track/
ls -1 ./yyp/datafiles/track/

# install dev tools
if [[ "$DEV_TOOLS" == true ]]; then
  echo -e "\n🔨 Install dev tools\n===================="
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/README.md ./yyp/datafiles
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/package-gm.json ./yyp/datafiles
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/setup.sh ./yyp/datafiles
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/log.sh ./yyp/datafiles
  ls -1 ./yyp/datafiles
fi

echo -e "\n\n✅ The setup is finished\n========================"
