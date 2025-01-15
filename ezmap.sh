#!/bin/bash
#
#	███████╗███████╗███╗   ███╗ █████╗ ██████╗ 
#	██╔════╝╚══███╔╝████╗ ████║██╔══██╗██╔══██╗
#	█████╗    ███╔╝ ██╔████╔██║███████║██████╔╝
#	██╔══╝   ███╔╝  ██║╚██╔╝██║██╔══██║██╔═══╝ 
#	███████╗███████╗██║ ╚═╝ ██║██║  ██║██║     
#	╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  
#          Beginner-friendly Nmap Assistant
#                Created by 0xZ1R0


if ! command -v dialog &> /dev/null; then
    echo "The 'dialog' tool is required but not installed. Please install it and try again."
    exit 1
fi

show_menu() {
    CHOICE=$(dialog --menu "EzMap - Main Menu" 15 50 3 \
        1 "Scan" \
        2 "Help" \
        3 "About" 2>&1 >/dev/tty)

    case $CHOICE in
        1) perform_scan ;;
        2) show_help ;;
        3) show_about ;;
        *) clear; exit 0 ;;
    esac
}

perform_scan() {
    TARGET_IP=$(dialog --inputbox "Enter the target IP or hostname:" 8 40 2>&1 >/dev/tty)
    if [ -z "$TARGET_IP" ]; then
        return
    fi

    SCAN_TYPES=$(dialog --checklist "Select scan type(s):" 15 50 4 \
        1 "Port scan - Scan for open ports" off \
        2 "Service scan - Detect running services" off \
        3 "Network scan - Discover devices in network" off \
        4 "Full scan - Comprehensive scan" off 2>&1 >/dev/tty)

    if [ -z "$SCAN_TYPES" ]; then
        return
    fi

    INTENSITY=$(dialog --radiolist "Select scan intensity:" 15 50 5 \
        1 "Super Stealth scan (slow)" off \
        2 "Stealth scan" off \
        3 "Normal scan" on \
        4 "Fast scan" off \
        5 "Super Fast scan (potential DoS risk)" off 2>&1 >/dev/tty)

    if [ -z "$INTENSITY" ]; then
        return
    fi

    NMAP_CMD="nmap $TARGET_IP"

    for TYPE in $SCAN_TYPES; do
        case $TYPE in
            1) NMAP_CMD+=" -p-" ;; # Port scan
            2) NMAP_CMD+=" -sV" ;; # Service scan
            3) NMAP_CMD+=" -sn" ;; # Network scan
            4) NMAP_CMD+=" -A" ;;  # Full scan
        esac
    done

    case $INTENSITY in
        1) NMAP_CMD+=" --min-rate 1" ;; # Super Stealth
        2) NMAP_CMD+=" --min-rate 10" ;; # Stealth
        3) ;;                            # Normal (default)
        4) NMAP_CMD+=" --min-rate 100" ;; # Fast
        5) NMAP_CMD+=" --min-rate 1000" ;; # Super Fast
    esac

    OUTPUT_FILE=$(dialog --inputbox "Enter output filename (leave empty for no saving):" 8 40 2>&1 >/dev/tty)
    if [ $? -ne 0 ]; then
        return
    fi

    if [ -n "$OUTPUT_FILE" ]; then
        NMAP_CMD+=" -oN $OUTPUT_FILE"
    fi

    dialog --msgbox "The following command will be executed:\n\n$NMAP_CMD" 10 50

    clear
    echo "Running: $NMAP_CMD"
    eval $NMAP_CMD

    echo "\nScan completed. Press Enter to return to the main menu."
    read -r
}

show_help() {
    dialog --msgbox "EzMap Help:\n\n- Enter the target IP or hostname to scan.\n- Choose one or more scan types:\n  Port scan, Service scan, Network scan, Full scan.\n- Select scan intensity:\n  Super Stealth, Stealth, Normal, Fast, or Super Fast.\n- Optionally save the scan output to a file.\n- Review the Nmap command before execution." 15 50
}

show_about() {
    dialog --msgbox "EzMap - Beginner-friendly Nmap Assistant\n\nVersion: 0.4\nAuthor: 0xZ1R0\n\nEzMap simplifies Nmap scanning for beginners by providing an easy-to-use interface." 10 50
}

while true; do
    show_menu
done
