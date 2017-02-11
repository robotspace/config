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

export JDK_HOME=/opt/jdk1.7.0_71
export JAVA_HOME=$JDK_HOME
export JRE_HOME=$JAVA_HOME/jre
PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib

export COCOS_CONSOLE_ROOT=/home/robot/toolchain/cocos2d-x-3.9/tools/cocos2d-console/bin
PATH=$PATH:$COCOS_CONSOLE_ROOT
export PATH
