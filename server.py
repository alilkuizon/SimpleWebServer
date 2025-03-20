from flask import Flask, request, jsonify, send_from_directory
import random
import os

app = Flask(__name__)

# Function to get a random port between 10000 and 20000
def get_random_port():
    return random.randint(10000, 20000)

# Directory where QML files are stored
QML_DIRECTORY = 'qml_files'

@app.route('/api/v1/getQML', methods=['POST'])
def get_qml():
    data = request.json
    filename = data.get('filename')

    if not filename:
        return jsonify({"error": "No filename provided"}), 400

    file_path = os.path.join(QML_DIRECTORY, filename)

    if not os.path.exists(file_path):
        return jsonify({"error": "File not found"}), 404

    return send_from_directory(QML_DIRECTORY, filename)

if __name__ == '__main__':
    port = get_random_port()
    print(f"Server is running on port {port}")
    app.run(host='127.0.0.1', port=port)