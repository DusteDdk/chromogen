#!/bin/bash

if [ "$1" == "" ]
then
	CONF_FILE="`pwd`/config.sh"
else
	CONF_FILE="$1"
fi

if [ ! -f "$CONF_FILE" ]
then
	echo "Configuration file '$CONF_FILE' not found."
	exit 1
fi

source config.sh

if [ ! -d "$SOURCE_DIR" ]
then
	echo "Can not read images from '$SOURCE_DIR', it does not exist."
	exit 1
elif [ $(ls "$SOURCE_DIR" | wc -l) == "0" ] 
then
	echo "Source directory '$SOURCE_DIR' is empty..."
	exit 1
fi

#Files
declare -a pics

#Find files
pushd "$SOURCE_DIR" &> /dev/null
for F in *
do
	pics=("${pics[@]}" "$F")
done
popd &> /dev/null

if [ -d $DESTINATION_DIR ]
then
	echo "Output directory '$DESTINATION_DIR' exists, will not overwrite."
	exit 1
else
	mkdir "$DESTINATION_DIR" "$DESTINATION_DIR/pre" "$DESTINATION_DIR/full"
fi

ALT=""
LIST=""
C=0
echo "Processing images..."
for F in ${pics[@]}
do
	((C++))
	N="${F%.*}"
	N="${N:$CUT_FIRST_CHARACTERS}"
	NF="${N}.jpg"
	EX="${F##*.}"
	echo $F...
	convert -resize $PRE_SIZE_PIX@\> -quality $PRE_JPEG_QUALITY% -strip "$SOURCE_DIR/$F" $DESTINATION_DIR/pre/$NF
	if $FULL_QUALITY
	then
		cp "$SOURCE_DIR/$F" $DESTINATION_DIR/full/$NF
	else
		convert -resize $FULL_SIZE_PIX@\> -quality $FULL_JPEG_QUALITY% -strip "$SOURCE_DIR/$F" $DESTINATION_DIR/full/$NF
	fi
	if $SHOW_ALT_TEXT
	then
		ALT=" alt=\"Artwork $N\""
	fi
	LIST="$LIST<a href=\"full/$NF\" name=\"$N\"><img src=\"pre/$NF\" class=\"art\"$ALT></a>"

done


BUNDLE=""

if $ALLOW_DOWNLOAD_BUNDLE
then
	pushd $DESTINATION_DIR &> /dev/null
	echo "Generating bundle..."
	zip -r -1 -q "$BUNDLE_NAME" full
	SIZE=`du -h "$BUNDLE_NAME" | cut -f 1`
	BUNDLE='<div class="bundle"><a class="bundle" href="'$BUNDLE_NAME'">Download all '$C' images ( '$SIZE' \)<\/a><\div>'
	popd &> /dev/null
fi

echo "Generating index..."


cp base/index.html $DESTINATION_DIR/index.html
echo -e "$LIST" > temp
sed -i 's/\./\\./g' temp
sed -i "s/__title__/$TITLE/g" "$DESTINATION_DIR/index.html"
sed -i "s/__header__/$HEADER/g" "$DESTINATION_DIR/index.html"
sed -i "s/__bundle__/$BUNDLE/g" "$DESTINATION_DIR/index.html"
sed -i "s/__meta_text__/$META_TEXT/g" "$DESTINATION_DIR/index.html"
sed -i "s/__list__/$(sed 's:/:\\/:g' temp)/" "$DESTINATION_DIR/index.html"
rm temp

echo "Copying supporting files..."
cp base/style.css "$DESTINATION_DIR/"
cp base/favicon.ico "$DESTINATION_DIR/"
cp base/bg.png "$DESTINATION_DIR/"
