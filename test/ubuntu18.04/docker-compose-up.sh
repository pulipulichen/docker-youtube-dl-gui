docker-compose build

#docker-compose up
MY_UID="$(id -u)" MY_GID="$(id -g)" TZ=${TZ} DISPLAY=$DISPLAY docker-compose up
#MY_UID="$(id -u)" MY_GID="$(id -g)" TZ=${TZ} DISPLAY=$DISPLAY docker-compose run app bash

