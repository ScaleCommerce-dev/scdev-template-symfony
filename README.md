# scdev Symfony Template

A starter template for [scdev](https://github.com/ScaleCommerce-DEV/scdev) that scaffolds a Symfony project with a working local development environment.

## What's included

- PHP 8.4 (Alpine) container
- Symfony skeleton scaffolded via `composer create-project`
- Symfony CLI dev server
- HTTPS via scdev's shared Traefik router
- Mutagen file sync (macOS) with vendor/ kept inside the container

## Usage

```bash
scdev create symfony my-app
cd my-app
scdev setup
```

After setup completes, your app is running at `https://my-app.scalecommerce.site`.

## What `scdev setup` does

1. Starts the Docker container (`scdev start`)
2. Installs Composer and Symfony CLI
3. Scaffolds a Symfony project via `symfony new`
4. Marks setup as complete - the PHP dev server starts automatically

All commands can be seen in [.scdev/commands/setup.just](.scdev/commands/setup.just).

## Development

Edit files in `src/` and refresh the browser - PHP reloads on every request in dev mode.

To add Symfony packages:

```bash
scdev exec app composer require <package>
```

For example, to add the full web application bundle:

```bash
scdev exec app composer require webapp
```

## Requirements

- [scdev](https://github.com/ScaleCommerce-DEV/scdev) installed
- Docker Desktop running

## Learn more

Want to create your own template? See the [Template Authoring Guide](https://github.com/ScaleCommerce-DEV/scdev/blob/main/templates/README.md).
