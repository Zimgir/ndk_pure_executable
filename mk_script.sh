export EXE_ABI=arm64-v8a
export EXE_DIR=/data/local/tmp/test
export EXE_NAME=test_main
export DEBUG_PORT=1234
export DEBUG_CLIENT=/home/alexeyy/Desktop/sf_vbox/ndk/android-ndk-r14/prebuilt/linux-x86_64/bin/gdb-orig
export DEBUG_DIR=./build/obj/local/${EXE_ABI}
export DEBUG_SETUP=./build/libs/arm64-v8a/gdb.setup
export DEBUG_CFG=gdb.setup
export NEW_TERMINAL_CMD=xfce4-terminal\ \-H\ \-\-command

echo $1
if [ "$1" == "build" ] 
then

	export NDK_PROJECT_PATH=./build
	ndk-build NDK_DEBUG=1 NDK_APPLICATION_MK=./makefiles/Application.mk

elif [ "$1" == "install" ] 
then
	
	adb push ./build/libs/${APP_ABI}/* ${EXE_DIR}

	adb shell chmod +x ${EXE_DIR}/${EXE_NAME}

elif [ "$1" == "run" ] 
then

	adb shell export LD_LIBRARY_PATH=${EXE_DIR} \&\& ${EXE_DIR}/${EXE_NAME}

elif [ "$1" == "clean" ] 
then

	rm -f ${DEBUG_CFG}

	rm -rf ./build

	adb shell cd ./data/local/tmp \&\& rm -rf ./test

elif [ "$1" == "debug" ] 
then

	adb shell chmod +x ${EXE_DIR}/gdbserver

	adb forward tcp:${DEBUG_PORT} tcp:${DEBUG_PORT}

	echo Generating gdb setup file...

	rm -f ${DEBUG_CFG}

	echo target remote \:${DEBUG_PORT} >> ${DEBUG_CFG}

	echo file ${DEBUG_DIR}/${EXE_NAME} >> ${DEBUG_CFG}

	cat ${DEBUG_SETUP} >> ${DEBUG_CFG}

	echo Use command: "source gdb.setup" in gdb client window

	${NEW_TERMINAL_CMD} ${DEBUG_CLIENT}

	adb shell export LD_LIBRARY_PATH=${EXE_DIR} \&\& ${EXE_DIR}/gdbserver :${DEBUG_PORT} ${EXE_DIR}/${EXE_NAME}

fi

