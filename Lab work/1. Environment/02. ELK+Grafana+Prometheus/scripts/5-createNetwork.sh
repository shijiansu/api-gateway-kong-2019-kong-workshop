docker network create kong-net
docker network connect kong-net kong-ee
docker network connect kong-net kong-ee-database
# to checek this
# /Users/shijian.su/30it/Workshop/20191128.KONG Workshop/scripts/7-startELK.sh
