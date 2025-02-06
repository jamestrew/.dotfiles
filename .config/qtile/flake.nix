{
  description = "qtile dev";

  # i'm not sure if this is right
  # qtile path is different from the base nixos qtile path
  inputs = {
    main-flake.url = "path:../..";
  };

  outputs =
    { self, main-flake }:
    let
      pkgs = main-flake.nixosConfigurations.nixos.pkgs;
      system = pkgs.system;
    in
    {

      devShells.${system}.default = pkgs.mkShell {
        name = "qtile-dev-shell";
        buildInputs = with pkgs; [
          python3Packages.qtile
          python3Packages.qtile-extras
          python3Packages.python-dateutil
          basedpyright
          ruff
        ];
        shellHook = ''
          echo "Welcome to the qtile dev shell" | lolcat
        '';
      };

    };
}
