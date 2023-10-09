FROM registry.access.redhat.com/ubi8/ubi:8.8-1067

RUN dnf install -y jq python39 bind-utils iputils openldap-clients git procps-ng diffutils java-11-openjdk-devel podman

COPY oc-4.12.35-linux.tar.gz /root
RUN tar zxvf /root/oc-4.12.35-linux.tar.gz -C /usr/local/bin
RUN /usr/bin/pip3 install yq

COPY ibm-cp-automation-5.0.1.tgz /root
RUN mkdir -p /cp4ba/501 && tar xvf /root/ibm-cp-automation-5.0.1.tgz -C /cp4ba/501

ENV CERTK8s=/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs
RUN tar xvf $CERTK8s/cert-k8s-23.0.1.tar -C $CERTK8s

# manual step
# RUN git clone https://github.com/sgod1/cplab /cp4ba/cplab

RUN mkdir /.kube && chmod g+rwx /.kube && chmod -R g+rwx /cp4ba

ENV CERTKUBE=$CERTK8s/cert-kubernetes
ENV PATTERNS=$CERTKUBE/descriptors/patterns
ENV SCRIPTS=$CERTKUBE/scripts
ENV CASEGEN=/cp4ba/cplab/case-scripts
ENV KUST=/cp4ba/cplab/kustomize
ENV OPOLM=$CERTKUBE/descriptors/op-olm
ENV CP3PT0=$CERTKUBE/scripts/cpfs/installer_scripts/cp3pt0-deployment

ENTRYPOINT ["sleep", "infinity"]
