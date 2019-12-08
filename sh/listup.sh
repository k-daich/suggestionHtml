#!/bin/bash

### constants Define Area
ROOT_DIR=`cd ../; pwd`
SH_DIR=${ROOT_DIR}/sh
DATA_THEME_DIR=${ROOT_DIR}/data/theme
BKUP_HTML_DIR=${SH_DIR}/bkup
HTML_PARTS_DIR=${SH_DIR}/html_parts
SUGGESTION_HTML_PATH=${ROOT_DIR}/suggestion.html
HTML_DYNAMIC_PARTS_2_2=${HTML_PARTS_DIR}/2.2_theme_dynamicContents.html


### functions Define Area
function bakup_html() {
    DATE_STR=`date +%H:%M:%S`
    cp -p ${SUGGESTION_HTML_PATH} ${BKUP_HTML_DIR}/suggestion.html_${DATE_STR}
}

### 
# 第一引数: 結果出力するファイルパス
function generate_theme_contents() {
    OUTPUT_PATH=$1
    # 出力対象ファイルを空ファイル化
    echo "" > ${OUTPUT_PATH}
    
    for i in `ls ${DATA_THEME_DIR}` ; do
        NAME=`echo ${i} | sed "s/^[^_]*_//"`
        echo '<option value="'$NAME'">'$NAME'</option>' >> ${OUTPUT_PATH}
    done
}

function add_theme() {
    ADD_LINE_NUM=`grep -n id=\"addedByShell_theme\"  ../suggestion.html | sed 's/:.*//'`
    sed -e "${ADD_LINE_NUM} a testAddLine" ${SUGGESTION_HTML_PATH}
}

function writeup_html() {
    cd ${HTML_PARTS_DIR}
    ls | xargs cat > ${SUGGESTION_HTML_PATH}
}

### main area
# copy for back up
bakup_html

# generate dynamic contents
# generate theme contents
generate_theme_contents ${HTML_DYNAMIC_PARTS_2_2}



# adding Thema
writeup_html


