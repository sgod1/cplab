#!/bin/bash -x

while getopts c:t:u:p: opt
do
    case $opt in
    c) pk="$OPTARG" ;;
    t) t="$OPTARG" ;;
    u) u="$OPTARG" ;;
    p) p="$OPTARG" ;;
    esac
done

if test -z "$pk"; then
    echo "Cloud Pak project required. Usage: oc-login.sh -c project (-t token | -u user -p password)"
    exit 1
fi

if test ! -z "$t"; then
    # login with input token
    oc login api:6443 --insecure-skip-tls-verify=true --token="$t"

elif test ! -z "$u" -a ! -z "$p"; then
    # login with username and password
    oc login api:6443 --insecure-skip-tls-verify=true -u="$u" -p="$p"
    oc whoami -t > auth-token

elif test -f ./auth-token; then
    # login with saved token
    oc login api:6443 --insecure-skip-tls-verify=true --token=`cat auth-token`

else
    echo "Usage: oc-login.sh -c project (-t token | -u user -p password)"
    exit 1
fi

./set-cloudpak-project.sh "$pk"
