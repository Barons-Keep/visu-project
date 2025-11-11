#!/bin/bash
gm-cli install
gm-cli sync
rm -rf ./yyp/datafiles/track
cp -rv ./gm_modules/track/resource/datafiles/track/ ./yyp/datafiles/track/
cp -rf ./gm_modules/visu/resource/sound/sfx ./yyp/datafiles