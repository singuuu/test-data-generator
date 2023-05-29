#!/bin/bash

directory=/drives/c/Users/Prime\ IT\ \(JL\)/Documents/sample/tle
source_file=/drives/c/Users/Prime\ IT\ \(JL\)/Documents/sample/tle/tle.xml
number_of_files=100
start_date="2010-01-01"
end_date="2023-05-16"

for ((i=1; i<=$number_of_files; i++)); do
	destination_file="${directory}/tle_${i}.xml"
	cp "$source_file" "$destination_file"
done

remove_brackets() {
	local input="$1"
	local result="${input//\[\"}"
	result="${result//\"]}"
	echo "$result"
}

for file in "$directory"/*; do
	if [[ -f "$file" ]]; then
		
		sed -i "s/uuidChangeme/$(uuidgen)/g" "$file"
		
		sed -i "s/randomName/$(remove_brackets $(curl -s "https://random-word-api.herokuapp.com/word?number=1"))/g" "$file"

		sed -i "s/randomNum/$((RANDOM))/g" "$file"

		random_epoch=$(shuf -i $(date -d "$start_date" +%s)-$(date -d "$end_date" +%s) -n 1)
		random_date=$(date -u -d @$random_epoch +"%Y-%m-%dT%H:%M:%S+00:00")
		sed -i "s/randomDate/$random_date/g" "$file"

		filename=$(basename "$file")
		sed -i "s/tle.xml/$filename/g" "$file"
	fi
done
