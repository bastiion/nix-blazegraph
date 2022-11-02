{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };

  outputs = { self, nixpkgs }: let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      buildInputs = with pkgs; [ makeWrapper curl jdk8 ];
  in {
    packages.${system} = rec {
      blazegraphJar = pkgs.fetchurl {
        name = "blazegraph";
        url = "https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_RELEASE_2_1_5/blazegraph.jar";
        sha256 = "043nfc6mgmd5mxmwfcfl082y96iaqnwminn4rxbizxrs3dzaxbpv";
      };
      bootstrapBlazegraph = pkgs.runCommand "bootstrapBlazegraph" {
          inherit buildInputs;
        } ''
          mkdir -p $out/bin
          cp ${./bootstrapBlazegraph.sh} $out/bin/bootstrapBlazegraph
          wrapProgram "$out/bin/bootstrapBlazegraph" \
              --prefix PATH : $PATH --prefix BLAZEGRAPH_JAR : ${blazegraphJar}
        '';
      runBlazegraph = pkgs.runCommand "startBlazegraph" {
          inherit buildInputs;
      } ''
         mkdir -p $out/bin
         cp ${./startBlazegraph.sh} $out/bin/startBlazegraph
         wrapProgram "$out/bin/startBlazegraph" \
             --prefix PATH : $PATH --prefix BLAZEGRAPH_JAR : ${blazegraphJar}
       '';
      load = pkgs.runCommand "dataloader" {
          inherit buildInputs;
      } ''
         mkdir -p $out/bin
         cp ${./dataloader.sh} $out/bin/dataloader
         wrapProgram "$out/bin/dataloader" \
             --prefix PATH : $PATH --prefix BLAZEGRAPH_JAR : ${blazegraphJar}
       '';
      export = pkgs.runCommand "dataexporter" {
          inherit buildInputs;
      } ''
         mkdir -p $out/bin
         cp ${./dataexporter.sh} $out/bin/dataexporter
         wrapProgram "$out/bin/dataexporter" \
             --prefix PATH : $PATH --prefix BLAZEGRAPH_JAR : ${blazegraphJar}
       '';
    };

  };
}
