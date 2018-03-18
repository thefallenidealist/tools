#!/bin/sh
# Created on 180318 by Johnny Sorocil, beerware licence
# vim: set ft=sh ts=4 sw=4 tw=0 fdm=marker et :

#       colors                                                              {{{
# -----------------------------------------------------------------------------
COLOR_RESET='\033[0m' # No Color
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_MAGENTA='\033[0;35m'
COLOR_CYAN='\033[0;36m'
COLOR_WHITE='\033[0;37m'

printr()
{
    printf "$COLOR_RED$*$COLOR_RESET\n"
}

printg()
{
    printf "$COLOR_GREEN$*$COLOR_RESET\n"
}

printb()
{
    printf "$COLOR_BLUE$*$COLOR_RESET\n"
}

printy()
{
    printf "$COLOR_YELLOW$*$COLOR_RESET\n"
}
# ------------------------------------------------------------------------- }}}
readonly progname="${0##*/}"

VERBOSE="n"

#       usage()                                                             {{{
# -----------------------------------------------------------------------------
usage()
{
    printg "Usage: $progname"
    echo "  -h --help"
    echo "  -f --file <non-optional filename>"
    echo "  -v --verbose"
}
# ------------------------------------------------------------------------- }}}
#       missing_non_optional_value()                                        {{{
# -----------------------------------------------------------------------------
missing_non_optional_value()
{
    # check if value is missing, eg:
    # -f
    # -f /tmp/file
    local ARGS_NUM="${#}"
    # using shift combined with set -e makes function calls fail if they are
    # not given enough parameters
    local ARG="${1}"        ; shift
    local VALUE="${1}"      ; shift

    # echo ">> num: $ARGS_NUM"
    # echo ">> arg: $ARG"
    # echo ">> val: $VALUE"

    if [ "$ARGS_NUM" -lt "2" ]; then
        printr "Error, missing value for parameter $ARG"
        exit
    else
        # In case when value is still missing, but another argument is
        # supplied, eg:
        # -f --help         # value is missing to '-f'
        # -f -h

        case "$VALUE" in
            \--* | \-*)
                printr "Error, missing value for parameter $ARG"
                exit
                ;;
        esac
    fi
}
# ------------------------------------------------------------------------- }}}

main()
{
    while [ "$1" != "" ]; do
        PARAM=$1
        VALUE=$2
        case $PARAM in
            -h | --help)
                usage
                exit
                ;;
            -f | --file)
                missing_non_optional_value "$@"
                FILE=$VALUE
                shift
                ;;
            -v | --verbose)
                VERBOSE="y"
                ;;
            -a | --a-long-argument)
                missing_non_optional_value "$@"
                echo "a-arg"
                A_ARG=$VALUE
                shift;
                ;;
            *)
                printr "ERROR: unknown parameter \"$PARAM\""
                usage
                exit 1
                ;;
        esac
        shift
    done

    echo "FILE:    $FILE"
    echo "VERBOSE: $VERBOSE"
    echo "A-ARG:   $A_ARG"
}

main "${@}"
