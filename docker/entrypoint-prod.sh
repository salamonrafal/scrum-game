#!/usr/bin/env bash

npm install \
  && npm run prebuild \
  && npm run build

npm run start:prod