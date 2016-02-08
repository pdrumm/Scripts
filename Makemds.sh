#! /bin/bash
#
# This script is used to create GRADING.md for each student that $USER
# was assigned to grade.
# Invoke from assignments/$ASSIGNMENT/$USER (ie. ../../../scripts/Makemds.sh)

# grab the asissignment name (ie: .. )
path=($(pwd | tr "/" "\n"))
hw=${path[${#path[@]}-2]}
# add on filename
file=$hw"/GRADING.md"
# make hw look pretty
hw_cat=$(echo $hw | sed "s/^\(.\)/\u\1/g")
hw_cat=$(echo $hw_cat | sed "s/\([[:digit:]]\)/ \1/")
eq=$(echo $hw_cat | sed "s/./=/g")
# get all links (ie. NDid's)
stud_arr=(`find . -type l`)

# write the GRADING.md for each student
for student in ${stud_arr[*]}
do
	if stat $student/$file 2>/dev/null 1>&2
	then
		echo "Error:    Did not overwrite $student/$file"
	else
		cat > $student/$file << EOF
$hw_cat - Grading
$eq==========

**Score**: 4 / 4

Deductions
----------

Comments
--------
EOF
		echo "Success:  Wrote $student/$file"
	fi
done
