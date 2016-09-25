#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="PMSLibShare"
PMS_NAME="PlexMediaServer"																						# Name of PMS install dir
QPKG_DIR=$(getcfg -f $CONF $PMS_NAME Install_path)										# Grap PMS install dir, regardless of disk layout
SHARE_DIR="${QPKG_DIR}/Library"


case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi
    : ADD START ACTIONS HERE
		addshare Plex "$SHARE_DIR" -uw:admin
    ;;

  stop)
    : ADD STOP ACTIONS HERE
    ;;

  restart)
    $0 stop
    $0 start
    ;;

  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
