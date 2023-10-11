#!/bin/bash -x

cloudpak_project=${1:-"cp4ba1"}

echo <<EOF > ./cloudpak-project.env
#!/bin/bash
export CLOUDPAK_PROJECT=$cloudpak_project
EOF

oc project $cloudpak_project
