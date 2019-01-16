#!/bin/bash


source ~/soldemo/client_data/config/env_soldemo.txt

d=20170331
enddate=20181218
indb=S_ORDERS_FIX::ORDER
ind=S_ORDERS_FIX
outdb=FIX1_ANON
otq=ANON


exec 1>anonymize_"$ind"_to_S_ORDERS_"$outdb"_daterange_"$d"_"$enddate".log
exec 2>anonymize_"$ind"_to_S_ORDERS_"$outdb"_daterange_"$d"_"$enddate".log
#tee 2>anonymize_$indbto$outdb_daterange_$d_$enddate.txt
#tee anonymize_$indbto$outdb_daterange_$d_$enddate.txt


while [ "$(date -d "$d" +%Y%m%d)" -lt "$(date -d "$enddate" +%Y%m%d)" ]; do
#[ "$d" != "$enddate" ]; do 
##[ "$(date -d "$d" +%Y%m%d)" -lt "$(date -d "$dend" +%Y%m%d)" ]; do
#	echo $d
        $MAIN_ONE_TICK_DIR/bin/otq_query_loader_daily.exe -output_db S_ORDERS_$outdb -date $d -otq_file Orders.otq::$otq -otq_params DB=$indb >> log/anonymize_"$ind"_to_S_ORDERS_"$outdb"_$d.log
	d=$(date -I -d "$d + 1 day") 
	d="$(date -d "$d" +%Y%m%d)" 
	echo "$d run completed" >> log/anonymize_"$ind"_to_S_ORDERS_"$outdb"_$d.log
#	echo "cicle done" >> log/anonymize_"$indb"_to_"$outdb"_$d.log

done

echo "operation done"

