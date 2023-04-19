# lab-carvel

LAB - Markdown Sample
=====================

Sample workshop content using Markdown formatting for pages.

If you already have the Educates operator installed and configured, to
deploy and view this sample workshop, run:

```
kubectl apply -f https://raw.githubusercontent.com/jeffgbutler/lab-carvel/main/resources/workshop.yaml
kubectl apply -f https://raw.githubusercontent.com/jeffgbutler/lab-carvel/main/resources/training-portal.yaml
```

This will deploy a training portal hosting just this workshop. To get the
URL for accessing the training portal run:

```
kubectl get trainingportal/lab-carvel
```

The training portal is configured to allow anonymous access. For your own
workshop content you should consider removing anonymous access.

