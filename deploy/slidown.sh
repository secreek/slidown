#!/bin/sh
THIN=/usr/local/rvm/gems/ruby-1.9.3-p286/bin/thin
SCRIPT_NAME=solidown

# 根据实际部署情况修改
# 缺省设置供测试使用

THIN_CONFIG=/etc/thin/test.yml
SOLIDOWN_CONFIG=/tmp/config.ru
NOHUP=/usr/bin/nohup

[-x "$DAEMON"] || exit 0

case "$1" in
	start)
		$NOHUP $THIN -C $THIN_CONFIG -R $SOLIDOWN_CONFIG start
		;;
	stop)
		$NOHUP $THIN -C $THIN_CONFIG -R $SOLIDOWN_CONFIG stop
		;;
	restart)
		$NOHUP $THIN -C $THIN_CONFIG -R $SOLIDOWN_CONFIG restart
		;;
	*)
		echo "Usage : $SCRIPT_NAME {start|stop|restart}" > &2
		exit 3
		;;
esac

