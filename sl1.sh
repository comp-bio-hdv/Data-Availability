#!/bin/bash

mismatch=$(echo $1 | cut -d_ -f5)

# Read the file line by line
while IFS= read -r input_line
do
    # Extract the position and identifier
    sposition=$(echo "$input_line" | awk '{print $2}' | cut -d':' -f2)
    aposition=$(echo "$input_line" | awk '{print $4}' | cut -d':' -f2)
    distance=$(echo "$input_line" | awk '{print $5}' | cut -d':' -f2)
    identifier=$(echo "$input_line" | awk '{print $6}' | cut -d'|' -f1)

    # Set the length of the substring to extract
    length=24

    # Find the file containing the identifier
    file=$(grep -l "$identifier" 1_xx*)

    if [ -z "$file" ]; then
        echo "No file found containing $identifier"
        continue
    fi

    # Calculate the start position (10 characters before the center)
    start=$((sposition - 10))

    # Use awk to extract the substring
    result=$(awk -v start="$start" -v len="$length" -v id="$identifier" '
        $0 ~ id {
            print substr($0, start, len)
            exit  # Stop after finding the first occurrence
        }
    ' "$file")

    if [ -z "$result" ]; then
        echo "String not found at specified position in $file for $identifier"
    else
        
	resultrc=$(echo $result | tr ACGTacgt TGCAtgca | rev)

	good="true"

	dotbracket=$(echo $resultrc | /home/users/phd/zakhr/misc/ViennaRNA-2.6.4/src/bin/RNAfold -p0 --noPS | awk 'NR==2 {print $1}')

	left_count=`echo "$dotbracket" | cut -c1-10 | tr -cd '(' | wc -c`
	right_count=`echo "$dotbracket" | cut -c15-24 | tr -cd ')' | wc -c`

	middle_part=`echo "$dotbracket" | cut -c11-14`

	if [ $left_count -lt 6 ] || [ $right_count -lt 6 ]; then
	 good="false"
	  fi

	if echo "$dotbracket" | cut -c11-24 | grep '(' > /dev/null; then
	 good="false"
	  fi

	if echo "$dotbracket" | cut -c1-14 | grep ')' > /dev/null; then
	 good="false"
	  fi

	if [ "$middle_part" != "...." ]; then
	 good="false"
	  fi

	#if [[ "${dotbracket:9:6}" == "(....)" ]]; then good="true"; fi 

	#echo "File: $file"
        #echo "Identifier: $identifier"
        #echo "Position: $position"
        #echo "Substring: $result"

	if [[ $good == "true" ]]; then
        echo "$mismatch $file $identifier $sposition $aposition $distance $result $resultrc $dotbracket"
	fi

    fi
done < $1 
