#!/bin/sh
THIN=$(which thin)
SCRIPT_NAME=slidown
# 根据实际部署情况修改
# 缺省设置供测试使用

THIN_CONFIG=/home/deathking/code/ruby/github-slidown/deploy/slidown.yml
SOLIDOWN_CONFIG=/home/deathking/code/ruby/github-slidown/src/config.ru
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
    new)
        if [ -f "$2" ]; then
            echo "Can't build file, cuase the file has already exsits!"
            exit 4
        else
            touch "$2"
        fi
        ;;
    upload)
        if [ ! -f "$2" ]; then
            echo "The file dosen't exsits!"
            exit 5
        else

        fi
        ;;
    list)
        ;;
    play)
        ;;
	*)
		echo "Usage : $SCRIPT_NAME {start|stop|restart}" >&2
		exit 3
		;;
esac

