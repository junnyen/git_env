#!/bin/zsh
PORT=$1
INPUT=$2
OP_=$3

### OP: Operation
if [ -z "${OP_}" ]; then
	OP=snmpwalk
else
	if [ "${OP_}" != "walk" ] && [ "${OP_}" != "get" ] && [ "${OP_}" != "getnext" ]; then
		echo "Operation Failed: "${OP_}
		exit 1
	fi
	OP="snmp"${OP_}
fi

### mib file or singel oid
if [ "${INPUT##*.}" = "mib" ]; then
	single=0
	input_oid=($(cat ${INPUT}))
else
	single=1
	input_oid=$(echo ${INPUT} | sed s/,/./g) 
fi

if [ $single -eq 0 ]; then
#	echo ${#input_oid[@]}
	for ((i=1; i<=${#input_oid[@]}; i++)); do
#		echo "["${input_oid[$i]}"]"
		echo "${OP} -v 1 -c public localhost:${PORT} ${input_oid[$i]}"
		${OP} -v 1 -c public localhost:${PORT} ${input_oid[$i]}
		echo "------------------------------------"
	done
else
#	echo $input_oid
	echo "${OP} -v 1 -c public localhost:${PORT} ${input_oid}"
	${OP} -v 1 -c public localhost:${PORT} ${input_oid}
fi
