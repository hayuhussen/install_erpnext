
# install_erpnext
# ERPNext Installation Script

This repository contains a streamlined bash script to install ERPNext on Ubuntu. The script handles server setup, dependency installation, Frappe Bench initialization, site creation, and optional production configuration.

## Features

- Installs all necessary dependencies, including MariaDB, Redis, Node.js, Python, and wkhtmltopdf.
- Initializes Frappe Bench with the specified branch.
- Automates ERPNext and additional app installations.
- Configures production mode with Nginx and Supervisor (optional).
- Supports adding the site to `/etc/hosts`.

## Prerequisites

- A fresh Ubuntu server (20.04 or later recommended).
- SSH access with `sudo` privileges.
- Basic knowledge of Linux commands.

## Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/hayuhussen/install_erpnext.git
   cd install_erpnext


2, Make the Script Executable:

     chmod +x install_erpnext.sh

3, Run the Script:

    ./install_erpnext.sh

    Follow the Prompts:
        Enter the site name and app names as prompted.
        Choose whether to enable production mode.

Example Output

After installation, the script will display the URL for accessing ERPNext:

    Development mode: http://<your-site-name>:8000
    Production mode: http://<your-site-name>

Notes

    The script assumes you have sufficient permissions to perform system-wide changes.
    Customize the script as needed for specific environments or additional apps.

Contributing

Feel free to fork this repository and submit pull requests with improvements or bug fixes.
License

This project is licensed under the MIT License. See the LICENSE file for details.
