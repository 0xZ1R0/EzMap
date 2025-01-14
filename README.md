# EzMap

EzMap is a beginner-friendly tool designed to make Nmap easier to use by providing an interactive terminal interface with checkboxes and helpful descriptions for each option.

## Features
- Interactive menu for selecting scan types and intensities.
- Beginner-friendly descriptions for each scan type and intensity.
- Shows the Nmap command being run, helping users learn while scanning.
- Option to save scan results to a file.
- Displays estimated scan time for user convenience.

## Dependencies
To use EzMap, ensure the following dependencies are installed:

1. **Nmap**:
   - Install with:
     ```bash
     sudo apt-get install nmap
     ```

2. **Dialog**:
   - Install with:
     ```bash
     sudo apt-get install dialog
     ```

## Installation
1. Clone the repository or download the script.
   ```bash
   git clone https://github.com/0xZ1R0/EzMap
   cd EzMap
   ```

2. Make the script executable:
   ```bash
   chmod +x ezmap.sh
   ```

3. Run the script:
   ```bash
   ./ezmap.sh
   ```

## How to Use
1. Launch the tool by running the script.
2. Follow the on-screen instructions:
   - Select the desired scan type(s) from the checklist.
   - Choose the scan intensity from the options provided.
   - Optionally, provide a filename to save the results.
3. The tool will display the Nmap command being run.
4. View the progress and results directly in the terminal.

## Purpose
EzMap aims to:
- Simplify the use of Nmap for beginners.
- Provide an educational interface to help users learn Nmap commands.
- Improve productivity by automating and streamlining common scan configurations.

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Submit a pull request with a detailed description of your changes.

---

Happy scanning with EzMap!
