#docker-compose build

#docker-compose up
#MY_UID="$(id -u)" MY_GID="$(id -g)" TZ=${TZ} DISPLAY=$DISPLAY docker-compose up

export MY_UID="$(id -u)"
export MY_GID="$(id -g)"
export TZ=${TZ}
export DISPLAY=$DISPLAY 
export XMODIFIERS=$XMODIFIERS 
export QT_IM_MODULE=$QT_IM_MODULE 
export GTK_IM_MODULE=$GTK_IM_MODULE 

docker-compose run app bash
#docker-compose up

