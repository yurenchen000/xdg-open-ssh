#!/usr/bin/env bash

HANDLER=ssh-handler
WRAPPER=${HANDLER}.sh
DESKTOP=${HANDLER}.desktop
CONFIG_DIR=${HOME}/.local/share/applications/
BINARY_DIR=${HOME}/bin/

echo "Write: ${CONFIG_DIR}${DESKTOP}" &&
  sed "s:~:${HOME}:" ${DESKTOP} > ${CONFIG_DIR}${DESKTOP} &&
  echo " Copy: ${BINARY_DIR}${WRAPPER}" &&
  mkdir --parents ${BINARY_DIR} &&
  cp --preserve ${WRAPPER} ${BINARY_DIR} &&
  echo "  Set: xdg-mime default ${DESKTOP}" &&
  xdg-mime default ${DESKTOP} x-scheme-handler/ssh
