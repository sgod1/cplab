FROM registry.access.redhat.com/ubi8/ubi:8.8-1067

RUN dnf install -y jq python39 bind-utils iputils openldap-clients git procps-ng diffutils java-11-openjdk-devel podman

COPY oc-4.12.35-linux.tar.gz /root
RUN tar zxvf /root/oc-4.12.35-linux.tar.gz -C /usr/local/bin
RUN /usr/bin/pip3 install yq

COPY ibm-cp-automation-5.0.1.tgz /root
#RUN mkdir -p /cp4ba/501 && tar xvf /root/ibm-cp-automation-5.0.1.tgz -C /cp4ba/501

ENV CERTK8s=/cloudpak/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs
#RUN tar xvf $CERTK8s/cert-k8s-23.0.1.tar -C $CERTK8s

#COPY auth-token /cp4ba
#COPY oc-login.sh /cp4ba
#COPY clone-git-repo.sh /cp4ba
#COPY set-cloudpak-project.sh /cp4ba

#RUN mkdir /.kube && chmod g+rwx /.kube && chmod -R g+rwx /cp4ba
RUN mkdir /.kube && chmod g+rwx /.kube

ENV CERTKUBE=$CERTK8s/cert-kubernetes
ENV PATTERNS=$CERTKUBE/descriptors/patterns
ENV SCRIPTS=$CERTKUBE/scripts
ENV OPOLM=$CERTKUBE/descriptors/op-olm
ENV CP3PT0=$CERTKUBE/scripts/cpfs/installer_scripts/cp3pt0-deployment
#ENV GIT_ROOT=/cp4ba/cplab
ENV GIT_ROOT=/cloudpak/cplab
ENV WPS_GIT=$GIT_ROOT/patterns/workflow-process-service

ENV PATH=.:$PATH

ENTRYPOINT ["sleep", "infinity"]
