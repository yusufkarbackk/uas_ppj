url="https://bac3-111-94-121-227.ngrok-free.app/"  # Ganti dengan URL server yang ingin Anda pe
IS_TIME_STARTED="false"
start_time=0
while true; do

	http_code=$(curl -s -o /dev/null -w "%{http_code}" $url)

	# Mengecek kode status HTTP dan melakukan tindakan sesuai
	if [ $http_code -eq 200 ]; then
    		echo "Server is up and running"
		if [ "$IS_TIME_STARTED" = "true" ]; then
			end_time=$(date +%s)
			duration=$((end_time - $START_TIME))
			IS_TIME_STARTED="false"
			unset START_TIME
			echo "server was down for $duration seconds"
		fi
	else
    		echo "Server is not responding with status code: $http_code"
		if [ "$IS_TIME_STARTED" = "false" ]; then
#			$start_time=$(date +%s)
			export START_TIME=$(date +%s)
			IS_TIME_STARTED="true"
		fi
	fi
done
