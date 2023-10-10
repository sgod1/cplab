### Deploying basition image.
After bastion image is built as described in `building-bastion-image.md`, deploy basiton container.<br/>

Image build is done in `cp4ba` namespace.<br/>
Bastion ImageStream is also in `cp4ba` namespace.<br/>

#### Deploying from the ImageStream namespace.
Change to the `cp4ba` project.<br/>

Log into the Openshift developer perspective<br/>
Click `Add`, then click on the `container images` tile.<br/>

Select `bastion` image stream, and `latest` tag.<br/>

Set `resource type` to `Deployment`.<br/>

Uncheck `create route` box.<br/>

Click `create`</br>

Wait for deployment to be ready, follow deployment to the bastion pod, click on the `terminal`.

#### Deploying from the namespace different from ImageStream namespace.
Create new project where you want to create bastion deployment.<br/>

Grant pull authority from `cp4ba` namespace to default service account in your project:<br/>

```
$git-root/bastion/authorize-pull-image-from bastion-image-stream-project <image-deployment-project>
```

Switch to development perspective and follow steps above</br>
