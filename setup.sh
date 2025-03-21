#!/bin/bash

# Update package lists
sudo apt update

# Install Python3 and pip if not already installed
sudo apt install -y python3 python3-pip python3-venv

# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install the required Python packages
pip install -r requirements.txt

# Deactivate the virtual environment
deactivate

echo "Setup complete. To run your Flask application:"
echo "1. Activate the virtual environment: source venv/bin/activate"
echo "2. Run webserver application: python server.py"
echo "3. When done, deactivate the environment: deactivate"
