#!/bin/bash

directory=/drives/c/Users/Prime\ IT\ \(JL\)/Documents/sample/l2
source_file=/drives/c/Users/Prime\ IT\ \(JL\)/Documents/sample/l2/l2.xml
number_of_files=100
start_date="2010-01-01"
end_date="2023-05-16"
id_length=32
characters_id="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
characters_random_character="abcdefghijklmnopqrstuvwxyz"

for ((i=1; i<=$number_of_files; i++)); do
	destination_file="${directory}/l2_${i}.xml"
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

		sed -i "s/randomCharacter/$(echo "$characters_random_character" | fold -w1 | shuf | head -n1)/g" "$file"
		
		sed -i "s/randomNum1/$((RANDOM))/g" "$file"
		sed -i "s/randomNum2/$((RANDOM))/g" "$file"
		sed -i "s/randomNum3/$((RANDOM))/g" "$file"
		sed -i "s/randomNum4/$((RANDOM))/g" "$file"
		sed -i "s/randomNum5/$((RANDOM))/g" "$file"
		sed -i "s/randomNum6/$((RANDOM))/g" "$file"
		sed -i "s/randomNum7/$((RANDOM))/g" "$file"
		sed -i "s/randomNum8/$((RANDOM))/g" "$file"
		sed -i "s/randomNum9/$((RANDOM))/g" "$file"
		sed -i "s/randomNum10/$((RANDOM % 10))/g" "$file"
		sed -i "s/randomNum11/$((RANDOM))/g" "$file"
		sed -i "s/randomNum12/$((RANDOM))/g" "$file"
		sed -i "s/randomNum13/$((RANDOM))/g" "$file"
		sed -i "s/randomNum14/$((RANDOM))/g" "$file"
		sed -i "s/randomNum15/$((RANDOM))/g" "$file"
		sed -i "s/randomNum16/$((RANDOM))/g" "$file"
		sed -i "s/randomNum17/$((RANDOM))/g" "$file"
		sed -i "s/randomNum18/$((RANDOM))/g" "$file"
		sed -i "s/randomNum19/$((RANDOM))/g" "$file"
		sed -i "s/randomNum20/$((RANDOM))/g" "$file"
		sed -i "s/randomNum21/$((RANDOM))/g" "$file"
		sed -i "s/randomNum22/$((RANDOM))/g" "$file"
		sed -i "s/randomNum23/$((RANDOM))/g" "$file"
		sed -i "s/randomNum24/$((RANDOM))/g" "$file"
		sed -i "s/randomNum25/$((RANDOM))/g" "$file"
		sed -i "s/randomNum26/$((RANDOM))/g" "$file"
		sed -i "s/randomNum27/$((RANDOM))/g" "$file"
		sed -i "s/randomNum28/$((RANDOM))/g" "$file"
		sed -i "s/randomNum29/$((RANDOM))/g" "$file"
		sed -i "s/randomNum30/$((RANDOM))/g" "$file"
		sed -i "s/randomNum31/$((RANDOM))/g" "$file"
		sed -i "s/randomNum32/$((RANDOM))/g" "$file"

		random_id=""
		for ((i=0; i<$id_length; i++)); do
			random_index=$((RANDOM % ${#characters_id}))
		        random_id+=${characters_id:$random_index:1}
		done

		sed -i "s/randomId/$random_id/g" "$file"

		random_epoch1=$(shuf -i $(date -d "$start_date" +%s)-$(date -d "$end_date" +%s) -n 1)
		random_date1=$(date -u -d @$random_epoch1 +"%Y-%m-%dT%H:%M:%S+00:00")
		sed -i "s/randomDate1/$random_date1/g" "$file"

		random_epoch2=$(shuf -i $(date -d "$start_date" +%s)-$(date -d "$end_date" +%s) -n 1)
		random_date2=$(date -u -d @$random_epoch2 +"%Y-%m-%dT%H:%M:%S+00:00")
		sed -i "s/randomDate2/$random_date2/g" "$file"
		
		random_epoch3=$(shuf -i $(date -d "$start_date" +%s)-$(date -d "$end_date" +%s) -n 1)
		random_date3=$(date -u -d @$random_epoch3 +"%Y-%m-%dT%H:%M:%S+00:00")
		sed -i "s/randomDate3/$random_date3/g" "$file"

		sed -i "s/randomName1/$(remove_brackets $(curl -s "https://random-word-api.herokuapp.com/word?number=1"))/g" "$file"
		sed -i "s/randomName2/$(remove_brackets $(curl -s "https://random-word-api.herokuapp.com/word?number=1"))/g" "$file"
		sed -i "s/randomName3/$(remove_brackets $(curl -s "https://random-word-api.herokuapp.com/word?number=1"))/g" "$file"

		filename=$(basename "$file")
		sed -i "s/l2.xml/$filename/g" "$file"
	fi
done
