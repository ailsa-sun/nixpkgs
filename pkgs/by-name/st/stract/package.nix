{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  openssl,
  curl,
  fetchurl,
}:

rustPlatform.buildRustPackage rec {
  pname = "stract";
  version = "unstable-2024-08-27";

  src = fetchFromGitHub {
    owner = "StractOrg";
    repo = pname;
    rev = "c6119e31d73407986de212073a904ec09c80d104";
    hash = "sha256-a7Y41bX98fvWwhwuDvhJoIgHO5sbTWVXKKxUH51zhE0=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "bincode-2.0.0-rc.3" = "sha256-bKFP7vdDl/ex6aA0/mYybZqgaM8mawpYe+YLtIio1qE=";
    };
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    openssl
    curl
  ];

  SWAGGER_UI_DOWNLOAD_URL =
    let
      # When updating:
      # - Look for the version of `utopia-swagger-ui` at:
      #   https://github.com/EricLBuehler/mistral.rs/blob/v<MISTRAL-RS-VERSION>/mistralrs-server/Cargo.toml
      # - Look at the corresponding version of `swagger-ui` at:
      #   https://github.com/juhaku/utoipa/blob/utoipa-swagger-ui-<UTOPIA-SWAGGER-UI-VERSION>/utoipa-swagger-ui/build.rs#L21-L22
      swaggerUiVersion = "5.17.12";

      swaggerUi = fetchurl {
        url = "https://github.com/swagger-api/swagger-ui/archive/refs/tags/v${swaggerUiVersion}.zip";
        hash = "sha256-HK4z/JI+1yq8BTBJveYXv9bpN/sXru7bn/8g5mf2B/I=";
      };
    in
    "file://${swaggerUi}";

  doCheck = false;
  meta = {
    description = "Fast line-oriented regex search tool, similar to ag and ack";
    homepage = "https://github.com/BurntSushi/ripgrep";
    license = lib.licenses.unlicense;
    maintainers = [ ];
  };
}
