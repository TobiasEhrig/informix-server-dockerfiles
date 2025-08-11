# informix-server-dockerfiles


1.  Place the Informix product in the BASEDIR.
    - Name the product iif.tar
2.  Run ./build

The build script have an optional parameter for the image name. If you set no image name the default name "informix-de" will be used.
Example with given image name:
```sh
./build my-great-ifx-image
```

