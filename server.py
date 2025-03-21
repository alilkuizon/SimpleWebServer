from flask import Flask, request, jsonify, send_from_directory
import random
import os
import threading

app = Flask(__name__)

def get_random_port():
    return random.randint(10000, 20000)

def write_port_to_file(port, filename='../server_port.txt'):
    with open(filename, 'w') as file:
        file.write(str(port))
        file.write('\n') 

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

@app.route('/api/v1/shutdown', methods=['POST'])
def shutdown():
    """Forcefully stops the Flask application."""
    print("Shutting down the server...")
    os._exit(0)  # Immediately exits the Python process

if __name__ == '__main__':
    port = get_random_port()
    write_port_to_file(port)
    print(f"Server is running on port {port}")

    # Run Flask in a separate thread so that it can be stopped
    server_thread = threading.Thread(target=app.run, kwargs={"host": "127.0.0.1", "port": port})
    server_thread.start()
