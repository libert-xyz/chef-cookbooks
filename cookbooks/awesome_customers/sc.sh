#!/bin/bash


knife bootstrap 54.167.214.225 -ssh-user ec2-user -sudo --identity-file /home/tux/Downloads/myAws.pem --node-name lampStack --run-list 'recipe[awesome_customers]'
