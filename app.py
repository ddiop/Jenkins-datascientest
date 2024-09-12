import os
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/api/hello")
def hello():
    return jsonify({"hello": "world"})

@app.route("/api/hello/<name>")
def hello_name(name):
    return jsonify({"hello": name})

@app.route("/api/whoami")
def whoami():
    return jsonify(
        name=request.remote_addr,
        ip=request.remote_addr,
        useragent=request.user_agent.string
    )

@app.route("/api/whoami/<name>")
def whoami_name(name):
    return jsonify(
        name=name,
        ip=request.remote_addr,
        useragent=request.user_agent.string
    )

@app.errorhandler(404)
def page_not_found(error):
    return jsonify({"error": "Page not found"}), 404

@app.errorhandler(500)
def internal_server_error(error):
    return jsonify({"error": "Internal server error"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
