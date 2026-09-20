{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkgs,
}:
rustPlatform.buildRustPackage {
  pname = "mirador";
  version = "1.13.1";
  src = fetchFromGitHub {
    owner = "crayonnova";
    repo = "mirador";
    rev = "v1.13.1";
    hash = "sha256-BKqsKdyRjoDE2NuJii8rq5WVM4LqSjx20CUAqgvfd0k=";
  };

  cargoHash = "sha256-VY1zheZwpnXtIiIfGMfbq3EgfLx5qHl+DyAZzMg27fs=";

  checkInputs = [
    pkgs.tzdata
  ];

  preCheck = ''
    export TZDIR='${pkgs.tzdata}/share/zoneinfo';
  '';

  strictDeps = true;

  meta = {
    description = "A termi";
    homepage = "";
    license = lib.licenses.mit;
    mainProgram = "mirador";
  };
}
