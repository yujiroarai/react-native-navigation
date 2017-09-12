#!/bin/bash -e

brew tap facebook/fb
export CODE_SIGNING_REQUIRED=NO
brew install fbsimctl --HEAD
