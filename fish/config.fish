if status is-interactive
    # Commands to run in interactive sessions can go here

    # ===== MODERN TOOLING INITIALIZATION =====
    # Initialize zoxide (smart cd replacement)
    zoxide init fish | source
    alias cd="z"

    # Eza (Modern ls replacement with icons and formatting)
    alias ls="eza --icons --group-directories-first"
    alias la="eza -a --icons --group-directories-first"
    alias tree="eza --tree --icons"

    # Bat (Modern cat replacement with syntax highlighting)
    alias cat="bat --style=plain --paging=never"
    alias preview="bat"

    # ===== PDA COMMANDS =====
    alias scan="ls"                               # Now uses eza
    alias anomalies="find . -maxdepth 2"
    alias inventory="eza -lh --icons --git"       # Upgraded to eza long-view with git status
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
    cat ~/.config/stalker_ascii.txt | tr -d '\e[' # Strips hidden ANSI color codes if they exist
    set_color normal

    fastfetch

end
