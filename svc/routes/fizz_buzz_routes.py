from flask import Blueprint

from svc.utilities.fizz_buzz import fizz_buzz


FIZZ_BUZZ_BLUEPRINT = Blueprint('fizz_buzz', __name__)


@FIZZ_BUZZ_BLUEPRINT.route('/fizzBuzz/<num>')
def app_test(num):
    results = fizz_buzz(int(num))
    return results
