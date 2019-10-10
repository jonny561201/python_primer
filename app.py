#!/usr/bin/env python
from flask import Flask

from utilities.fizz_buzz import fizz_buzz

app = Flask(__name__)


@app.route('/fizzBuzz/<num>')
def app_test(num):
    results = fizz_buzz(int(num))
    return results


app.run(debug=True)