{
  description = "Kartograf workshop";
  inputs = {
    nixpkgs.url = "nixpkgs";
    kartograf.url = "github:asmap/kartograf";
    rpki-client.url = "github:asmap/rpki-client-nix";
    rpki-client.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, kartograf, rpki-client }: let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    kartograf-cli = kartograf.packages.${system}.default;
    rpki-cli = rpki-client.defaultPackage.${system};
    in {
    devShells = {
      ${system}.default = pkgs.mkShell {
        packages = [ kartograf-cli rpki-cli ];
      };
    };
  };
}
