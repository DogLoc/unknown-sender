#!/usr/bin/env python
import threading
import string
import base64
import urllib.request
import urllib.parse
import os
import time
import sys
import random

import phonenumbers

os.system('clear')
os.system('bash banner.sh')

try:
    import requests
except ImportError:
    print('Missing dependencies')

print("\033[94m Enter the information ask to send a message. \033[0;0m")

while True : 
    
    target = input('\n \033[91m enter the target phone number (+33600000000) :\033[0;0m')

    if target.startswith('+'):
        target_without_country_code = target.split('+', 1)[1]

        if len(target) > 7 and target_without_country_code.isdigit():
            if phonenumbers.is_valid_number(phonenumbers.parse(target)):
                message = input('\n enter the a message to send :')
            else:
                print('\n \033[91m The provided phone number is invalid \033[0;0m')
                continue
        else:
            print('\n \033[91m The provided phone number is invalid \033[0;0m')
            continue
    else:
        print('\n \033[91m an indicative must be provided like +33 \033[0;0m')
        continue

    break