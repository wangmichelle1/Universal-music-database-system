import app
import pymysql

# This file is the main file which brings the application together.
# It controls the main events of the application.
# Run this file (using 'python index.py') to start the application.

appObject = app.init_app()

appObject.login_or_signup()

appObject.update_ss()

while True:
    try:
        result = appObject.prompt_action()
        if result:
            break
    except pymysql.Error as e:
        print(e)

print('Closing connection...')
appObject.close()
print('Connection closed.')
print('Exiting program. Have a nice day!')