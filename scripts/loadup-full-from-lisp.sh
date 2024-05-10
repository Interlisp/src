#!/bin/sh

if [ ! -h ./medley ] || [ ! -d ./lispusers ]
then
    echo "*** ERROR ***"
    echo "You must run $(basename "$0") while the cwd is a Medley top-level directory."
    echo "The cwd ($(pwd)) is not a Medley top-level directory."
    echo "Exiting."
    exit 1
fi

# shellcheck source=./loadup-setup.sh
. scripts/loadup-setup.sh

loadup_start

cat >"${cmfile}" <<"EOF"
"

(PROGN
  (IL:LOAD (IL:CONCAT (QUOTE {DSK}) (IL:UNIX-GETENV (QUOTE LOADUP_SOURCEDIR))(QUOTE /LOADUP-FULL.LCOM)))
  (IL:LOADUP-FULL (IL:CONCAT (QUOTE {DSK}) (IL:UNIX-GETENV(QUOTE LOADUP_WORKDIR))(IL:L-CASE (QUOTE /full.dribble))))
  (IL:HARDRESET)
)
SHH
(PROGN
  (IL:ENDLOADUP)
  (IL:MAKESYS (IL:CONCAT (QUOTE {DSK})(IL:UNIX-GETENV(QUOTE LOADUP_WORKDIR))(IL:L-CASE (QUOTE /full.sysout))) :FULL))
  (IL:LOGOUT T)
)

"
EOF

run_medley "${LOADUP_WORKDIR}/lisp.sysout"

loadup_finish "full.sysout" "full.*"

