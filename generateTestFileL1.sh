#!/bin/bash

directory=/drives/c/Users/Prime\ IT\ \(JL\)/Documents/sample/l1
source_file=/drives/c/Users/Prime\ IT\ \(JL\)/Documents/sample/l1/l1.xml
number_of_files=100
start_date="2010-01-01"
end_date="2023-05-16"
id_length=64
characters_id="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
characters_random_character="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

for ((i=1; i<=$number_of_files; i++)); do
	destination_file="${directory}/l1_${i}.xml"
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

		random_id1=""
		random_id2=""
		random_id3=""
		for ((i=0; i<$id_length; i++)); do
			random_index1=$((RANDOM % ${#characters_id}))
		    random_id1+=${characters_id:$random_index1:1}

			random_index2=$((RANDOM % ${#characters_id}))
			random_id2+=${characters_id:$random_index2:1}

			random_index3=$((RANDOM % ${#characters_id}))
			random_id3+=${characters_id:$random_index3:1}
		done

		sed -i "s/randomId1/$random_id1/g" "$file"
		sed -i "s/randomId2/$random_id2/g" "$file"
		sed -i "s/randomId3/$random_id3/g" "$file"

		random_epoch=$(shuf -i $(date -d "$start_date" +%s)-$(date -d "$end_date" +%s) -n 1)
		random_date=$(date -u -d @$random_epoch +"%Y-%m-%dT%H:%M:%S+00:00")
		sed -i "s/randomDate/$random_date/g" "$file"

		sed -i "s/randomName1/$(remove_brackets $(curl -s "https://random-word-api.herokuapp.com/word?number=1"))/g" "$file"
		sed -i "s/randomName2/$(remove_brackets $(curl -s "https://random-word-api.herokuapp.com/word?number=1"))/g" "$file"
		sed -i "s/randomName3/$(remove_brackets $(curl -s "https://random-word-api.herokuapp.com/word?number=1"))/g" "$file"
		sed -i "s/randomName4/$(remove_brackets $(curl -s "https://random-word-api.herokuapp.com/word?number=1"))/g" "$file"

		filename=$(basename "$file")
		sed -i "s/l1.xml/$filename/g" "$file"
	fi
done
