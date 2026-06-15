{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gopls
    wrk
    go
    gcc
    delve
    golines
    golangci-lint
    cosign # Used to sign container images.
    esbuild # Used to package JS examples.
    goreleaser
    gotestsum
    govulncheck
    ko # Used to build Docker images.
    nodejs # Used to build templ-docs.
    prettier # Used for formatting JS and CSS.
    xc
    templ
    tinygo
  ];

  programs.nvf.settings.vim.languages.go = {
    enable = true;
    treesitter.enable = true;
    dap.enable = true;
    format.enable = true;
    format.type = [ "golines" ];
    lsp.enable = true;
  };
}
