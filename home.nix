{ config, pkgs, lib, ... }:

let
  pkgs_x86_64 = import <nixpkgs> { localSystem = "x86_64-darwin"; overlays = []; };
  curltime = pkgs.writeShellScriptBin "curltime" ''
    #!${pkgs.stdenv.shell}
    curl -w @- -o /dev/null -s "$@" <<'EOF'
        time_namelookup:  %{time_namelookup}\n
           time_connect:  %{time_connect}\n
        time_appconnect:  %{time_appconnect}\n
       time_pretransfer:  %{time_pretransfer}\n
          time_redirect:  %{time_redirect}\n
     time_starttransfer:  %{time_starttransfer}\n
                        ----------\n
             time_total:  %{time_total}\n
    EOF
  '';
  LS_COLORS = pkgs.fetchgit {
    url = "https://github.com/trapd00r/LS_COLORS";
    rev = "6fb72eecdcb533637f5a04ac635aa666b736cf50";
    sha256 = "0czqgizxq7ckmqw9xbjik7i1dfwgc1ci8fvp1fsddb35qrqi857a";
  };
  comma = import
    (pkgs.fetchFromGitHub {
      owner = "Shopify";
      repo = "comma";
      rev = "4a62ec17e20ce0e738a8e5126b4298a73903b468";
      sha256 = "0n5a3rnv9qnnsrl76kpi6dmaxmwj1mpdd2g0b4n1wfimqfaz6gi1";
    })
    { };
in
{
  nixpkgs.config = {
    allowUnfreePredicate = p: builtins.elem (lib.getName p) [
      "unrar"
    ];
  };
  home.packages = [
    # comma # Comma lets you run commands that you don't have installed by prepending a ,
    pkgs.nixpkgs-fmt # Format nix files
    pkgs.fishPlugins.foreign-env # For fish
    pkgs.unrar
    pkgs.ripgrep
    pkgs.youtube-dl
    pkgs.yt-dlp
    pkgs.ffmpeg
    curltime
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Use fzf finder
  programs.fzf.enable = true;

  # Bat is better cat
  programs.bat.enable = true;

  # htop is a better top
  programs.htop.enable = true;

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide.enable = true;

  # Automatically run shell.nix when entering directories

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  home.sessionVariables.DIRENV_LOG_FORMAT = "";

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rohan";
	home.homeDirectory = (if pkgs.stdenv.isDarwin then 
		  "/Users/rohan"
		else
		  "/home/rohan"
	);

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  home.sessionVariables.EDITOR = "vim";

  programs.git = {
    enable = true;
    userName = "Rohan Relan";
    userEmail = "roresemail@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ~/home-manager-config/extraConfig.vim;

    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-elixir
      vim-airline
      vim-airline-themes

      # colorscheme
      molokai
      gruvbox
      ayu-vim
    ];
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
          sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
        };
      }
    ];
    shellAliases = {
      ls = "${pkgs.coreutils}/bin/ls --color=auto -F";
      ll = "${pkgs.coreutils}/bin/ls --color=auto -F -l";
    };
    shellInit = ''
      # home-manager
      if test -e ~/.nix-profile/etc/profile.d/nix.sh
          fenv source ~/.nix-profile/etc/profile.d/nix.sh
      end
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end

      eval (${pkgs.coreutils}/bin/dircolors -c ${LS_COLORS}/LS_COLORS)
      fish_vi_key_bindings
    '';
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    completionInit = "autoload -U compinit && compinit -D";
    enableAutosuggestions = true;
    autocd = true;
    history = {
      path = "${config.xdg.dataHome}/zsh/.zsh_history";
      size = 50000;
      save = 50000;
    };
    shellAliases = {
      ls = "${pkgs.coreutils}/bin/ls --color=auto -F";
      ll = "${pkgs.coreutils}/bin/ls --color=auto -F -l";
    };

    initExtraFirst = ''
	# Nix
	if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
	  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
	fi
	# End Nix
   '';

    initExtraBeforeCompInit = ''
      eval $(${pkgs.coreutils}/bin/dircolors -b ${LS_COLORS}/LS_COLORS)
    '';

    initExtra = builtins.readFile ~/home-manager-config/post-compinit.zsh;

    profileExtra = ''
      if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';


    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "Aloxaf/fzf-tab"; }
				{ name = "jeffreytse/zsh-vi-mode"; }
      ];
    };

  }; # Close zsh
  home.file.".p10k.zsh".source = ~/home-manager-config/.p10k.zsh;

} # Close all
