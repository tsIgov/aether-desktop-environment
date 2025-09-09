#!/bin/sh

SIGNAL_ICONS=("󰤟 " "󰤢 " "󰤥 " "󰤨 ")
SECURED_SIGNAL_ICONS=("󰤡 " "󰤤 " "󰤧 " "󰤪 ")
WIFI_CONNECTED_ICON=" "
ETHERNET_CONNECTED_ICON=" "

manage_wifi() {
    nmcli --terse --fields "IN-USE,SIGNAL,SECURITY,SSID" device wifi list > /tmp/wifi_list.txt

    local ssids=()
    local formatted_ssids=()
    local active_ssid=""

    while IFS=: read -r in_use signal security ssid; do
        if [ -z "$ssid" ]; then continue; fi

        local signal_icon="${SIGNAL_ICONS[3]}"
        local signal_level=$((signal / 25))
        if [[ "$signal_level" -lt "${#SIGNAL_ICONS[@]}" ]]; then
            signal_icon="${SIGNAL_ICONS[$signal_level]}"
        fi

        if [[ "$security" =~ WPA || "$security" =~ WEP ]]; then
            signal_icon="${SECURED_SIGNAL_ICONS[$signal_level]}"
        fi


        local formatted="$signal_icon $ssid"
        if [[ "$in_use" =~ \* ]]; then
            active_ssid="$ssid"
            formatted="$WIFI_CONNECTED_ICON $formatted"
        fi
        ssids+=("$ssid")
        formatted_ssids+=("$formatted")
    done < /tmp/wifi_list.txt

    local formatted_list=""
    for formatted_ssid in "${formatted_ssids[@]}"; do
        formatted_list+="$formatted_ssid\n"
    done

    formatted_list=$(printf "%s" "$formatted_list" | rev | cut -c3- | rev)

    local chosen_network=$(echo -e "$formatted_list" | "${rofi_command[@]}" "Wi-Fi SSID")
    local ssid_index=-1
    for i in "${!formatted_ssids[@]}"; do
        if [[ "${formatted_ssids[$i]}" == "$chosen_network" ]]; then
            ssid_index=$i
            break
        fi
    done

    local chosen_id="${ssids[$ssid_index]}"

    if [ -z "$chosen_network" ]; then
        rm /tmp/wifi_list.txt
        return
    else
        local action
        if [[ "$chosen_id" == "$active_ssid" ]]; then
            action="  Disconnect"
        else
            action="󰸋  Connect"
        fi

        action=$(echo -e "$action\n  Forget" | "${rofi_command[@]}" "Action")
        case $action in
            "󰸋  Connect")
                local success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."
                local saved_connections=$(nmcli -g NAME connection show)
                if [[ $(echo "$saved_connections" | grep -Fx "$chosen_id") ]]; then
                    nmcli connection up id "$chosen_id" | grep "successfully" && notify-send -e -a network-menu "Connection Established" "$success_message"
                else
                    local wifi_password=$("${rofi_command[@]}" "Password" -password)
                    nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && notify-send -e -a network-menu "Connection Established" "$success_message"
                fi
                ;;
            "  Disconnect")
				device=$(nmcli device | grep " wifi " | awk '{print $1}')
                nmcli device disconnect $device && notify-send -e -a network-menu "Disconnected" "You have been disconnected from $chosen_id."
                ;;
            "  Forget")
                nmcli connection delete id "$chosen_id" && notify-send -e -a network-menu "Forgotten" "The network $chosen_id has been forgotten."
                ;;
        esac
    fi

    rm /tmp/wifi_list.txt
}

manage_ethernet() {
    local eth_devices=$(nmcli device status | (grep "ethernet" || true) | (grep -v "unavailable" || true) | awk '{print $1}')
    if [ -z "$eth_devices" ]; then
        notify-send -e -a network-menu "Error" "No ethernet devices available."
        return
    fi

    local eth_list=""
    for dev in $eth_devices; do
        local dev_status=$(nmcli device status | grep "$dev" | awk '{print $3}')
        if [ "$dev_status" = "connected" ]; then
            eth_list+="$ETHERNET_CONNECTED_ICON$dev\n"
        else
            eth_list+="$dev\n"
        fi
    done
	eth_list=$(echo $eth_list | rev | cut -c3- | rev)

    local chosen_device=$(echo -e "$eth_list" | "${rofi_command[@]}" "Select Ethernet Device")

    if [ -z "$chosen_device" ]; then
        return
    fi

    chosen_device=$(echo $chosen_device | sed "s/$ETHERNET_CONNECTED_ICON//")
    local device_status=$(nmcli device status | grep "$chosen_device" | awk '{print $3}')

    if [ "$device_status" = "connected" ]; then
        nmcli device disconnect "$chosen_device" && notify-send -e -a network-menu "Disconnected" "You have been disconnected from $chosen_device."
    elif [ "$device_status" = "disconnected" ]; then
        nmcli device connect "$chosen_device" && notify-send -e -a network-menu "Connected" "You are now connected to $chosen_device."
    elif [ "$device_status" = "unavailable" ]; then
        notify-send -e -a network-menu "Error" "$chosen_device is unavailable."
    else
        notify-send -e -a network-menu "Error" "Unable to determine the action for $chosen_device."
    fi
}

main_menu() {
    local wifi_status=$(nmcli -fields WIFI g)
    local wifi_toggle
    if [[ "$wifi_status" =~ "enabled" ]]; then
        wifi_toggle="󰤮  Disable Wi-Fi"
        wifi_toggle_command="off"
        manage_wifi_btn="\n󰀂  Manage Wi-Fi Networks"
    else
        wifi_toggle="󱚽  Enable Wi-Fi"
        wifi_toggle_command="on"
        manage_wifi_btn=""
    fi

    local chosen_option=$(echo -e "$wifi_toggle$manage_wifi_btn\n󰈀  Manage Ethernet" | "${rofi_command[@]}" "  Network Management")
    case $chosen_option in
        "$wifi_toggle")
            nmcli radio wifi $wifi_toggle_command
            ;;
        "󰀂  Manage Wi-Fi Networks")
            manage_wifi
            ;;
        "󰈀  Manage Ethernet")
            manage_ethernet
            ;;
    esac
}

rofi_command=(rofi -dmenu -i -no-show-icons -theme-str 'window { location: north east; anchor: north east; width: 400px; x-offset: -10; }' -p)
main_menu "$@"
