#!/bin/bash -x

envfile="cloudpak-project.env"

cloudpak_project=$1

if test $# -eq 0 -a -f ./$envfile; then
    . ./envfile
    cloudpak_project="$CLOUDPAK_PROJECT"
fi

if test -z "$cloudpak_project"; then
    echo "Usage: set-cloudpak-project.sh <cloudpak-project-name>"
    exit 1
fi

cat <<EOF > ./$envfile
#!/bin/bash
export CLOUDPAK_PROJECT="$cloudpak_project"
EOF

chmod +x ./$envfile

oc project "$cloudpak_project"
