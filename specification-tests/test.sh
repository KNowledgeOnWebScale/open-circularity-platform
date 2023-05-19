
docker network inspect ontodeside_default &> /dev/null


if [ $? -eq "0" ]
then 
    network="ontodeside_default"
else 
    network="architecture_default" 
fi


