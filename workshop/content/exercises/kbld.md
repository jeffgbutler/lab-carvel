# Kbld Overview

Kbld (K Build) is another relatively simple tool. It does two main things:

1. It can be used as a build tool for local development (we will not use this capability in this workshop)
2. It can be used to transform image references to their immutable form (we will use this capability)

Kbld also includes an imaging packaging and relocation function that is deprecated. That function has been moved to another
Carvel tool: [imgpkg](https://carvel.dev/imgpkg/).

Full details about kbld are here: https://carvel.dev/kbld/

## Image Building

Kbld can orchestrate image builds for local development. This can be useful if you are doing Dockerfile or Pack
based local development. In this way of working, kbld can do the following:

1. Call Docker or Pack to build an image
2. Push the image to a registry
3. Update a Kubernetes YAML with a tag that uniquely represents the new image

You can see how this could be useful when rapidly iterating during local development. However, in the Tanzu world we typically
want to use a Cartographer supply chain for this type of workflow, so this is not how we'll use kbld in this workshop.

## Image Resolution

In a very simple usage, kbld will search Kubernetes YAML for image references and will transform the YAML to use
digests instead of labels. This can be useful to convert Kubernetes YAML to use immutable image references.

For example, open the sample Kubernetes pod definition:

```editor:open-file
file: ~/exercises/kbld/nginx-pod.yaml
```

We can run kbld with a command like this:

```execute
kbld -f ~/exercises/kbld/nginx-pod.yaml
```

Notice two things:

1. The `spec.containers.image` reference was changed to use the digest of the nginx image. Note that we are using the "latest"
   tag so the digest may be different if you run this command
2. Kbld changed the image reference to the fully qualified value (including `index.docker.io/library/`)
3. Kbld added an annotation `kbld.k14s.io/images` that details the before and after versions that were transformed

Kbld can accept multiple input files, and can also transform all the YAML in a directory. The output will be a single
consolidated YAML composed of all the input files. For example, you could transform all YAML in a directory like this:

```execute
kbld -f ~/exercises/kbld/.
```

You could transform all the YAML in a directory, then pipe it to Kubectl with a command like this:

```execute
kbld -f ~/exercises/kbld/. | kubectl apply -f-
```

If your input YAML already contains digests, then kbld will use them. It does not verify that the digest actually exists.
