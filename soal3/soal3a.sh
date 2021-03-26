#!/bin/bash

url="https://loremflickr.com/320/240/kitten"

id=1
for ((num=1; num<=23; num=num+1))
do
	filename=`printf "%02d" $id`
	filebaru=`printf "Koleksi_$filename"`

	wget "$url" -O "$filebaru"

	same=0

	for file in *; do
		echo "$file -> $filebaru"
		if [ "$file" == "$filebaru" ]
		then
			echo "Kembar"
		else
			if cmp "$file" "$filebaru"
			then
				same=1
				break
			fi
		fi
	done

	if [ $same -eq 1 ]
	then
		#rm "$filebaru"
		echo "hapus kembar"
	else
		let id=id+1
		echo "tambah id"
	fi
done
