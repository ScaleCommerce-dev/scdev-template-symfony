# Scaffold Symfony project and install dependencies
#
# Uses /tmp for scaffolding because symfony new requires an empty directory.
# Unlike Node.js, PHP's vendor/ uses relative paths so copying works fine.

[no-exit-message]
default:
    zdev start -q
    @zdev step "Installing Composer and Symfony CLI"
    zdev exec app sh -c "apk add --no-cache bash && wget -qO- https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && wget https://get.symfony.com/cli/installer -O - 2>/dev/null | bash && cp \$HOME/.symfony5/bin/symfony /usr/local/bin/symfony"
    @zdev step "Scaffolding Symfony project"
    zdev exec app symfony new /tmp/app --no-git
    @zdev step "Copying project files"
    zdev exec app sh -c "cp -r /tmp/app/. /app/ && rm -rf /tmp/app && echo '.setup-complete' >> .gitignore && touch .setup-complete"
    @zdev step "Setup complete! App will start automatically."
    zdev info
