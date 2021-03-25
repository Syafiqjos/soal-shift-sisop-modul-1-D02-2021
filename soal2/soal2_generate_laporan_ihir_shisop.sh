#!/bin/bash

awk -F "\t" '
BEGIN {
    max = 0;
    rowidmax =0;
    orderid =0;
    consumer = 0;
    homeoffice = 0;
    corporate =0;
    central = 0;
    east = 0;
    south =0;
    west = 0;
}
{
    //A
    rowid=$1;
    sales=$18;
    profit=$21;
    if(rowid != "Row ID" && sales != "Sales" && profit != "Profit")
    {
        cp = sales - profit
        profitp = (profit / cp) * 100
            if(max <= profitp){
            max = profitp
            rowidmax = rowid
            orderid=$2
            }
    }
    //B
    orderid = $2
    city = $10
    if (orderid != "Order ID" && city != "City")
    {
        year = substr(orderid, 4, 4)
        if (year == 2017 && city == "Albuquerque")
        {   
            custname[$7]
        }
    }
    //C
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
    //D
    region = $13
    if (region != "Region")
    {
        if (region == "Central")
        {   
            central += $21
        }
        else if (region == "East")
        {
            east += $21
        }
        else if (region == "South")
        {
            south += $21
        }
        else if (region == "West")
        {
            west += $21
        }
    }
}
END {print("Transaksi terakhir dengan profit percentage terbesar yaitu " orderid " dengan persentase " max "%.\n")
    
    print("Daftar nama customer di Albuquerque pada tahun 2017 antara lain: ")
    for (i in custname)
        print i
    
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
    print ("Tipe segmen customer yang penjualannya paling sedikit adalah " segmentkecil " dengan " totaltranskecil " transaksi.\n")
    
    if (central < east && central < south && central < west)
    {
        terkecil = central
        regionkecil = "Central"
    }
    else if (east < central && east < south && east < west)
    {
        terkecil = east
        regionkecil = "East"
    }
    else if (south < central && south < east && south < west)
    {
        terkecil = south
        regionkecil = "South"
    }
    else if (west < central && west < east && west < south)
    {
        terkecil = west
        regionkecil = "West"
    }
    print ("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah " regionkecil " dengan total keuntungan " terkecil)
    }' Laporan-TokoShiSop.tsv >> hasil.txt
