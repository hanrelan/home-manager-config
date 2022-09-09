{ pkgs ? import <nixpkgs> { } }:

with pkgs;
let basePackages = [
  elixir
  postgresql_14
];
in
mkShell {
  buildInputs = basePackages
    ++ lib.optional stdenv.isLinux inotify-tools
    ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
    CoreFoundation
    CoreServices
  ]);
  shellHook = ''
    # elixir config
    mkdir -p .nix-mix
    mkdir -p .nix-hex
    export MIX_HOME=$PWD/.nix-mix
    export HEX_HOME=$PWD/.nix-hex
    export PATH=$NIX_HOME/bin:$PATH
    export PATH=$HEX_HOME/bin:$PATH
    export LANG=en_US.UTF-8
    export ERL_AFLAGS="-kernel shell_history enabled"

    # postgres config
    export PGHOST=$PWD/postgres
    export PGDATA=$PGHOST/data
    export LOG_PATH=$PGHOST/postgres/LOG
    export PGDATABASE=postgres
    export DATABASE_URL="postgresql:///postgres?host=$PGHOST"
    if [ ! -d $PGHOST ]; then
      mkdir -p $PGHOST
    fi
    if [ ! -d $PGDATA ]; then
      echo 'Initializing postgresql database...'
      initdb $PGDATA -U postgres --auth=trust --no-locale --encoding=UTF8 >/dev/null
      echo "unix_socket_directories = '$PGHOST'" >> $PGDATA/postgresql.conf
      echo "listen_addresses = ' '" >> $PGDATA/postgresql.conf
      echo "log_directory = '$LOG_PATH'" >> $PGDATA/postgresql.conf
      echo "Initialized database - add 'socket_dir: System.get_env("PGHOST")' to dev.exs"
      echo "Run 'pg_ctl start' to start the database"
    fi
  '';
}
