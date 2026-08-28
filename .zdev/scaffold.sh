#!/bin/sh
# Create-time scaffold hook. `zdev create` runs this ONCE, in a throwaway
# container (entrypoint overridden to a shell, so zpinit/entrypoint.d do NOT run
# here). It generates the project source only; dependencies install at first
# boot (see zpinit/entrypoint.d/10-install.sh).
#
# `symfony new` needs an empty directory, but /app already holds .zdev/, so we
# scaffold into /tmp and copy the result to /app. We copy source only, NOT
# vendor/ or var/: those are container-only (in mutagen.ignore) and are
# installed/regenerated at boot. Copying vendor here would put it on the host.
# composer.lock IS copied, so the boot install is reproducible.
#
# After a successful `zdev create`, zdev renames this to scaffold.sh.disabled
# (kept for reference, never runs again). Delete it whenever you like.
set -eu

symfony new /tmp/app --no-git --no-interaction
cd /tmp/app
find . -mindepth 1 -maxdepth 1 ! -name vendor ! -name var -exec cp -a {} /app/ \;
rm -rf /tmp/app
