{ config, pkgs, ... }:

let
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
  home.packages = [ 
    comma # Comma lets you run commands that you don't have installed by prepending a ,
    pkgs.nixpkgs-fmt # Format nix files
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Bat is better cat
  programs.bat.enable = true;

  # Automatically run shell.nix when entering directories
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rohan";
  home.homeDirectory = "/Users/rohan";

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

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./home/extraConfig.vim;

    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-airline
      vim-airline-themes

      # colorscheme
      molokai
      gruvbox
      ayu-vim
    ];
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
    };

    initExtraBeforeCompInit = ''
      eval $(${pkgs.coreutils}/bin/dircolors -b ${LS_COLORS}/LS_COLORS)
    '';

    initExtra = builtins.readFile ~/home/post-compinit.zsh;


    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };

  }; # Close zsh


} # Close all
