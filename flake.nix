{
  description = "simple nix flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: nixpkgs.legacyPackages.${system};
    in
    {
      # packages.${system}.default = pkgs.callPackage ./package.nix { };
      packages = forAllSystems (system: {
        default = (pkgsFor system).callPackage ./package.nix { };
      });

      devShells = forAllSystems (system: {
        default = (pkgsFor system).mkShell {
          packages = with (pkgsFor system); [
            nix-output-monitor
          ];
        };
      });

      # devShells.${system}.default = pkgs.mkShell {
      #   packages = with pkgs; [
      #     nix-output-monitor
      #   ];
      # };
    };
}
