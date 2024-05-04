{
  config,
  pkgs,
  ...
}: {
  programs.helix.enable = true;

  programs.helix.settings = {
    theme = "onedark";

    editor = {
      cursorline = true;
      completion-trigger-len = 1;
      auto-pairs = true;
      true-color = true;
      scrolloff = 3;
      idle-timeout = 50;
      bufferline = "always";
      color-modes = true;

      soft-wrap.enable = true;

      statusline.left = ["mode" "spinner" "version-control" "file-name"];

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      file-picker.hidden = false;

      whitespace = {
        render.newline = "none";
        characters.space = "·";
        characters.tab = "→";
        characters.newline = "⏎";
      };

      indent-guides = {
        render = true;
        character = "⎸";
        skip-levels = 1;
      };

      lsp = {
        display-messages = true;
        display-inlay-hints = true;
        auto-signature-help = false;
        display-signature-help-docs = true;
      };
    };

    keys.normal = {
      esc = ["collapse_selection" "keep_primary_selection"];
      X = ["extend_line_up" "extend_to_line_bounds"];
      space.i = "signature_help";
    };

    keys.select = {
      X = ["extend_line_up" "extend_to_line_bounds"];
    };
  };

  programs.helix.languages = {
    language = [
      {
        name = "python";
        auto-format = true;
        language-servers = ["pyright" "ruff"];
        formatter = {
          command = "black";
          args = ["--line-length" "88" "--quiet" "-"];
        };
      }

      {
        name = "nix";
        formatter.command = "alejandra";
      }
    ];

    language-server = {
      rust-analyzer.config.check.command = "clippy";

      pyright.config.python.analysis.typeCheckingMode = "basic";

      ruff.command = "ruff-lsp";
      ruff.config.settings.args = ["--ignore" "E501"];
    };
  };
}
