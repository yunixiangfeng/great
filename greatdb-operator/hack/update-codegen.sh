#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

MODULE=greatdb-operator

SCRIPT_ROOT=$(dirname "${BASH_SOURCE[0]}")/..
cd $SCRIPT_ROOT

export GO111MODULE=on

go mod vendor

CODEGEN_PKG=${CODEGEN_PKG:-$(ls -d -1 ./vendor/k8s.io/code-generator 2>/dev/null || echo ../code-generator)}

bash "${CODEGEN_PKG}"/generate-groups.sh "deepcopy,client,informer,lister" \
     ${MODULE}/client \
     ${MODULE}/apis \
    wu123:v1alpha1 \
     --go-header-file ./hack/boilerplate/boilerplate.go.txt
