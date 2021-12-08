#!/bin/bash

# Copyright (c) 2021 djds <djds@bghost.xyz>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# See also https://github.com/Azure/azure-cli/issues/14768

set -euo pipefail

readonly USERNAME='00000000-0000-0000-0000-000000000000'


acr_password() {
    local -r registry="${1}"

    set +x
    az acr login \
        --name "${registry}" \
        --expose-token  \
        2>/dev/null \
        | jq -r '.accessToken'
}


podman_login() {
    local -r registries=("${@}")

    for registry in "${registries[@]}"; do
        printf "%s: %s\n" "${registry}" "$(
            acr_password "${registry}" \
                | podman login \
                    --username "${USERNAME}" \
                    --password-stdin \
                    "${registry}.azurecr.io"
        )"
    done
}


podman_login "${@}"
unset -f acr_password podman_login  # if wrapping this whole script as a function