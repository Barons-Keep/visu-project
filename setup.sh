#!/bin/bash -e

function list_directory {
  local directory_path="$1"
  echo -e "🔍 $directory_path"
  find "$directory_path" \
    -maxdepth 1 \
    -mindepth 1 \
    -type d \
    -printf '  📁 %f\n' | sort

  find "$directory_path" \
    -maxdepth 1 \
    -mindepth 1 \
    -type f \
    -printf '  📄 %f\n' | sort
  echo -e ""
}

function remove {
  local context_path="$1"
  local context_name="${context_path##*/}"
  if [ -f $context_path ]; then
    echo -e "📄 Remove: $context_name"
    rm -f $context_path
  elif [ -d context_path ]; then
    echo -e "📁 Remove: $context_name"
    rm -rf $context_path
  fi
}

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
  find "./gm_modules/visu/src/editor" -type f -name "*.gml" | while read -r source_file; do
    file_name="${source_file##*/}"
    script_name=${file_name//.gml/}
    : > ./yyp/scripts/$script_name/$file_name
    echo -e "📄 Emptied: $file_name"
  done
fi

# install track in yyp
echo -e "\n🔧 Install track folder\n======================="
rm -rf ./yyp/datafiles/track
cp -r $VERBOSE ./gm_modules/track/resource/datafiles/track/ ./yyp/datafiles/track/
list_directory ./yyp/datafiles/track/

# install dev tools
if [[ "$DEV_TOOLS" == true ]]; then
  echo -e "\n🔨 Install dev tools\n===================="
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/log.sh ./yyp/datafiles
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/package-gm.json ./yyp/datafiles
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/README.md ./yyp/datafiles
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/setup.sh ./yyp/datafiles
  list_directory ./yyp/datafiles
else
  if [[ -e "./yyp/datafiles/log.sh" ||
        -e "./yyp/datafiles/package-gm.json" ||
        -e "./yyp/datafiles/README.md" ||
        -e "./yyp/datafiles/setup.sh" ]]; then
    echo -e "\n🗑️  Remove dev tools\n==================="
  fi
  
  remove ./yyp/datafiles/log.sh
  remove ./yyp/datafiles/package-gm.json
  remove ./yyp/datafiles/README.md
  remove ./yyp/datafiles/setup.sh
fi

echo -e "\n🔨 Generate yyp\n==============="
gm-cli generate

echo -e "\n\n✅ The setup is finished\n========================"
