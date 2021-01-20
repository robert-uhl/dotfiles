#!/bin/sh

## adapted from xfce4-session
##
## GPLv2 or later
##
## Benedikt Meurer <benny@xfce.org>
## Oliver M. Bolzer <oliver@debian.org>
## Francois Le Clainche <fleclainche@wanadoo.fr>
## Maarten Boekhold <boekhold@emirates.net.ae>
## Brian Tarricone <kelnos@xfce.org>
## Jani Monoses <jani@ubuntu.com>

# fix broken $UID on some system...
if test "x$UID" = "x"; then
  if test -x /usr/xpg4/bin/id; then
    UID=`/usr/xpg4/bin/id -u`;
  else
    UID=`id -u`;
  fi
fi

# set $XDG_MENU_PREFIX to "stumpwm-" so that "stumpwm-applications.menu" is picked
# over "applications.menu" in all StumpWM applications.
if test "x$XDG_MENU_PREFIX" = "x"; then
  XDG_MENU_PREFIX="stumpwm-"
  export XDG_MENU_PREFIX
fi

# set DESKTOP_SESSION so that one can detect easily if an StumpWM session is running
if test "x$DESKTOP_SESSION" = "x"; then
  DESKTOP_SESSION="stumpwm"
  export DESKTOP_SESSION
fi

# set XDG_CURRENT_DESKTOP so that Qt 5 applications can identify user set StumpWM theme
if test "x$XDG_CURRENT_DESKTOP" = "x"; then
  XDG_CURRENT_DESKTOP="STUMPWM"
  export XDG_CURRENT_DESKTOP
fi

# $XDG_CONFIG_HOME defines the base directory relative to which user specific
# configuration files should be stored. If $XDG_CONFIG_HOME is either not set
# or empty, a default equal to $HOME/.config should be used.
if test "x$XDG_CONFIG_HOME" = "x" ; then
  XDG_CONFIG_HOME=$HOME/.config
fi
[ -d "$XDG_CONFIG_HOME" ] || mkdir "$XDG_CONFIG_HOME"

# $XDG_CACHE_HOME defines the base directory relative to which user specific
# non-essential data files should be stored. If $XDG_CACHE_HOME is either not
# set or empty, a default equal to $HOME/.cache should be used.
if test "x$XDG_CACHE_HOME" = "x" ; then
  XDG_CACHE_HOME=$HOME/.cache
fi
[ -d "$XDG_CACHE_HOME" ] || mkdir "$XDG_CACHE_HOME"

# set up XDG user directores.  see
# http://freedesktop.org/wiki/Software/xdg-user-dirs
if which xdg-user-dirs-update >/dev/null 2>&1; then
    xdg-user-dirs-update
fi

# For now, start with an empty list
XRESOURCES=""

# Has to go prior to merging Xft.xrdb, as its the "Defaults" file
test -r "/etc/xdg/stumpwm/Xft.xrdb" && XRESOURCES="$XRESOURCES /etc/xdg/stumpwm/Xft.xrdb"
test -r $HOME/.Xdefaults && XRESOURCES="$XRESOURCES $HOME/.Xdefaults"

BASEDIR=$XDG_CONFIG_HOME/stumpwm
if test -r "$BASEDIR/Xft.xrdb"; then
  XRESOURCES="$XRESOURCES $BASEDIR/Xft.xrdb"
elif test -r "$STUMPWMHOME/Xft.xrdb"; then
  mkdir -p "$BASEDIR"
  cp "$STUMPWMHOME/Xft.xrdb" "$BASEDIR"/
  XRESOURCES="$XRESOURCES $BASEDIR/Xft.xrdb"
fi

# merge in X cursor settings
test -r "$BASEDIR/Xcursor.xrdb" && XRESOURCES="$XRESOURCES $BASEDIR/Xcursor.xrdb"

# ~/.Xresources contains overrides to the above
test -r "$HOME/.Xresources" && XRESOURCES="$XRESOURCES $HOME/.Xresources"

