# Forward args to bin/console. Colons (cache:clear, doctrine:migrations:migrate)
# pass through because zdev auto-prepends the matching recipe name, so just
# does not parse them as module separators.

[no-exit-message]
console *args:
    zdev exec app php bin/console {{args}}
