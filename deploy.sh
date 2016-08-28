#!/bin/bash  -xe

: "Deploying Palmetto Landing Page to webapp01"

sudo rsync -avzhe ssh --progress _site/ webapp01:/var/www/html
