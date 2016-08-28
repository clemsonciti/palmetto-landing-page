#!/bin/bash

set -xe
module load ruby/2.1.1

# Remove old site, rebuild it, and change permissions to _site/
rm -rf _site
jekyll build
chown -R :staff _site
chmod -R g+w _site
