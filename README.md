# soal-shift-sisop-modul-1-D02-2021
- Jessica Tasyanita (05111940000043)
- Ahmad Syafiq Aqil Wafi (05111940000089)
- Maximilian H M Lingga (05111940000092)

## Soal1
Tujuan : Menganalisa log dari aplikasi dengan cara membagi Log ERROR dan INFO menggunakan Regex dan menyimpan data - data yang ada pada error_message.csv dan user_statistic.csv.
### A. Mengumpulkan informasi log dengan cara memisahkan Log ERROR dan INFO menggunakan Regex

![image](https://user-images.githubusercontent.com/16128257/113279700-9e064100-930d-11eb-8e86-c2f6adeb2a28.png)

#### Cara Pengerjaan
#### Kendala

### B. Menyaring seluruh Log ERROR dan menghitung jumlahnya

![image](https://user-images.githubusercontent.com/16128257/113279749-ac545d00-930d-11eb-9a29-c6984295ad5b.png)

#### Cara Pengerjaan
#### Kendala

### C. Menghitung Log ERROR dan INFO untuk masing - masing Usernya

![image](https://user-images.githubusercontent.com/16128257/113279796-b9714c00-930d-11eb-945e-b1787664f08a.png)

#### Cara Pengerjaan
#### Kendala

### D. Menyimpan hasil operasi Nomor B pada error_message.csv

![image](https://user-images.githubusercontent.com/16128257/113279850-c7bf6800-930d-11eb-944b-2fc4e1060e37.png)

#### Cara Pengerjaan
#### Kendala

### E. Menyimpan hasil operasi Nomor C pada user_statistic.csv

![image](https://user-images.githubusercontent.com/16128257/113279919-ddcd2880-930d-11eb-8395-22bf75b31440.png)

#### Cara Pengerjaan
#### Kendala

## Soal2
Tujuan : Mendapatkan report hasil penjualan dari data pada Laporan-TokoShiSop.tsv
### A. Mendapatkan Row ID dan Profit Precentage terbesar

![image](https://user-images.githubusercontent.com/62937814/113160069-56c57500-9267-11eb-91f2-a6d26f8f549b.png)

#### Cara Pengerjaan
1. Menggunakan ```awk -F"\t"``` untuk memisahkan file tsv(tab separated value)
2. Pada block ```BEGIN``` mendeklarasikan variabel ```max``` yang digunakan untuk menyimpan profit precentage yang paling besar, begitu pula dengan ```rowidmax``` dan ```orderid```.
    
3. Kemudian pada bagian ```rowid=$1;
        sales=$18;
        profit=$21;``` merupakan variabel untuk menyimpan __Row ID__ yang terletak pada kolom 1, __Sales__ pada kolom 18, dan __Profit__ pada kolom 21.
        
4. ```if(rowid != "Row ID" && sales != "Sales" && profit != "Profit")``` bertujuan untuk memisahkan _row_ yang merupakan label dari setiap kolom tersebut.

5. ```cp = sales - profit``` untuk menghitung nilai _cost price_ yang akan digunakan untuk menghitung _profit precentage_.

6. ```profitp = (profit / cp) * 100``` pada bagian ini menghitung nilai _profit precentage_ menggunakan rumus yang tersedia pada soal
7. Kemudian pada ```if(max <= profitp)``` mengidentifikasi apakah nilai max current state lebih kecil dari Profit Precentage yang ada saat ini, jika memenuhi kondisi maka ```max = profitp; rowidmax = rowid; orderid=$2``` kita meng-_assign_ nilai current Profit Precentage yang baru menjadi nilai Profit Precentage yang paling besar. Begitu pula dengan __Row ID__ dan __Order ID_
8. Pada block ```END``` tinggal menampilkan hasil yang sudah didapat sesuai soal.

#### Kendala
Tidak terdapat kenala untuk 2a

### B. Mendapatkan nama customer yang melakukan transaksi pada tahun 2017 di Albuquerque

![image](https://user-images.githubusercontent.com/62937814/113167023-82e3f480-926d-11eb-9b99-03187b962f69.png)

#### Cara Pengerjaan
1. Menyimpan ```orderid = $2; city = $10``` __Order ID__ pada kolom 2 dan ___City___ pada kolom 10.
2. Mendapatkan tahun dari transaksi menggunakan fungsi ```substr``` dimana sintaksnya ```substr(orderid, 4, 4)``` mengambil data dari __Order ID__ yang pemisahan string nya dimulai dari indeks ke 4 dengan panjangnya 4 yang akan menghasilkan 4 digit yang merupakan tahun transaksi tersebut dilaksanakan.
3. Kemudian kita identifikasi apakah ```year``` merupakan ```2017``` dan ```city``` merupakan ```Albuquerque```. Jika memenuhi kondisi, maka disimpan ke dalam sebuah array.
4. Pada block ```END``` menampilkan hasil yang diminta yang merupakan nama dari customer tersebut menggunakan looping.

#### Kendala
Kendala yang terjadi pada saat mendapatkan value dari tahun transaksi, namun akhirnya kami menggunakan fungsi ```substr``` untuk mendapatkan value tersebut

### C. Mencari segment dengan jumlah transaksi yang paling sedikit

![image](https://user-images.githubusercontent.com/62937814/113169963-4ebe0300-9270-11eb-9d56-598ac158fc4f.png)

#### Cara Pengerjaan
1. Pada block ```BEGIN``` mendeklarasikan variabel ```totaltranskecil = 9999999999``` dengan tujuan menjadi nilai awal untuk pembanding saat mencari total transaksi yang paling kecil
2. Kemudian melakukan penambahan jika ada segment yang sama menggunakan array.
3. Pada block ```END``` mencari segment yang memiliki total transaksi paling sedikit. Kemudian menampilkan hasil sesuai yang diminta pada soal.

#### Kendala
Pada awalnya, kami mencari segment yang paling kecil dengan membuat variabel yang berbeda pada setiap segment lalu mengidentifikasinya menggunakan kondisi ```if``` atau ```else if``` namun hal ini tidak efisien seperti di bawah ini. 
```bash
#!/bin/bash

awk -F "\t" '
BEGIN {consumer = 0
        homeoffice = 0
        corporate =0}
{   
    segment = $8
    if (segment != "Segment")
    {
        if (segment == "Consumer")
        {   
            consumer++
        }
        else if (segment == "Corporate")
        {
            corporate++
        }
        else if (segment == "Home Office")
        {
            homeoffice++
        }
    }
}
END {
    if (consumer < corporate && consumer < homeoffice)
    {
        totaltranskecil = consumer
        segmentkecil = "Consumer"
    }
    else if (corporate < consumer && corporate < homeoffice)
    {
        totaltranskecil = corporate
        segmentkecil = "Corporate"
    }
    else if (homeoffice < consumer && homeoffice < corporate)
    {
        totaltranskecil = homeoffice
        segmentkecil = "Home Office"
    }
    print segmentkecil, totaltranskecil}' Laporan-TokoShiSop.tsv
 ```

Kemudian kami revisi dengan menggunakan array untuk menyimpan jumlah tersebut sehingga menjadi lebih efisien.

### D. Mencari region yang memiliki jumlah profit yang paling sedikit

![image](https://user-images.githubusercontent.com/62937814/113173561-b75aaf00-9273-11eb-9f50-3f697ab28506.png)


#### Cara Pengerjaan
1. Pada block ```BEGIN``` mendeklarasikan variabel ```profitkecil = 9999999999``` dengan tujuan menjadi nilai awal untuk pembanding saat mencari total profit yang paling kecil
2. Kemudian menjumlahkan profit yang memiliki region yang sama untuk mendapatkan total profit dari masing-masing region.
3. Pada block ```END``` mencari segment yang memiliki total transaksi paling sedikit. Kemudian menampilkan hasil sesuai yang diminta pada soal.

#### Kendala
Untuk nomor 2d ini memiliki kendala yang hampir mirip dengan 2c.

### 2e
memasukkan seluruh code ke dalam suatu file txt

![image](https://user-images.githubusercontent.com/62937814/113174935-15d45d00-9275-11eb-8063-b2dc4a2b75f0.png)

#### Kendala
Pada awalnya menggunakan ```>>``` namun saat dirun berkali2 menjadi ter-_concate_ kemudian kami ganti menjadi ```>``` agar bisa ter-_overwrite_ setiap kali program dijalankan


## Solusi Soal3
-> menunggu deadline

# Refrensi
## 1
## 2
Substring Extraction (https://riptutorial.com/awk/example/23920/substring-extraction)
## 3
