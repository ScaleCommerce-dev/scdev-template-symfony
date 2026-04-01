# Scaffold Symfony project and install dependencies
#
# Uses /tmp for scaffolding because composer create-project requires an empty
# directory. Unlike Node.js, PHP's vendor/ directory uses relative paths
# (via __DIR__) so copying it between directories works fine.

[no-exit-message]
default:
    scdev start
    scdev exec app sh -c "apk add --no-cache bash && wget -qO- https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && wget https://get.symfony.com/cli/installer -O - 2>/dev/null | bash && export PATH=\"\$HOME/.symfony5/bin:\$PATH\" && symfony new /tmp/app --no-git && cp -r /tmp/app/. /app/ && rm -rf /tmp/app && echo '.setup-complete' >> .gitignore && touch .setup-complete"
    @echo ""
    @echo "Setup complete! App will start automatically."
    @echo ""
    @echo "Here are the details about your new project:"
    @echo ""
    scdev info
