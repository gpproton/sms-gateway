#!/bin/bash
. `pwd`/../.env
if [ ! -f "index.php" ]; then
    git clone --progress --single-branch --depth 1 --branch "${VERSION_PLAYSMS}" --recurse-submodules -j 4 https://github.com/playsms/playsms /tmp/playsms
    rsync -r /tmp/playsms/ ${PATHSRC}
    mkdir -p $PATHWEB $PATHLOG $PATHSTR $PATHBIN
    cp -rf $PATHSRC/web/* $PATHWEB
    cp -rf $PATHSRC/storage/* $PATHSTR
    cp "$PATHSTR/composer/composer.json.dist" "$PATHSTR/composer/composer.json"
    composer --working-dir="$PATHSTR/composer/" install
    cp $PATHSTR/custom/application/configs/config-dist.php $PATHSTR/custom/application/configs/config.php
    sed -i "s|#DBHOST#|$DBHOST|g" $PATHSTR/custom/application/configs/config.php
    sed -i "s|#DBPORT#|$DBPORT|g" $PATHSTR/custom/application/configs/config.php
    sed -i "s|#DBNAME#|$DBNAME|g" $PATHSTR/custom/application/configs/config.php
    sed -i "s|#DBUSER#|$DBUSER|g" $PATHSTR/custom/application/configs/config.php
    sed -i "s|#DBPASS#|$DBPASS|g" $PATHSTR/custom/application/configs/config.php

    cp $PATHWEB/appsetup-dist.php $PATHWEB/appsetup.php
    sed -i "s|#PATHLOG#|$PATHLOG|g" $PATHWEB/appsetup.php
    sed -i "s|#PATHBIN#|$PATHBIN|g" $PATHWEB/appsetup.php
    sed -i "s|#PATHSTR#|$PATHSTR|g" $PATHWEB/appsetup.php
    sed -i "s|#PATHWEB#|$PATHWEB|g" $PATHWEB/appsetup.php
    sed -i "s|#URLWEB#|$URLWEB|g" $PATHWEB/appsetup.php

    rm -f $PATHBIN/playsmsd
    cp -rR $PATHSRC/bin/playsmsd.php $PATHBIN/playsmsd
    chmod 700 $PATHBIN/playsmsd
    touch $PATHLOG/playsms.log >/dev/null 2>&1
    chmod 664 $PATHLOG/playsms.log >/dev/null 2>&1
    touch $PATHLOG/audit.log >/dev/null 2>&1
    chmod 664 $PATHLOG/audit.log >/dev/null 2>&1
    chown -R www-data $PATHBIN $PATHLOG
    php /var/www/scripts/install.php
fi
export PLAYSMS_WEB="$PATHWEB"
sleep 5
runuser -u www-data -- php $PATHBIN/playsmsd check
runuser -u www-data -- php $PATHBIN/playsmsd restart
runuser -u www-data -- php $PATHBIN/playsmsd status
php-fpm