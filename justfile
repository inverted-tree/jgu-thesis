name    := `grep '^name'    typst.toml | cut -d'"' -f2`
version := `grep '^version' typst.toml | cut -d'"' -f2`

[macos]
install:
    mkdir -p "$HOME/Library/Application Support/typst/packages/local/{{name}}/{{version}}"
    cp -r lib.typ typst.toml templates img LICENSE README.md \
        "$HOME/Library/Application Support/typst/packages/local/{{name}}/{{version}}/"

[linux]
install:
    mkdir -p "$HOME/.local/share/typst/packages/local/{{name}}/{{version}}"
    cp -r lib.typ typst.toml templates img LICENSE README.md \
        "$HOME/.local/share/typst/packages/local/{{name}}/{{version}}/"

[windows]
install:
    md "%APPDATA%\typst\packages\local\{{name}}\{{version}}"
    robocopy . "%APPDATA%\typst\packages\local\{{name}}\{{version}}" lib.typ typst.toml LICENSE README.md
    robocopy templates "%APPDATA%\typst\packages\local\{{name}}\{{version}}\templates" /E
    robocopy img "%APPDATA%\typst\packages\local\{{name}}\{{version}}\img" /E
