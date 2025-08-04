# Freshify

Freshify is a project designed to automate the installation and configuration of tools and packages across different Linux and macOS operating systems.

---

## Project Structure

<<<<<<< HEAD
=======
<<<<<<< HEAD
Freshify/
├── install.sh # Main script that orchestrates the installation
├── uninstall.sh # Test script to uninstall packages
├── packet_managers/
│ └── homebrew.sh # Script to install Homebrew if not already present
├── lib/
│ ├── color.sh # Functions to display colored messages in the terminal
│ └── utils.sh # General reusable functions for scripts
├── shells/
│ └── nu.sh # Script to install Nushell (modern shell)
├── config/ # Configuration files to be copied to the user’s system
└── README.md # Project documentation
=======
>>>>>>> develop

```
Freshify/
├── install.sh           # Main script that orchestrates the installation
├── uninstall.sh         # Test script to uninstall packages
├── packet_managers/
│   └── homebrew.sh      # Script to install Homebrew if not already present
├── lib/
│   ├── color.sh         # Functions to display colored messages in the terminal
│   └── utils.sh         # General reusable functions for scripts
├── shells/
│   └── nu.sh            # Script to install Nushell (modern shell)
├── config/              # Configuration files to be copied to the user’s system
└── README.md            # Project documentation
```
<<<<<<< HEAD
=======
>>>>>>> ef3ddf0358492e8a6404d51b76e9ae21e22e909f
>>>>>>> develop

---

## How It Works

- **install.sh**  
  This is the main entry point of the project.  
  It orchestrates the execution of specific scripts depending on the operating system and user needs. For example, it checks if Homebrew is installed and, if not, runs `packet_managers/homebrew.sh` to install it. It can also invoke scripts to install shells, configure packages, copy config files, etc.

- **uninstall.sh**  
  An experimental or test script to uninstall packages or revert configurations made by `install.sh`.

- **packet_managers/homebrew.sh**  
  Contains the process to install Homebrew, the package manager for macOS and Linux.

- **lib/color.sh**  
  Defines functions and variables to print colored messages in the terminal, improving readability and user experience during script execution.

- **lib/utils.sh**  
  A collection of general reusable functions used across various scripts to avoid duplication and facilitate maintenance.

- **shells/nu.sh**  
  Script dedicated to installing Nushell, a modern shell with advanced features.

- **config/**  
  Folder containing configuration files (dotfiles, settings, etc.) that will be copied or linked to the user’s system during installation.

---

## Basic Usage

To start the installation process, the user just needs to run:

bash ./install.sh

This script will take care of executing all the necessary tasks to install and configure the packages and tools planned for the project.
Contributions

The ideal way to contribute to Freshify is by creating new scripts that install or configure specific tools, libraries, or utilities.

Each new module or script should:

    Download or install a specific tool or package.

    Be placed logically within the project structure, such as in packet_managers/, shells/, config/, or lib/.

    Be called or integrated within install.sh to become part of the overall installation process.

This approach allows the project to grow modularly, keeping the code clean and maintainable.
