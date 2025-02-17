{
  description = "nixos config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nh fork that supports nix-darwin
    nh = {
      url = "github:ToyVo/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

    in
    {
      nixosConfigurations.nixos =
        let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
          };
          modules = [
            ./hosts/main/configuration.nix
            ./modules/sys

            home-manager.nixosModules.home-manager
            {
              home-manager = {

                useGlobalPkgs = true;
                useUserPackages = true;
                users.jt = {
                  imports = [
                    ./hosts/home.nix
                    ./modules/home
                  ];
                };
                extraSpecialArgs = { inherit pkgs; };
                sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
              };
            }
          ];
        };

      # homeConfigurations.jt = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;

      #   # Specify your home configuration modules here, for example,
      #   # the path to your home.nix.
      #   modules = [ ./home.nix ];

      #   # Optionally use extraSpecialArgs
      #   # to pass through arguments to home.nix
      # };
    };
}
