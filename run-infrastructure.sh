#!/bin/bash

set -euo pipefail

packer init .

packer build .

vagrant box add --force ubuntu26-golden-image ./output-golden-image/package.box

vagrant up
