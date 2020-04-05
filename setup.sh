#!/bin/bash

if [ ! -d ejbca ]; then
  mkdir ejbca || exit 1
  cp ejbca-setup ejbca/
fi

