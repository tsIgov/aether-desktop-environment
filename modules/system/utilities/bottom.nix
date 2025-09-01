{
	system = { pkgs, aether, ... }:
	{
		environment.systemPackages = with pkgs; [
			bottom # Activity monitoring TUI
		];
	};
	home = { config, aether, ... }:
	let
		palette = aether.lib.appearance.getPalette { inherit config; };
	in
	{
		wayland.windowManager.hyprland = {
			extraConfig = ''
				bind = SUPER SHIFT, Escape, exec, kitty --class btm btm
			'';

			settings = {
				windowrulev2 = [
					"float, class:(btm)"
					"center, class:(btm)"
					"size 50% 50%, class:(btm)"
				];
			};
		};

		home.file.".config/bottom/bottom.toml".text = ''
			[flags]
			hide_avg_cpu = false
			dot_marker = false
			rate = "1s"
			cpu_left_legend = true
			current_usage = false # Whether to set CPU% on a process to be based on the total CPU or just current usage.
			unnormalized_cpu = false # Whether to set CPU% on a process to be based on the total CPU or per-core CPU% (not divided by the number of cpus).
			group_processes = true
			case_sensitive = false
			whole_word = false
			regex = false
			temperature_type = "c"
			default_time_value = "60s"
			time_delta = 15000
			hide_time = true
			default_widget_type = "proc"
			expanded = false
			basic = false
			hide_table_gap = true
			battery = true
			disable_click = false
			process_memory_as_value = true
			tree = false
			show_table_scroll_position = true
			enable_gpu = false
			enable_cache_memory = false
			retention = "10m"
			memory_legend = "top-left"
			network_legend = "top-left"

			[processes]
			# PID, Name, CPU%, Mem%, R/s, W/s, T.Read, T.Write, User, State, Time, GMem%, GPU%
			columns = ["PID", "Name", "CPU%", "Mem%", "R/s", "W/s", "T.Read", "T.Write", "User", "State", "GMem%", "GPU%"]

			[cpu]
			# One of "all" (default), "average"/"avg"
			default = "all"

			[styles]

				[styles.cpu]
				all_entry_color = "#${palette.secondary}"
				avg_entry_color = "#${palette.primary}"
				cpu_core_colors = ["#${palette.text}"]

				[styles.memory]
				ram_color = "#${palette.primary}"
				cache_color = "#${palette.overlay0}"
				swap_color = "#${palette.text}"
				arc_color = "#${palette.overlay1}"
				gpu_colors = ["#${palette.secondary}", "#${palette.tertiary}"]

				[styles.network]
				rx_color = "#${palette.primary}"
				rx_total_color = "#${palette.primary}"
				tx_color = "#${palette.secondary}"
				tx_total_color = "#${palette.secondary}"

				[styles.battery]
				high_battery_color = "green"
				medium_battery_color = "yellow"
				low_battery_color = "red"

				[styles.tables]
				headers = {color = "#${palette.primary}", bold = true}

				[styles.graphs]
				graph_color = "#${palette.overlay2}"
				legend_text = {color = "#${palette.subtext1}"}

				[styles.widgets]
				border_color = "#${palette.overlay0}"
				selected_border_color = "#${palette.primary}"
				widget_title = {color = "#${palette.text}"}
				text = {color = "#${palette.text}"}
				selected_text = {color = "#${palette.primary}", bg_color = "#${palette.base}", bold = true}
				disabled_text = {color = "#${palette.subtext1}"}

			[[row]]
			ratio=40

				[[row.child]]
				type="cpu"
				ratio=45

				[[row.child]]
				type="mem"
				ratio=30

				[[row.child]]
				ratio=25

					[[row.child.child]]
					type="temp"
					ratio=60

					[[row.child.child]]
					type="batt"
					ratio=40

			[[row]]
			ratio=60

				[[row.child]]
				ratio=30

						[[row.child.child]]
						type="disk"
						ratio=30

						[[row.child.child]]
						type="net"
						ratio=70

				[[row.child]]
				ratio=70
				type="proc"
				default=true
		'';
	};

}
