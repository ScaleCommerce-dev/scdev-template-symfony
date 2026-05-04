# zdev Symfony Template

A starter template for [zdev](https://github.com/0ploy/zdev) that scaffolds a Symfony project with a working local development environment.

## What's included

- PHP 8.4 (Alpine) container
- Symfony skeleton scaffolded via `composer create-project`
- Symfony CLI dev server
- HTTPS via zdev's shared Traefik router
- Mutagen file sync (macOS) with vendor/ kept inside the container

## Usage

```bash
zdev create symfony my-app
cd my-app
zdev setup
```

After setup completes, your app is running at `https://my-app.0ploy.dev`.

## What `zdev setup` does

1. Starts the Docker container (`zdev start`)
2. Installs Composer and Symfony CLI
3. Scaffolds a Symfony project via `symfony new`
4. Marks setup as complete - the PHP dev server starts automatically

All commands can be seen in [.zdev/commands/setup.just](.zdev/commands/setup.just).

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
