#!/bin/bash  -xe

: "Deploying Palmetto User Guide to webapp01"

sudo rsync -avzhe ssh --progress _site/ webapp01:/var/www/palmetto
