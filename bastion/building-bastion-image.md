### Building bastion image.
Bastion build is OpenShift Docker binary build.<br/>

#### Create BUILDDIR and download binaries to BUILDDIR.
Create build directory `$BUILDDIR`.<br/>
Build directory location should be outside this lab git repository.<br/>

Build requires `oc` client binary tar, and CP4BA case package tar.<br/>

Download `oc` binary tar from OpenShift portal to the `$BUILDDIR`.<br/>
Follow `download-openshift-client.md`<br/>

Download CP4BA case manager from IBM case manager git repo to the `$BUILDDIR`.<br/>
Follow `download-cp4ba-case-pkg.md`<br/>

#### Copy Dockerfile and build scripts to $BUILDDIR.
Copy Dockerfile from the `bastion` directory to the `$BUILDDIR`.
Copy `create-bastion-buildconfig.sh` script to `$BUILDDIR`.
Copy `build-bastion.sh` script to `$BUILDDIR`.

Run `copy-build-scripts.sh $BUILDDIR` to copy these files to `$BUILDDIR`<br/>

#### Create cp4ba project.
Log into the OpenShift cluster and change to the `cp4ba` project.<br/>
Create `cp4ba` project, if it does not exist: `oc new-project cp4ba`<br/>

#### Create bastion BuildConfig.
Run `create-bastion-buildconfig.sh` script to create bastion `BuildConfig`.<br/>

#### Run build script.
Run `build-bastion.sh` script to start and follow a build.</br>

To start another build, rerun `build-bastion.sh` script.<br/>
