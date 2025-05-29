#!/bin/bash
#
# Execute this file in the directory where you want to create templates.
# For every file * containing "templatable" contents in that directory and subdirectories, a template file *.template will be created,
#   if there is none already.
# Files are considered to have "templatable contents" if they contain the domain name of the online services of this project.
# Files added to git are not considered. Git-ignore them if you want to replace them with templates.

grep -lr 'onto-deside.ilabt.imec.be/' . | while read f
do
  if (git ls-files --error-unmatch $f >> /dev/null 2>&1) ; then
    echo "File $f is added to git; skipping!"
  elif [[ -f $f.template ]] ; then
    echo "File $f.template already exists; skipping!"
  else
    echo "Creating $f.template"
    # Heredoc with EOF in quotes to avoid variable expansion!
    cat << 'EOF' | sed -f - $f > $f.template
s|https://onto-deside.ilabt.imec.be/css12|${OD_CSS12_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css11|${OD_CSS11_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css10|${OD_CSS10_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css9|${OD_CSS9_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css8|${OD_CSS8_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css7|${OD_CSS7_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css6|${OD_CSS6_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css5|${OD_CSS5_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css4|${OD_CSS4_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css3|${OD_CSS3_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css2|${OD_CSS2_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css1|${OD_CSS1_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css0|${OD_CSS0_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/css-test|${OD_CSS_TEST_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/viewer|${OD_VIEWER_BASE_URL}|g
s|https://onto-deside.ilabt.imec.be/webclient|${OD_WEBCLIENT_BASE_URL}|g
EOF
  fi
done