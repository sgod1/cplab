#!/bin/bash -x

cloudpak_project=${1:-"cp4ba1"}

envfile="cloudpak-project.env"

cat <<EOF > ./$envfile
#!/bin/bash
export CLOUDPAK_PROJECT=$cloudpak_project
EOF

chmod +x ./$envfile

oc project $cloudpak_project
