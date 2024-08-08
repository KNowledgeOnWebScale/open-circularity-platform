#!/bin/bash
#
# Execute this file in the directory where you want to create templates.
# For every file * containing "templatable" contents in that directory and subdirectories, a template file *.template will be created,
#   if there is none already.
# Files are considered to have "templatable contents" if they contain the domain name of the online services of this project.

grep -lr '.onto-deside.ilabt.imec.be' . | while read f
do
  if [[ -f $f.template ]] ; then
    echo "File $f.template already exists; skipping!"
  else
    echo "Creating $f.template"
    # Heredoc with EOF in quotes to avoid variable expansion!
    cat << 'EOF' | sed -f - $f > $f.template
s|https://css0.onto-deside.ilabt.imec.be|${OD_CSS0_BASE_URL}|g
s|https://css1.onto-deside.ilabt.imec.be|${OD_CSS1_BASE_URL}|g
s|https://css2.onto-deside.ilabt.imec.be|${OD_CSS2_BASE_URL}|g
s|https://css3.onto-deside.ilabt.imec.be|${OD_CSS3_BASE_URL}|g
s|https://css4.onto-deside.ilabt.imec.be|${OD_CSS4_BASE_URL}|g
s|https://css5.onto-deside.ilabt.imec.be|${OD_CSS5_BASE_URL}|g
s|https://css6.onto-deside.ilabt.imec.be|${OD_CSS6_BASE_URL}|g
s|https://css7.onto-deside.ilabt.imec.be|${OD_CSS7_BASE_URL}|g
s|https://css8.onto-deside.ilabt.imec.be|${OD_CSS8_BASE_URL}|g
s|https://css9.onto-deside.ilabt.imec.be|${OD_CSS9_BASE_URL}|g
s|https://css10.onto-deside.ilabt.imec.be|${OD_CSS10_BASE_URL}|g
s|https://css11.onto-deside.ilabt.imec.be|${OD_CSS11_BASE_URL}|g
s|https://css-test.onto-deside.ilabt.imec.be|${OD_CSS_TEST_BASE_URL}|g
s|https://viewer.onto-deside.ilabt.imec.be|${OD_VIEWER_BASE_URL}|g
s|https://webclient.onto-deside.ilabt.imec.be|${OD_WEBCLIENT_BASE_URL}|g
EOF
  fi
done