while true;
        do sleep 5;
        ./send_calls_to_api.sh
        echo -e '\n\n'$(date);
done
