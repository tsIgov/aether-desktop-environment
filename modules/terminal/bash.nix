{ config, aether, ... }:
let
	codeMap = {
		rosewater = "37";
		flamingo = "97";
		pink = "95";
		mauve = "35";
		red = "31";
		maroon = "91";
		peach = "93";
		yellow = "33";
		green = "32";
		teal = "92";
		sky = "36";
		sapphire = "96";
		blue = "34";
		lavender = "94";
	};

	palette = aether.lib.appearance.getPalette { inherit config; };

	primaryColor = config.aether.appearance.colors.primary;
	secondaryColor = config.aether.appearance.colors.secondary;
	tertiaryColor = config.aether.appearance.colors.tertiary;
	errorColor = config.aether.appearance.colors.error;

	primaryCode = codeMap.${primaryColor};
	secondaryCode = codeMap.${secondaryColor};
	tertiaryCode = codeMap.${tertiaryColor};
	errorCode = codeMap.${errorColor};

in
{
	programs.bash = {
		interactiveShellInit = ''
			LS_COLORS="di=01;${primaryCode}:tw=01;${primaryCode}:ow=01;${primaryCode}:ln=03;${secondaryCode}:pi=${tertiaryCode}:so=${tertiaryCode}:do=${tertiaryCode}:bd=${tertiaryCode}:cd=${tertiaryCode}:or=${errorCode}:mi=${errorCode}:ex=01;${secondaryCode}:"

			export LS_COLORS

			eval $(starship init bash)
		'';
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

# ECMA-48 Select Graphic Rendition

# The   ECMA-48  SGR  sequence  ESC  [  parameters  m  sets  display
# attributes.  Several attributes can be set in the  same  sequence,
# separated  by  semicolons.  An empty parameter (between semicolons
# or string initiator or terminator) is interpreted as a zero.
# param      result
# 0          reset all attributes to their defaults
# 1          set bold
# 2          set half-bright (simulated with color on a color display)
# 3          set italic (since Linux 2.6.22; simulated with color on a color display)
# 4          set underscore (simulated with color on a color display) (the colors
# 			used to simulate dim or underline are set using ESC ] ...)
# 5          set blink
# 7          set reverse video
# 10         reset selected mapping, display control flag, and toggle meta flag
# 			(ECMA-48 says "primary font").
# 11         select null mapping, set display control flag, reset toggle meta flag
# 			(ECMA-48 says "first alternate font").
# 12         select null mapping, set display control flag, set toggle meta flag
# 			(ECMA-48 says "second alternate font").  The toggle meta flag causes the
# 			high bit of a byte to be toggled before the mapping table translation is
# 			done.
# 21         set underline; before Linux 4.17, this value set normal intensity (as is
# 			done in many other terminals)
# 22         set normal intensity
# 23         italic off (since Linux 2.6.22)
# 24         underline off
# 25         blink off
# 27         reverse video off
# 30         set black foreground
# 31         set red foreground
# 32         set green foreground
# 33         set brown foreground
# 34         set blue foreground
# 35         set magenta foreground
# 36         set cyan foreground
# 37         set white foreground
# 38         256/24-bit foreground color follows, shoehorned into 16 basic colors
# 			(before Linux 3.16: set underscore on, set default foreground color)
# 39         set default foreground color (before Linux 3.16: set underscore off, set
# 			default foreground color)
# 40         set black background
# 41         set red background
# 42         set green background
# 43         set brown background
# 44         set blue background
# 45         set magenta background
# 46         set cyan background
# 47         set white background
# 48         256/24-bit background color follows, shoehorned into 8 basic colors
# 49         set default background color
# 90..97     set foreground to bright versions of 30..37
# 100..107   set background, same as 40..47 (bright not supported)

# Commands 38 and 48 require further arguments:
# ;5;x       256 color: values 0..15 are IBGR  (black,  red,  green,
# 			...  white),  16..231  a  6x6x6  color cube, 232..255 a
# 			grayscale ramp
# ;2;r;g;b   24-bit color, r/g/b components are in the range 0..255
