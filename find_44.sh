#!/bin/bash

for genotype in "genotype 3" "genotype 7" "genotype Undifined"; do
    # Define output file based on genotype
    if [[ "$genotype" == "genotype 3" ]]; then
        output_file="g3_44"
    elif [[ "$genotype" == "genotype 7" ]]; then
        output_file="g7_44"
    elif [[ "$genotype" == "genotype Undifined" ]]; then
        output_file="gund_44"
    fi

    # Execute the command for the current genotype
    awk 'NR==FNR {valid[$1]=1; next} ($2 in valid) && ($6 == "-44") {OFS="\t"; print $1, $2, $3, $4, $5, $6, $7, $8, $9}' \
        <(grep -i "$genotype" 1_xx* --files-with-matches | sed 's/1_xx//') candidates.txt > "$output_file"
done

mkdir -p gx
mv *_44 ./gx
