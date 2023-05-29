#!/bin/bash

directory=/drives/c/Users/Prime\ IT\ \(JL\)/Documents/sample/l0
source_file=/drives/c/Users/Prime\ IT\ \(JL\)/Documents/sample/l0/l0.xml
number_of_files=100
start_date="2010-01-01"
end_date="2023-05-16"
id_length=32
characters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

for ((i=1; i<=$number_of_files; i++)); do
	destination_file="${directory}/l0_${i}.xml"
	cp "$source_file" "$destination_file"
done

for file in "$directory"/*; do
	if [[ -f "$file" ]]; then
		
		sed -i "s/uuidChangeme/$(uuidgen)/g" "$file"
		
		sed -i "s/randomNum/$((RANDOM))/g" "$file"

		random_id=""
		for ((i=0; i<$id_length; i++)); do
			random_index=$((RANDOM % ${#characters}))
		        random_id+=${characters:$random_index:1}
		done

		sed -i "s/randomId/$random_id/g" "$file"

		random_epoch=$(shuf -i $(date -d "$start_date" +%s)-$(date -d "$end_date" +%s) -n 1)
		random_date=$(date -u -d @$random_epoch +"%Y-%m-%dT%H:%M:%S+00:00")
		sed -i "s/randomDate/$random_date/g" "$file"

		filename=$(basename "$file")
		sed -i "s/l0.xml/$filename/g" "$file"
	fi
done
