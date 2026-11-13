# Nixvim Configuration

This is my personal, modular Nixvim configuration. It aims to provide a fluid editing experience
with a rich set of features.

Built on a solid base configuration, it also includes several language modules (`langs`) and extra
modules (`xtra`) for enabling optional features. Feel free to use it if it fits your needs.
Contributions are also welcome.

> [!NOTE]
> This is an opinionated configuration and may not suit everyone's taste. It prioritizes a fluid
> editing experience and a rich feature set.

## Usage / Installation

### Add to flake

You can add `nv` as an input to your flake. By default, it follows the Nix master branch, but you
can override `inputs.nixpkgs.follows` to use your own nixpkgs input and follow whichever channel
you prefer.

```nix
{
  inputs = {
    # nixpkgs...
    # other inputs...
    nv = {
      url = "github:ar-at-localhost/nv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
```

### Apply the overlay

Some features require the `nv` overlay, which is also necessary when using the provided package
directly.

```nix
pkgs = import inputs.nixpkgs {
  inherit system;
  overlays = [
    inputs.nv.overlays.default
  ];
};
```

### Modules

Generally, you will want to import the modules into your configuration. Simply import the default
module:

```nix
{
  imports = [
    # rest of imports
    inputs.nv.nixvimModules.default
  ];
}
```

> [!IMPORTANT]
> Using the default module will load the default configuration. You'll need to override it to reset
> the configuration.

### Built Nixvim package

If you want to use the base configuration as-is, you can add the overlay provided by the flake and
include its package in your package set. With the appropriate wiring, it should work with both
Home Manager and NixOS.

A common use case is adding it to development flakes for a personalized editing experience.

```nix
# Apply overlay
{
  pkgs = import nixpkgs {
    overlays = [
      # other overlays...
      inputs.nv.overlays.default
    ];
  };
}

# Add package to your relevant package set
{
  packages = with pkgs; [ nv ];
}
```

## Languages

Several languages are supported. You can enable them by setting the
`nv.langs.<lang-name>.enable` option to `true`.

```nix
{
  # ...
  nv.langs.xml.enable = true;
}
```

> [!TIP]
> Nix, Lua, Markdown, and Bash are supported by default.

### Available Languages

- [Astro](./modules/langs/astro.nix)
- [C++](./modules/langs/cpp.nix)
- [CSS](./modules/langs/css.nix)
- [Docker](./modules/langs/docker.nix)
- [.NET](./modules/langs/dotnet.nix)
- [JavaScript / TypeScript](./modules/langs/javascript.nix)
- [Make](./modules/langs/make.nix)
- [MJML](./modules/langs/mjml.nix)
- [Python](./modules/langs/python.nix)
- [Rust](./modules/langs/rust.nix)
- [SQL](./modules/langs/sql.nix)
- [Web](./modules/langs/web.nix) (JavaScript/TypeScript, HTML, CSS, SQL, XML)
- [XML](./modules/langs/xml.nix)

## Extras

A few extra features are also supported. You can enable them by setting the
`nv.xtras.<lang-name>.enable` option to `true`.

```nix
{
  # ...
  nv.xtras.orgmode.enable = true;
}
```

### Available Extras

- [CI](./modules/xtras/ci.nix)
- [LDX - Lua Developer Experience](./modules/xtras/ldx.nix)
- [Orgmode/Orgnomics](./modules/xtras/orgmode.nix)
- [TW - Theme watcher](./modules/xtras/tw)
- [Yalms - Yet Another Set of Lua Modules](./modules/xtras/yalms.nix)
- [Yarn Berry](./modules/xtras/yarn-berry.nix)

## License

This program is free software: you can redistribute it and/or modify it under the terms of the
GNU General Public License as published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not,
see <https://www.gnu.org/licenses/>.## License
