### Installing CP4BA CASE package steps.

Download CP4BA case package 23.0.1-IF001.

> Open a browser at:

[501](https://github.com/IBM/cloud-pak/tree/master/repo/case/ibm-cp-automation/5.0.1)

> Download compressed CP4BA case tar file: `ibm-cp-automation-5.0.1.tgz`

> Create `cp4ba/501` subdirectory in your home directory.

```
mkdir -p cp4ba/501
```

> Copy CP4BA CASE tar file to `cp4ba` directory and untar it.

```
cp ~/Downloads/ibm-cp-automation-5.0.1.tgz ~/cp4ba
cd ~/cp4ba
tar zxvf ibm-cp-automation-5.0.2.tgz -C 501
```

> Untar `cert-k8s-23.0.1.tar` archive to create `cert-kubernetes` directory.

```
cd ~/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs
untar cert-k8s-23.0.1.tar
```

`cert-kubernetes` directory contains scripts, CR templates, etc.

We will refer to this directory as `cert-kubernetes` from now on.

Create environment variable CERTKUBE to refer to `cert-kubernetes` directory.

```
export CERTKUBE=~/cp4ba/501/ibm-cp-automation/inventory/cp4aOperatorSdk/files/deploy/crs/cert-kubernetes
```
