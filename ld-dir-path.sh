#!/bin/sh -e
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$SNAP/usr/lib/x86_64-linux-gnu/dri"
LIB_GL_DRIVERS_PATH="$SNAP/usr/lib/x86_64-linux-gnu/dri"
export LIB_GL_DRIVERS_PATH
export LD_LIBRARY_PATH

#!/bin/bash
case "$SNAP_ARCH" in
	"amd64") ARCH='x86_64-linux-gnu'
	;;
	"i386") ARCH='i386-linux-gnu'
	;;
	*)
		echo "Unsupported architecture for this app build"
		exit 1
	;;
esac

export LD_LIBRARY_PATH=$SNAP/usr/lib/$ARCH:$LD_LIBRARY_PATH

# XKB config
export XKB_CONFIG_ROOT=$SNAP/usr/share/X11/xkb

export LD_LIBRARY_PATH=$SNAP/usr/lib/$ARCH/pulseaudio:$LD_LIBRARY_PATH

# Mesa Libs
export LD_LIBRARY_PATH=$SNAP/usr/lib/$ARCH/mesa:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$SNAP/usr/lib/$ARCH/mesa-egl:$LD_LIBRARY_PATH

# XDG Config
export XDG_CONFIG_DIRS=$SNAP/etc/xdg:$XDG_CONFIG_DIRS
export XDG_CONFIG_DIRS=$SNAP/usr/xdg:$XDG_CONFIG_DIRS
# Note: this doesn't seem to work, QML's LocalStorage either ignores
# or fails to use $SNAP_USER_DATA if defined here
export XDG_DATA_DIRS=$SNAP_USER_DATA:$XDG_DATA_DIRS
export XDG_DATA_DIRS=$SNAP/usr/share:$XDG_DATA_DIRS

# Workaround in snapd for proprietary nVidia drivers mounts the drivers in
# /var/lib/snapd/lib/gl that needs to be in LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/var/lib/snapd/lib/gl:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/var/lib/snapd/lib/gl32:$LD_LIBRARY_PATH


# Not good, needed for fontconfig
export XDG_DATA_HOME=$SNAP_USER_DATA/usr/share

# Font Config
export FONTCONFIG_PATH=$SNAP/etc/fonts/config.d
export FONTCONFIG_FILE=$SNAP/etc/fonts/fonts.conf

# Tell libGL where to find the drivers
export LIBGL_DRIVERS_PATH=$SNAP/usr/lib/$ARCH/dri

# Necessary for the SDK to find the translations directory
export APP_DIR=$SNAP

# Use GTK styling for running under Unity 7
export DESKTOP_SESSION=ubuntu
export XDG_SESSION_DESKTOP=ubuntu
export XDG_CURRENT_DESKTOP=Unity

#export LIBGL_DEBUG="verbose"

export XLOCALEDIR="$SNAP/usr/share/X11/locale"
export LOCPATH="$SNAP/usr/lib/locale"


exec "$@"
