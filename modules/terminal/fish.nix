{
	home = { config, aether, ... }:
	let 
		palette = aether.lib.appearance.getPalette { inherit config; };
	in
	{
		programs.fish = {
			enable = true;
			interactiveShellInit = ''
				set fish_greeting
				set fish_color_autosuggestion      	${palette.surface2}
				set fish_color_command             	${palette.accent}
				set fish_color_comment             	${palette.surface2}
				set fish_color_end                 	${palette.sky}
				set fish_color_error               	${palette.red}
				set fish_color_escape              	${palette.pink}
				set fish_color_keyword				${palette.accent}
				set fish_color_operator				${palette.sky}
				set fish_color_option            	${palette.yellow}
				set fish_color_param              	${palette.blue}
				set fish_color_quote               	${palette.green}
				set fish_color_redirection         	${palette.sapphire}

				set -x LS_COLORS "di=01;35:ln=34:pi=36:so=36:do=36:bd=33:cd=33:or=31:mi=31:ex=01;32:"
			'';
		};
	};
}

# LS_COLORS keys
# ----
# no  NORMAL, NORM                Global default, although everything should
#                                 be something
# fi  FILE                        Normal file
# di  DIR                         Directory
# ln  SYMLINK, LINK, LNK          Symbolic link. If you set this to `target`
#                                 instead of a numerical value, the color is as
#                                 for the file pointed to
# pi  FIFO, PIPE                  Named pipe
# do  DOOR                        Door
# bd  BLOCK, BLK                  Black device
# cd  CHAR, CHR                   Character device
# or  ORPHAN                      Symbolic link pointing to a non-existent file
# so  SOCK                        Socket
# su  SETUID                      File that is setuid (u+s)
# sg  SETGID                      File that is setgid (g+s)
# tw  STICKY_OTHER_WRITABLE       Directory that is sticky and other-writable
#                                 (+t,o+w)
# ow  OTHER_WRITABLE              Directory that is other-writable (o+w) and
#                                 not sticky
# st  STICKY                      Directory with the sticky bit set (+t) and
#                                 not other-writable
# ex  EXEC                        Executable file (i.e. has `x` set
#                                 in permissions)
# mi  MISSING                     Non-existent file pointed to by a symbolic link
#                                 (visible when you type ls -l)
# lc  LEFTCODE, LEFT              Opening terminal code
# rc  RIGHTCODE, RIGHT            Closing terminal code
# ec  ENDCODE, END                Non-filename text
# *.extension                     Every file using this extension e.g. *.jpg

# effects
# -------
# 00  Default colour
# 01  Bold
# 04  Underlined
# 05  Flashing text
# 07  Reversetd
# 08  Concealed

# colours                         backgrounds
# -------                         -----------
# 30  Black                       40      Black background
# 31  Red                         41      Red background
# 32  Green                       42      Green background
# 33  Orange                      43      Orange background
# 34  Blue                        44      Blue background
# 35  Purple                      45      Purple background
# 36  Cyan                        46      Cyan background
# 37  Grey                        47      Grey background