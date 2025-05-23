#!/bin/bash

#
# SPDX-FileCopyrightText: 2024 Duncan Greatwood
#
# SPDX-License-Identifier: Apache-2.0
#

# Execute this script from the parent directory by invoking:
#   bldscripts/mesbuild.sh

MY_SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $MY_SCRIPT_DIR/helpers/messetdirvars.sh
source $MY_SCRIPT_DIR/helpers/adjbuilddirformesbuild.sh

MESON_BUILD_DIR="$MESON_BUILD_DIR.nossl"

if [ -e "${MESON_BUILD_DIR}" ]
then
    echo "Using existing build dir ${MESON_BUILD_DIR}"
else
    meson setup ${MESON_BUILD_DIR} \
    --buildtype=release \
    -DPISTACHE_BUILD_EXAMPLES=true \
    -DPISTACHE_BUILD_TESTS=true \
    -DPISTACHE_BUILD_DOCS=false \
    -DPISTACHE_USE_CONTENT_ENCODING_DEFLATE=true \
    -DPISTACHE_USE_CONTENT_ENCODING_BROTLI=true \
    -DPISTACHE_USE_CONTENT_ENCODING_ZSTD=true \
    --prefix="${MESON_PREFIX_DIR}"
fi

meson compile -C ${MESON_BUILD_DIR}
