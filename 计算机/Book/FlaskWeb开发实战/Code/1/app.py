from flask import Flask

app = Flask(__name__)


@app.route("/")
def index():
    return "<h1>Hello Flask!</h1>"

@app.route("/greet")
@app.route("/greet/<name>")
def greet(name="Andy"):
    return '<h1>Hello, %s!</h1>' % name

