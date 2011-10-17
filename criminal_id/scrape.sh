#!/bin/sh

usage()
{
cat <<EOF
usage: $0 options

This script creates a indexed "assign" statement for the given matrix file.
NOTE: the delimiter in the dumped matrix has to be ',' (a comma).

OPTIONS:
-c columns
-r rows
-d delimiter
-f filename
-h help
EOF
}

_filename=
_rows=
_columns=
_delimiter=","

while getopts "h:c:r:f:d" OPTION
do
    case $OPTION in
	h)
	    usage
	    exit 1
	    ;;
	r)
	    _rows=$OPTARG
	    ;;
	c)
	    _columns=$OPTARG
	    ;;
	f)
	    _filename=$OPTARG
	    ;;
	?)
	    usage
	    exit
	    ;;
    esac
done

if [[ -z $_columns ]] || [[ -z $_rows ]] || [[ -z $_filename ]]
then
     usage
     exit 1
fi

COUNTER=0

for ((row=1; row<=${_rows}; row++))
    do
    for ((column=1; column<=${_columns}; column++))
	do
	val=$(cat ${_filename} | head -n ${row} | cut -d ${_delimiter} -f ${column} | tail -n 1)
	echo assign r1[$COUNTER] = $val\; >> ${_filename}.done
	COUNTER=$(($COUNTER+1))
    done
done

mv ${_filename}.done scraped/
echo 'Scraped data in scraped directory'


