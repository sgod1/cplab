Openshift console creates ldap bind secret in openshift-config namespace:

`oc get secrets -n openshift-config -o yaml`

```
kind: Secret
apiVersion: v1
metadata:
  name: ldap-bind-password-sxzlm
  generateName: ldap-bind-password-
  namespace: openshift-config
data:
  bindPassword: YWRtaW5wYXNzd29yZA==
type: Opaque
```

Add `ldap` entry to `identityProviders` list:

```
apiVersion: config.openshift.io/v1
kind: OAuth
metadata:
  name: cluster
spec:
  identityProviders:
    - ldap:
        attributes:
          email: []
          id:
            - uid
          name:
            - cn
          preferredUsername:
            - uid
        bindDN: 'cn=admin,dc=example,dc=org'
        bindPassword:
          name: ldap-bind-password-sxzlm
        insecure: true
        url: 'ldap://openldap.openldap.svc:1389/ou=users,dc=example,dc=org??sub'
      mappingMethod: claim
      name: openldap
      type: LDAP
```
