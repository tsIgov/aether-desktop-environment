{ ... }:
{
	aether.power = {
		idle-timers = {
			on-battery = {
				dim-screen = 120;
				lock = 180;
				turn-off-display = 240;
				suspend = 300;
			};

			plugged = {
				dim-screen = -1;
				lock = 900;
				turn-off-display = 3600;
				suspend = -1;
			};
		};

		wakeup-devices = [
			# { vendor = "046d"; product = "c548"; wakeup = false; }
			# { vendor = "35ef"; product = "0012"; wakeup = true; }
		];
	};
}
