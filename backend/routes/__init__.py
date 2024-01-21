from flask import Flask

def create_app():
    app = Flask(__name__)
    app.register_blueprint(feature_one)
    app.register_blueprint(feature_two)
    return app
