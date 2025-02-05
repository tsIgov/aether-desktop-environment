{
	home = { ... }:
	{
		programs.hyprpanel = {
			settings = {
				bar.battery = {
					label = false;
					rightClick = "menu:powerdropdown";
				};

				menus.power = {
					confirmation = false;
					logout = "hyprctl dispatch exit";
					lowBatteryNotification = true;
					lowBatteryNotificationText = "Your battery is running low: ($POWER_LEVEL %).";
					lowBatteryNotificationTitle = "Warning = Low battery";
					lowBatteryThreshold = 15;
					reboot = "systemctl reboot";
					showLabel = true;
					shutdown = "systemctl poweroff";
					sleep = "systemctl suspend";
				};

				theme.bar.menus.menu.power.scaling = 90;
			};
		};
	};
}
