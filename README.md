# zdev Symfony Template

A starter template for [zdev](https://github.com/0ploy/zdev) that scaffolds a Symfony project with a working local development environment.

## What's included

- PHP 8.4 (Alpine) container, [zpinit](https://github.com/0ploy/zpinit) as PID 1
- Composer, the Symfony CLI, and common PHP extensions **baked into the image** (`.zdev/Dockerfile`)
- Symfony skeleton scaffolded once at create time via `symfony new`
- Symfony CLI dev server, supervised (a crash keeps the container up and recoverable)
- HTTPS via zdev's shared Traefik router
- Mutagen file sync (macOS) with `vendor/` kept inside the container

## Usage

```bash
zdev create symfony my-app
cd my-app
zdev start
```

`zdev create` scaffolds the project (see below); `zdev start` builds the image, installs
dependencies, and runs the dev server at `https://my-app.0ploy.dev`.

> A bare Symfony skeleton has no homepage route, so `/` returns 404 until you add a controller.
> `zdev exec app composer require webapp` for the full web application bundle.

## How it works

**At create time**, `zdev create` runs [.zdev/scaffold.sh](.zdev/scaffold.sh) once, in a throwaway
container, to generate the project (`symfony new`). It copies the source to your project (not
`vendor/`, which installs at boot). After it succeeds, zdev renames the hook to
`.zdev/scaffold.sh.disabled`.

**On every boot**, zpinit runs [.zdev/zpinit/entrypoint.d/10-install.sh](.zdev/zpinit/entrypoint.d/10-install.sh)
(`composer install`) and then **supervises** the Symfony dev server
([.zdev/zpinit/services/10_app.toml](.zdev/zpinit/services/10_app.toml)). Because install happens at
boot, a teammate can **clone the project and just run `zdev start`**. Because the server is
supervised, a crash keeps the container up — `zdev exec` still works, and `zpctl restart app`
brings it back after a fix.

## Development

Edit files in `src/` and refresh the browser - PHP reloads on every request in dev mode.

To add Symfony packages:

```bash
zdev exec app composer require <package>
```

For example, to add the full web application bundle:

```bash
zdev exec app composer require webapp
```

## Requirements

- [zdev](https://github.com/0ploy/zdev) installed
- Docker Desktop running

## Learn more

Want to create your own template? See the [Template Authoring Guide](https://github.com/0ploy/zdev/blob/main/templates/README.md).
