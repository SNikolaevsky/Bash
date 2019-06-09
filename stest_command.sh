#!/bin/bash 

export HERE=`pwd`

touch short_result.log
touch full_result.log
touch result.html

git clone git@<ipaddress>:solutions/jenkins_build_job.git

dash_surv="surv"

linear_uat_url="http://<ip>:<port>web_dashboard"

mkdir results
cd results
#mkdir selenium_test
mkdir <clientname>
cd ..

# setting dates

date_start=$(date "2018-11-06  00:00:00.000")
#date_start=$(date "+%Y-%m-%d %H:%M:%S.000" -d "5 days ago")
date_end=$(date "+%Y-%m-%d %H:%M:%S.000")

# starting docker 
docker run -dit \
           --name web_dashboard_check_modal_errors \
           --privileged \
           -w /home/jenkins \
           -v $HERE/jenkins_build_job/monitoring/web_dashboard_monitoring:/scripts \
           -v $HERE/results:/results \
           selenium

sleep 5

# exec scripts
docker exec -i web_dashboard_check_modal_errors bash -c "\
python3 /scripts/check_modal_error.py -u $client_url -d $dash_surv -n <clientname> -p passlinearword -s '$date_start' -e '$date_end' >> /results/<clientname>/result.log; \
cp select_alert.png /results/<clientname>; \


# parsing results
error_message="element error-modal-overlay found"
error_name="error-modal-overlay"
without_errors=true

for f in $(find ./results -name '*.log'); do
	cat $f >> full_result.log
	echo "------------------------------------" >> full_result.log
	filename="$(basename "$(dirname "$f")")"
	if grep -Fxq "$error_message" $f; then
		echo "$filename : $error_name found" >> short_result.log
		without_errors=false
	else
		echo "$filename : $error_name not found" >> short_result.log
	fi
done

echo "<html><pre>" >> result.html
cat short_result.log >> result.html
echo "</pre></html>" >> result.html

cp short_result.log ./results/
cp full_result.log ./results/

echo "$without_errors"
if [ "$without_errors" = "false" ] ; then
	echo "There are Popup errors. Check logs for more details."
	exit 1
fi

docker kill web_dashboard_check_modal_errors
docker rm web_dashboard_check_modal_errors
