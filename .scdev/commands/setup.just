# Scaffold Symfony project and install dependencies
#
# Uses /tmp for scaffolding because symfony new requires an empty directory.
# Unlike Node.js, PHP's vendor/ uses relative paths so copying works fine.

[no-exit-message]
default:
    scdev start -q
    @echo ""
    @echo "Installing Composer and Symfony CLI..."
    scdev exec app sh -c "apk add --no-cache bash && wget -qO- https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && wget https://get.symfony.com/cli/installer -O - 2>/dev/null | bash && cp \$HOME/.symfony5/bin/symfony /usr/local/bin/symfony"
    @echo ""
    @echo "Scaffolding Symfony project..."
    scdev exec app symfony new /tmp/app --no-git
    @echo ""
    @echo "Copying project files..."
    scdev exec app sh -c "cp -r /tmp/app/. /app/ && rm -rf /tmp/app && echo '.setup-complete' >> .gitignore && touch .setup-complete"
    @echo ""
    @echo "Setup complete! App will start automatically."
    @echo ""
    @echo "Here are the details about your new project:"
    @echo ""
    scdev info
