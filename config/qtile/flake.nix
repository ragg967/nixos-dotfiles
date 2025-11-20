{
  description = "Project development environment";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          python314
          pyright
          ruff
        ];

        shellHook = ''
          export PROJECT_ROOT=$(pwd)
          echo "Development environment loaded!"
        '';
      };
    };
}
