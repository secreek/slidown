#!/bin/sh
THIN=/usr/local/bin/thin
SCRIPT_NAME=solidown
# 根据实际部署情况修改
# 缺省设置供测试使用

THIN_CONFIG=/home/slidown/slidown.yml
SLIDOWN_CONFIG=/home/slidown/slidown/src/config.ru
NOHUP=/usr/bin/nohup

[ -x "$THIN" ] || exit 0
echo $1
case "$1" in
	start)
		$THIN -C $THIN_CONFIG -R $SLIDOWN_CONFIG start
		;;
	stop)
		$THIN -C $THIN_CONFIG -R $SLIDOWN_CONFIG stop
		;;
	restart)
		$THIN -C $THIN_CONFIG -R $SLIDOWN_CONFIG restart
		;;
	*)
		echo "Usage : $SCRIPT_NAME {start|stop|restart}" >&2
		exit 3
		;;
esac

