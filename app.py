from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def home():
    return "Calvant DevSecOps Security Pipeline Demo Running"

@app.route("/login")
def login():
    username = request.args.get("username")
    password = request.args.get("password")
    return f"Username: {username}, Password: {password}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
