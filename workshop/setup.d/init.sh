#!/bin/bash

ytt -f /opt/workshop/templates/. --data-values-env SESSION --output-files ~/exercises/
