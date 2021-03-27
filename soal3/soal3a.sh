#!/bin/bash

url="https://loremflickr.com/320/240/kitten"

id=1
for ((num=1; num<=23; num=num+1))
do
	filename=`printf "%02d" $id`
	filebaru=`printf "Koleksi_$filename"`

	wget -O "$filebaru" -a "Foto.log" "$url"

	same=0

	#iterating setiap files pada $folder
	for file in *; do
		#Membandingkan file baru dengan file - file lama
		if [ ! "$file" == "$filebaru" ]
		then
			if cmp "$file" "$filebaru"
			then
				same=1
				break
			fi
		fi
	done

	if [ ! $same -eq 1 ]
	then
		let id=id+1
		echo "$filebaru berhasil di download"
	else
		rm $filebaru
		echo "$filebaru udah ada, jadi dihapus aja"
	fi
done
