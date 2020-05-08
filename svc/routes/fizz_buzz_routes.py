from flask import Blueprint, Response

from svc.utilities.fizz_buzz import fizz_buzz


FIZZ_BUZZ_BLUEPRINT = Blueprint('fizz_buzz', __name__)


@FIZZ_BUZZ_BLUEPRINT.route('/fizzBuzz/<num>')
def app_test(num):
    try:
        results = fizz_buzz(int(num))
        return Response(results, status=200)
    except ValueError as ex:
        return Response(ex, status=400)
