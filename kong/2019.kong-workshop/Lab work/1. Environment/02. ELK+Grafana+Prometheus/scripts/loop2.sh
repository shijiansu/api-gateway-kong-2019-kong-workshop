while true;
        do sleep 5;
        ./send_calls_to_api2.sh
        echo -e '\n\n'$(date);
done
