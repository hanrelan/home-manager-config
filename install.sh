#!/bin/bash

mkdir -p ${HOME}/.config/home-manager
ln -s ${PWD}/home.nix ${HOME}/.config/home-manager/home.nix

echo "Make sure the nix shells are in /etc/shells"
echo "Install miniconda to ${HOME}/miniconda3"
