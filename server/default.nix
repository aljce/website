{ rustPlatform }:
with rustPlatform;
buildRustPackage {
    name = "server";
    src = ./.;
    version = "0.0.0";
    depsSha256 = "";
}
