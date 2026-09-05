#!/bin/bash -e

#param {string} directory_path
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

#param {string} context_path
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
PACKAGE_GM="package-gm.json"
VERBOSE=""
EDITOR_ENABLED=false
DEV_TOOLS=false


# parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
  -P|--package)
    PACKAGE_GM="$2"
    shift 2
    ;;
  -v|--verbose)
    VERBOSE="-v"
    shift
    ;;
  -e|--editor)
    EDITOR_ENABLED=true
    shift
    ;;
  -d|--devtools)
    DEV_TOOLS=true
    shift
    ;;
  *)
    echo -e "\nUnknown option: $1\n"
    exit 1
    ;;
  esac
done


# setup env
PACKAGE_PATH=$(realpath $PACKAGE_GM)
PACKAGE_HOME=$(dirname $PACKAGE_PATH)
PACKAGE_NAME=$(basename $PACKAGE_PATH)
MAIN_PATH=$(jq -r '.main' $PACKAGE_PATH)
MAIN_HOME=$(dirname $MAIN_PATH)
echo "PACKAGE_GM: $PACKAGE_GM"
echo "VERBOSE: $VERBOSE"
echo "EDITOR_ENABLED: $EDITOR_ENABLED"
echo "DEV_TOOLS: $DEV_TOOLS"
echo "PACKAGE_PATH: $PACKAGE_PATH"
echo "MAIN_PATH: $MAIN_PATH"

cd $PACKAGE_HOME


# sync yyp with gm_modules
echo -e "\n🌐 Sync yyp with gm_modules\n==========================="
gm-cli -P $PACKAGE_NAME sync


# remove visu editor files form gm_modules
SCRIPT_HOME=$(realpath "$MAIN_HOME/scripts")
if [[ "$EDITOR_ENABLED" == false ]]; then
  echo -e "\n🗑️  Remove editor sources\n========================"
  find "./gm_modules/visu/src/editor" -type f -name "*.gml" | while read -r source_file; do
    file_name="${source_file##*/}"
    script_name=${file_name//.gml/}
    script_path=$(realpath "$SCRIPT_HOME/$script_name/$file_name")
    : > $script_path
    echo -e "📄 Emptied: $file_name"
  done
fi


# install track in yyp
echo -e "\n🔧 Install track folder\n======================="
rm -rf ./yyp/datafiles/track
TRACK_HOME=$(realpath "$MAIN_HOME/datafiles/track/")
cp -r $VERBOSE ./gm_modules/track/resource/datafiles/track/ $TRACK_HOME
list_directory $TRACK_HOME


# install dev tools
DATAFILES_HOME=$(realpath "$MAIN_HOME/datafiles")
if [[ "$DEV_TOOLS" == true ]]; then
  echo -e "\n🔨 Install dev tools\n===================="
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/log.sh $DATAFILES_HOME
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/package-gm.json $DATAFILES_HOME
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/README.md $DATAFILES_HOME
  cp -r $VERBOSE ./gm_modules/visu/resource/datafiles/setup.sh $DATAFILES_HOME
  list_directory $DATAFILES_HOME
else
  if [[ -e "$DATAFILES_HOME/log.sh" ||
        -e "$DATAFILES_HOME/package-gm.json" ||
        -e "$DATAFILES_HOME/README.md" ||
        -e "$DATAFILES_HOME/setup.sh" ]]; then
    echo -e "\n🗑️  Remove dev tools\n==================="
  fi
  
  remove $DATAFILES_HOME/log.sh
  remove $DATAFILES_HOME/package-gm.json
  remove $DATAFILES_HOME/README.md
  remove $DATAFILES_HOME/setup.sh
fi


# Generate
echo -e "\n🔨 Generate yyp\n==============="
gm-cli -P $PACKAGE_PATH generate


echo -e "\n\n✅ The setup is finished\n========================"

