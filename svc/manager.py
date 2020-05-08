from flask import Flask

from svc.routes.fizz_buzz_routes import FIZZ_BUZZ_BLUEPRINT


def create_app(app_name):
    if app_name == '__main__':
        app = Flask(app_name)
        app.register_blueprint(FIZZ_BUZZ_BLUEPRINT)

        return app
