#Dijadikan zip semua folder Kucing dan Kelinci yang ada
zip -r --password "`date '+%m%d%Y'`" Koleksi.zip Kucing_*  Kelinci_*

#Menghapus sisa peninggalan
rm -d -r Kucing_*
rm -d -r Kelinci_*
