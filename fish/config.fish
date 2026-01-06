if status is-interactive
# Commands to run in interactive sessions can go here
# ===== PDA COMMANDS =====
alias scan="ls"
alias anomalies="find . -maxdepth 2"
alias inventory="ls -lh"
alias map="pwd"
alias radiation="uptime"
alias signal="ping -c 3 8.8.8.8"
alias logs="dmesg | tail"
alias status="htop"
alias clearzone="clear"
alias loot="pkg install"
alias pick="pkg search"
alias gear="pkg update"

# ===== STARSHIP =====
starship init fish | source

# --- STALKER PDA BOOT ---
clear
set_color green
cat ~/.config/stalker_ascii.txt
set_color normal

fastfetch



end
