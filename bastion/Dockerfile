FROM registry.access.redhat.com/ubi8/ubi:8.8-1067

RUN dnf install -y jq python39 bind-utils iputils openldap-clients

#COPY oc-4.12.35-linux.tar.gz /root
#RUN tar zxvf /root/oc-4.12.35-linux.tar.gz -C /usr/local/bin

#COPY ibm-cp-automation-5.0.1.tgz /root
#RUN mkdir -p /cp4ba/501 && tar xvf /root/ibm-cp-automation-5.0.1.tgz -C /cp4ba/501

ENV CERTK8s=/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/
#RUN tar xvf $CERTK8s/cert-k8s-23.0.1.tar -C $CERTK8s

ENV CERTKUBE=$CERTK8s/cert-kubernetes

CMD ["/bin/bash"]
