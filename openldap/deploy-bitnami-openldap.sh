#!/bin/bash -x

openldapns=${1:-`oc project --short`}

oc adm policy add-scc-to-user -z default anyuid -n $openldapns

cat <<EOF | oc apply -f -
---
kind: Deployment
apiVersion: apps/v1
metadata:
  annotations:
  name: openldap
  namespace: $openldapns
  labels:
    app: openldap
spec:
  replicas: 1
  selector:
    matchLabels:
      app: openldap
  template:
    metadata:
      labels:
        app: openldap
        deployment: openldap
    spec:
      containers:
        - name: openldap
          image: docker.io/bitnami/openldap:latest
          ports:
            - containerPort: 1389
              protocol: TCP
            - containerPort: 1636
              protocol: TCP
          securityContext:
            readOnlyRootFilesystem: false
            runAsUser: 1001
            runAsGroup: 0
          resources: {}
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
          imagePullPolicy: Always
      restartPolicy: Always
      terminationGracePeriodSeconds: 30
      dnsPolicy: ClusterFirst
      serviceAccountName: default
      schedulerName: default-scheduler
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 25%
      maxSurge: 25%
  revisionHistoryLimit: 10
  progressDeadlineSeconds: 600
---
kind: Service
apiVersion: v1
metadata:
  name: openldap
  namespace: $openldapns
  labels:
    app: openldap
spec:
  ipFamilies:
    - IPv4
  ports:
    - name: 1389-tcp
      protocol: TCP
      port: 1389
      targetPort: 1389
    - name: 1636-tcp
      protocol: TCP
      port: 1636
      targetPort: 1636
  internalTrafficPolicy: Cluster
  type: ClusterIP
  ipFamilyPolicy: SingleStack
  sessionAffinity: None
  selector:
    app: openldap
    deployment: openldap
---
EOF
