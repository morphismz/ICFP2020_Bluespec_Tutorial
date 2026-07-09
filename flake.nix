{
  description = "Dev environment for the ICFP 2020 Bluespec tutorial (rsnikhil/ICFP2020_Bluespec_Tutorial)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            bluespec   # bsc compiler + Bluesim (BLUESPECDIR is set by the wrapper)
            iverilog    # Icarus Verilog (iverilog/vvp)
            verilator  # faster Verilog simulation
            gnumake
            # gtkwave    # classic waveform viewer. Crashes with buffer overflow.
            surfer     # modern waveform viewer, replacement for gtkwave
          ];
        };
      });
}
