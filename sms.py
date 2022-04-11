#!/usr/bin/env python
import os
import phonenumbers

os.system('clear')
os.system('bash banner.sh')


with open('key.txt') as f:
    lines = f.readlines()
    api_key = lines[0].split(':')[1]

try:
    import requests
except ImportError:
    print('Missing dependencies')

print("\033[94m Enter the information ask to send a message. \033[0;0m")

while True : 
    
    target = input('\n Enter the target phone number (+33600000000) : ')

    if target.startswith('+'):
        target_without_country_code = target.split('+', 1)[1]

        if len(target) > 7 and target_without_country_code.isdigit():

            if phonenumbers.is_valid_number(phonenumbers.parse(target)):

                message = input('\n enter the a message to send : ')

                res = requests.post('https://textbelt.com/text',{
                    'phone': target,
                    'message': message ,
                    'key': api_key
                })

                data = res.json()
                
                print("\033[92m \n Message sent succesfully \n \033[0m" if data['success'] else "\033[91m \n" + data['error'] + "\n \033[0;0m")

                print('\033[0;34m \n you can still send \033[0;33m' + str(data['quotaRemaining']) + '\033[0;34m messages \n \033[0;0m')
                
                input('\n Press Enter to exit...')

                os.system('clear')
                exit()


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

exit()