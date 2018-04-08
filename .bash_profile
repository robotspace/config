# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export ANDROID_STUDIO_BIN=/home/robot/toolchain/android-studio/bin
PATH=$PATH:$ANDROID_STUDIO_BIN

ANT_BIN=/home/robot/toolchain/ant1.9.4/bin
export ANT_ROOT=$ANT_BIN
PATH=$PATH:$ANT_BIN
PATH=$PATH:$HOME/.local/bin:$HOME/bin

export ANDROID_HOME=/home/robot/toolchain/adt-bundle-linux-x86_64-20140702/sdk
ADB_ROOT=$ANDROID_HOME/platform-tools
PATH=$PATH:$ADB_ROOT
export ANDROID_SDK=$ANDROID_HOME
export ANDROID_SDK_ROOT=$ANDROID_HOME
export ANDROID_NDK=/home/robot/toolchain/android-ndk-r9d
export NDK_ROOT=$ANDROID_NDK
PATH=$PATH:$ANDROID_HOME:$NDK_ROOT

export JDK_HOME=/opt/jdk1.8.0_141
export JAVA_HOME=$JDK_HOME
export JRE_HOME=$JAVA_HOME/jre
PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib

export GOROOT=/usr/local/go
export GOPATH=$HOME/src/go
export GOBIN=$GOPATH/bin
PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export COCOS_CONSOLE_ROOT=/home/robot/toolchain/cocos2d-x-3.9/tools/cocos2d-console/bin
PATH=$PATH:$COCOS_CONSOLE_ROOT
export MY_SQL_BIN=/usr/local/mysql/bin
PATH=$PATH:$MY_SQL_BIN
export REDIS_HOME=/usr/redis
PATH=$PATH:$REDIS_HOME
IDEA_BIN=/home/robot/toolchain/idea-IC-172.3757.52/bin
PATH=$PATH:$IDEA_BIN
NGINX_BIN=/usr/local/openresty/nginx/sbin
PATH=$PATH:$NGINX_BIN
export PATH
