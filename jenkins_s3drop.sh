#!/bin/bash

aws s3 sync /var/lib/backups/ s3://solutions-backups/jenkins/

#sudo rm /var/lib/backups/*

