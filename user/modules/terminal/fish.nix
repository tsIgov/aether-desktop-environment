{ ... }:

{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting
			set fish_color_autosuggestion      brblack
			set fish_color_command             yellow
			set fish_color_comment             brmagenta
			set fish_color_end                 brmagenta
			set fish_color_error               brred
			set fish_color_escape              brblue #cyan
			set fish_color_operator            blue #cyan
			set fish_color_option            blue #cyan
			set fish_color_param               brcyan #blue
			set fish_color_quote               yellow
			set fish_color_redirection         bryellow

			set -x LS_COLORS "rs=0:di=01;31:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=01;31:*.ace=01;31:*.alz=01;31:*.apk=01;31:*.arc=01;31:*.arj=01;31:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cpio=01;31:*.crate=01;31:*.deb=01;31:*.drpm=01;31:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.egg=01;31:*.esd=01;31:*.gz=01;31:*.jar=01;31:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.pyz=01;31:*.rar=01;31:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tgz=01;31:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.udeb=01;31:*.war=01;31:*.whl=01;31:*.wim=01;31:*.xz=01;31:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90"
		'';
	};
}


# keys
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