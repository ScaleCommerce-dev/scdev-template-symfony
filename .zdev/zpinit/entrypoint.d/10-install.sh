#!/bin/sh
# zpinit entrypoint.d step — runs on every boot, before the dev server.
#
# Installs dependencies at boot (not at scaffold time) so a fresh clone with no
# vendor/, a pulled composer.lock change, or a new machine all Just Work via
# `zdev start`, with no re-scaffold.
#
# The wait: with the Dockerfile/ENTRYPOINT approach we bypass zdev's automatic
# `command:` sync gate, so we wait for zdev's Mutagen initial-sync marker here —
# otherwise composer could race the sync and not see composer.json yet. zdev
# touches /.zdev-sync-ready after the first flush.
set -eu
cd /app

while [ ! -f /.zdev-sync-ready ]; do sleep 0.2; done

composer install --no-interaction
