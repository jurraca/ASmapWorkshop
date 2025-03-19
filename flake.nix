{
  description = "Kartograf workshop";
  inputs = {
    nixpkgs.url = "nixpkgs";
    kartograf.url = "github:asmap/kartograf";
    kartograf.inputs.nixpkgs.follows = "nixpkgs";
    rpki-client.url = "github:asmap/rpki-client-nix";
    rpki-client.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    kartograf,
    rpki-client,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
        packages = [
          kartograf.packages.${system}.default
          rpki-client.defaultPackage.${system}
        ];
    };
  };
}
