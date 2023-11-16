#!/bin/bash
set -euo pipefail

HELM_DOCS_VERSION="1.11.0"

TMPDIR=$(mktemp -d)

# install helm-docs
curl --silent --show-error --fail --location --output ${TMPDIR}/helm-docs.tar.gz https://github.com/norwoodj/helm-docs/releases/download/v"${HELM_DOCS_VERSION}"/helm-docs_"${HELM_DOCS_VERSION}"_Linux_x86_64.tar.gz
tar -xf ${TMPDIR}/helm-docs.tar.gz -C ${TMPDIR} helm-docs

# validate docs
${TMPDIR}/helm-docs
git diff --exit-code

rm -r ${TMPDIR}
