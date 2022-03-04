# https://linuxtut.com/en/12060150fad1616e37a0/#fromHistory

FROM ubuntu:20.04

# ***********************************************
# install packages for xrdp, and do setting
# ***********************************************
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    language-pack-zh* fonts-noto-cjk fcitx-mozc \
    && im-config -n fcitx
# RUN apt-get install fonts-arphic-ukai fonts-arphic-uming fonts-ipafont-mincho fonts-ipafont-gothic fonts-unfonts-core -y

#Install GUI application for operation check
#RUN apt-get update \
#    && apt-get install -y gedit

#ENV GTK_IM_MODULE=xim \
#    QT_IM_MODULE=fcitx \
#    XMODIFIERS=@im=fcitx \
#    DefalutIMModule=fcitx

RUN locale-gen zh_TW.UTF-8  
ENV LANG=zh_TW.UTF-8 \
    LC_ALL=zh_TW.UTF-8

# -------------------

#Install required packages in os(It is recommended to write it as a spell)
#RUN apt-get update
RUN apt-get install git curl -y

# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04
RUN cd /tmp
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt install nodejs -y

#Creating an applicadtion directory
RUN mkdir /app
#Use app directory as development directory
WORKDIR /app

# https://github.com/jely2002/youtube-dl-gui#building-from-source
RUN git clone https://github.com/jely2002/youtube-dl-gui.git
WORKDIR /app/youtube-dl-gui
RUN npm install

# https://stackoverflow.com/a/65107381/6645399
RUN apt install libgconf-2-4 libatk1.0-0 libatk-bridge2.0-0 libgdk-pixbuf2.0-0 libgtk-3-0 libgbm-dev libnss3-dev libxss-dev -y

# https://medium.com/@ssmak/how-to-fix-puppetteer-error-while-loading-shared-libraries-libx11-xcb-so-1-c1918b75acc3
RUN apt-get install gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget -y

RUN npm install -g npm@8.5.3
RUN npm install electron -g

RUN mkdir -p binaries
COPY docker-files/binaries/* ./binaries/
RUN chmod 4777 binaries

COPY docker-files/start.sh ./
RUN chmod 4777 start.sh

# https://github.com/electron/electron/issues/17972#issuecomment-487369441
#RUN apt-get install sudo -y
#RUN chown root /usr/local/lib/node_modules/electron/dist/chrome-sandbox
#RUN chmod 4755 /usr/local/lib/node_modules/electron/dist/chrome-sandbox

# https://unix.stackexchange.com/a/548473/491238
#RUN apt-get install fonts-arphic-ukai fonts-arphic-uming fonts-ipafont-mincho fonts-ipafont-gothic fonts-unfonts-core -y

#RUN apt-get install language-pack-zh-hans -y
#RUN dpkg-reconfigure locales

#CMD ["npm", "run","start"]
#CMD ["electron", ".", "--no-sandbox"]

RUN useradd -m node