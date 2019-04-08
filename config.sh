# Configuration file for chromogen (gen.sh)
# This file descripes how to generate a gallery.

# (string) Read images from this path
SOURCE_DIR="input"

# (string) Create this directory and generate gallery inside it
DESTINATION_DIR="out"

# (true/false) Create a package (bundle.zip) containing all full-size images and place download-link at top of gallery.
ALLOW_DOWNLOAD_BUNDLE=true

# (number, 0 or larger) Cut first N characters from filename, useful if files in SOURCE_DIR are ordered by filename, set to 4 if your files are named like '000_test.jpg', set to 0 to disable.
CUT_FIRST_CHARACTERS=0

# (true/false) Show alt text in img text (Text will be: Artwork FILENAME)
SHOW_ALT_TEXT=true

# Note, all following strings are used in sed command lines, some special characters will break the script, I don't care, fix it if you want to.
TITLE="Website title text"
HEADER="Gallery"
META_TEXT="Text for search engines"

# (number) Resize preview images to this number of pixels if they are larger
PRE_SIZE_PIX=1166400
# (number) JPEG compression quality for preview images(100=highest)
PRE_JPEG_QUALITY=74

# (true/false) Copy full-size images (no compression/resize, ignore SIZE/QUALITY below if true)
# NOTE: When true, you should use only JPEG files, because the script will force jpg extension on copied filenames, and I don't care.
FULL_QUALITY=false
# (number) Resize full-size images to this number of pixels if they are larger
FULL_SIZE_PIX=8847360
# (number) JPEG compression quality for full-size images(100=highest)
FULL_JPEG_QUALITY=87

# (string) Filename of generated bundle for downloading all files (if enabled)
# The default value is: "gallery-`date +%Y-%m-%d`.zip" This will generate a file-name like 'gallery-2019-04-08.zip'
BUNDLE_NAME="gallery-`date +%Y-%m-%d`.zip"