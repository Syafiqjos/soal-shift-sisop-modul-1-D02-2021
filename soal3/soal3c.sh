#!/bin/bash

today=`date '+%d-%m-%Y'`
yesterday=`date --date="yesterday" '+%d-%m-%Y'`

#menyimpan folder yang digunakan untuk mendownload gambar
folder=""

#url masing masing
url_kucing="https://loremflickr.com/320/240/kitten"
url_kelinci="https://loremflickr.com/320/240/bunny"

#Check folder kucing di kemarin hari
if [ -d "Kucing_$yesterday" ]; then
	#Kalau kemarin ada folder kucing berarti hari ini folder kelinci
	folder="Kelinci_$today"
	url=$url_kelinci
else
	#Kalau kemarin nggak ada folder kucing atau kelinci, berarti buat folder terserah
	folder="Kucing_$today"
	url=$url_kucing
fi

#Kalau folder yang dipilih sudah ada tidak perlu download ulang
#Kalau folder belum ada maka download aja
if [ ! -d "Kucing_$today" ]; then
	#bikin folder disini
	mkdir $folder

	#download dengan command mirip soal3a.sh
	id=1
	for ((num=1; num<=23; num=num+1))
	do
		filename=`printf "%02d" $id`
		#mengubah folder menjadi $folder
		filebaru=`printf "$folder/Koleksi_$filename"`

		wget -O "$filebaru" -a "$folder/Foto.log" "$url"

		same=0

		#iterating setiap files pada $folder
		for file in "$folder/"*; do
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
else 
	echo "Folder $folder sudah ada, jadi tidak perlu download ulang"
	echo "tunggu besok aja yahh ~"
fi
