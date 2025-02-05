{
  description = "qtile dev";

  inputs = {
    main-flake.url = "path:../..";
  };

  outputs =
    { self, main-flake }:
    let
      system = main-flake.system;
      pkgs = main-flake.pkgs;
    in
    {

      devShells.${system}.default = pkgs.mkShell {
        name = "qtile-dev-shell";
        buildInputs = with pkgs; [ lolcat ];
        shellHook = ''
          echo "Welcome to the qtile dev shell" | lolcat
        '';
      };

    };
}
