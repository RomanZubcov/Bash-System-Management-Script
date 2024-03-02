# System Utilities Bash Script

## Overview

This Bash script provides a simple, menu-driven interface for performing a variety of system utility tasks. From displaying information about the operating system to managing directories and files, this script facilitates basic system administration tasks directly from the command line.

## Features

- **Exit:** Terminate the script execution.
- **Display information about the operating system:** Shows details like server name, operating system type, Bash version, and current working directory.
- **Display the first 3 installed shells on the system:** Lists the first three shells installed, as recorded in `/etc/shells`.
- **Display information about the network:** Provides the IP address of the network interface and the gateway.
- **Create directory:** Allows the user to create a new directory by specifying its name.
- **Copy file:** Copies a specified file to a previously created directory.
- **Delete directory:** Deletes a specified directory and all its contents.
- **Search command:** Searches the command history for commands matching a given keyword.
- **Display all log files:** Lists all log files located in `/var/log`.

## Prerequisites

- A Linux-based operating system with a Bash shell environment.
- Necessary permissions to perform system administration tasks, such as creating and deleting directories or modifying system files.

## Usage

**Start the Script:** Navigate to the directory containing the script and run it using the command:
   ```bash
   ./script_name.sh

