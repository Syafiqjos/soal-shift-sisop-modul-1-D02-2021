#!/bin/bash

awk -F "\t" '
BEGIN {
    max = 0;
    rowidmax =0;
    orderid =0;
    totaltranskecil = 9999999999;
    profitkecil = 999999999999;
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
    cust_segment[segment]++
    }

    //D
    reg = $13
    if (reg != "Region")
    {
        region[reg]+= $21
    }
}
END {print("Transaksi terakhir dengan profit percentage terbesar yaitu " orderid " dengan persentase " max "%.\n")
    
    print("Daftar nama customer di Albuquerque pada tahun 2017 antara lain: ")
    for (i in custname)
        print i
    print("\n")

    for (i in cust_segment){
        if(cust_segment[i] <= totaltranskecil){
            segmentkecil = i
            totaltranskecil = cust_segment[i]
        }
    }
    print ("Tipe segmen customer yang penjualannya paling sedikit adalah " segmentkecil " dengan " totaltranskecil " transaksi.\n")

    for (i in region){
        if(region[i] <= profitkecil){
            regionkecil = i
            profitkecil = region[i]
        }
    }
    print ("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah " regionkecil " dengan total keuntungan " profitkecil)
    }' Laporan-TokoShiSop.tsv > hasil.txt
