###############################################################################
#
#    medley_useage.sh - script defining the "usage" for medley.sh script.
#
#   !!!! This script is meant to be SOURCEd from the scripts/medley.sh script.
#   !!!! It should not be run as a standlone script.
#
#   2023-01-21 Frank Halasz
#
#   Copyright 2023 Interlisp.org
#
###############################################################################

PAGER=$( if [ -n $(which more) ]; then echo "more"; else echo "cat"; fi)

usage() {
   local err_msg
   local msg_path=/tmp/msg-$$
   local lines=("$@")
   if [ $# -ne 0 ];
   then
     echo > ${msg_path}
     echo "$(output_error_msg "${lines[@]}")" >> ${msg_path}
     echo >> ${msg_path}
     echo >> ${msg_path}
   else
     touch ${msg_path}
   fi
   cat ${msg_path} - <<EOF | ${PAGER}
Usage: medley [flags] [sysout] [--] [pass_args ...]

Note: MEDLEYDIR is the directory at the top of the code tree where this script is executed from
      after all symbolic links have been resolved.  For standard installations this will be
      /usr/local/interlisp/medley.  For "local" installations this will be the "medley" sub-directory
      under the directory into which the Medley distribution was installed.

flags:
    -h | --help                : print this usage information

    -z | --man                 : show the man page for medley

    -f | --full                : start Medley from the "full" sysout

    -l | --lisp                : start Medley from the "lisp" sysout

    -a | --apps                : start Medley  from the "apps" sysout

    -e | --interlisp           : (for apps.sysout only) Start in the Interlisp exec

    -n | --noscroll            : do not use scroll bars in Medley window

    -g WxH | --geometry WxH    : set the window geometry to Width x Height.

    -s WxH | --screensize WxH  : set the Medley screen size to be Width x Height

    -t STRING | --title STRING : use STRING as title of window

    -d :N | --display :N       : use X display :N

    -v | --vnc                 : (WSL only) Use a VNC window instead of an X window

    -i STRING | --id STRING    : use STRING as the id for this run of Medley (default: default)

    -i - | --id -              : for id use the basename of MEDLEYDIR

    -i -- | --id --            : for id use the basename of the parent directory of MEDLEYDIR

    -m N | --mem N             : set Medley memory size to N

    -p FILE | --vmem FILE      : use FILE as the Medley virtual memory store

    -r FILE | --greet FILE     : use FILE as the Medley greetfile

    -r - | --greet -           : do not use a greetfile

    -x DIR | --logindir DIR    : use DIR as LOGINDIR in Medley

    -x - | --logindir -        : use MEDLEYDIR/logindir as LOGINDIR in Medley

sysout:
    The name of the file to use as a sysout for Medley to start from.  If sysout is not
    provided and none of the flags [-a, -f & -l] is used, then Medley will start from
    the saved virtual memory file for the id for this run.

pass_args:
    All arguments after the "--" flag, are passed unaltered to lde via run-medley.

EOF

exit 1

}