# load all X resources (adds /dev/null to avoid an empty list that would hang the process)
cat /dev/null $XRESOURCES | xrdb -merge -

# load local modmap
test -r $HOME/.Xmodmap && xmodmap $HOME/.Xmodmap

# run stumpwm-session if installed
if which stumpwm-session >/dev/null 2>&1; then

  # check if we start stumpwm-session with ck-launch-session. this is only
  # required for starting from a console, not a login manager
  if test "x$STUMPWM_SESSION_WITH_CK" = "x1"; then
    if which ck-launch-session >/dev/null 2>&1; then
      ck-launch-session stumpwm-session
    else
      echo
      echo "You have tried to start StumpWM with consolekit support, but"
      echo "ck-launch-session is not installed."
      echo "Aborted startup..."
      echo

      exit 1
    fi
  else
    # start stumpwm-session normally
    stumpwm-session
  fi

  exit 0
fi

##################
# IMPORTANT NOTE #
##################

# Everything below here ONLY gets executed if you are NOT using stumpwm-session
# (StumpWM's session manager).  If you are using the session manager, everything
# below is handled by it, and the code below is not executed at all.  If you're
# not sure if you're using the session manager, type 'ps -e|grep stumpwm-session'
# in a terminal while StumpWM is running.

##################

# Use dbus-launch if installed.
if test x"$DBUS_SESSION_BUS_ADDRESS" = x""; then
  if which dbus-launch >/dev/null 2>&1; then
    eval `dbus-launch --sh-syntax --exit-with-session`
    # some older versions of dbus don't export the var properly
    export DBUS_SESSION_BUS_ADDRESS
  else
    echo "Could not find dbus-launch; StumpWM will not work properly" >&2
    fi
fi

# this is only necessary when running w/o stumpwm-session
#xsetroot -solid black -cursor_name watch

# or use old-fashioned startup script otherwise

#xfsettingsd &
#xfwm4 --daemon

# start up stuff in $XDG_CONFIG_HOME/autostart/
if test -d "$XDG_CONFIG_HOME/autostart"; then
  for i in ${XDG_CONFIG_HOME}/autostart/*.desktop; do
    grep -q -E "^Hidden=true" "$i" && continue
    if grep -q -E "^OnlyShowIn=" "$i"; then
      # need to test twice, as lack of the line entirely means we still run it
      grep -E "^OnlyShowIn=" "$i" | grep -q 'STUMPWM;' || continue
    fi
    grep -E "^NotShowIn=" "$i" | grep -q 'STUMPWM;' && continue

    # check for TryExec
    trycmd=`grep -E "^TryExec=" "$i" | cut -d'=' -f2`
    if test "$trycmd"; then
      which "$trycmd" >/dev/null 2>&1 || continue
    fi

    cmd=`grep -E "^Exec=" "$i" | cut -d'=' -f2`
    if test "$cmd" && which "$cmd" >/dev/null 2>&1; then
      $cmd &
    fi
  done
fi

#xfdesktop&
#orage &

# panel=`which stumpwm-panel`
# case "x$panel" in
# 	x|xno*)
# 		;;
# 	*)
# 		$panel
# 		ret=$?
# 		while test $ret -ne 0; do
# 			xmessage -center -file - -timeout 20 -title Error <<EOF
# A crash occured in the panel
# Please report this to the stumpwm-dev@stumpwm.org list
# or on http://bugs.stumpwm.org
# Meanwhile the panel will be restarted
# EOF
# 			cat >&2 <<EOF
# A crash occured in the panel
# Please report this to the stumpwm-dev@stumpwm.org list
# or on http://bugs.stumpwm.org
# Meanwhile the panel will be restarted
# EOF
# 			$panel
# 			ret=$?
# 		done
# 		;;
# esac

#xsetwroot -bg white -fg red  -solid black -cursor_name watch
xsetroot -cursor_name left_ptr
/usr/local/bin/stumpwm
