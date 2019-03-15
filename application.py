from flask import Flask
application = Flask(__name__)

@application.route('/')
def hello_world():
   return "Hello Jenkins Automatic arive"

if __name__ == '__main__':
   application.run(debug = True)
