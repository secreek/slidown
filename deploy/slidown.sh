#!/bin/sh
<<<<<<< HEAD
THIN=$(which thin)
=======
THIN=/usr/local/bin/thin
>>>>>>> 210135939bde3e2531edbcac9726221b601344fc
SCRIPT_NAME=slidown
# 根据实际部署情况修改
# 缺省设置供测试使用

<<<<<<< HEAD
THIN_CONFIG=/home/deathking/code/ruby/slidown/deploy/slidown.yml
SOLIDOWN_CONFIG=/home/deathking/code/ruby/slidown/src/config.ru
=======
THIN_CONFIG=/home/slidown/slidown/deploy/slidown.yml
SOLIDOWN_CONFIG=/home/slidown/slidown/src/config.ru
>>>>>>> 210135939bde3e2531edbcac9726221b601344fc
NOHUP=/usr/bin/nohup

[ -x "$THIN" ] || exit 0
echo $1
case "$1" in
	start)
		$THIN -C $THIN_CONFIG -R $SOLIDOWN_CONFIG start
		;;
	stop)
		$THIN -C $THIN_CONFIG -R $SOLIDOWN_CONFIG stop
		;;
	restart)
		$THIN -C $THIN_CONFIG -R $SOLIDOWN_CONFIG restart
		;;
	*)
		echo "Usage : $SCRIPT_NAME {start|stop|restart}" >&2
		exit 3
		;;
esac

