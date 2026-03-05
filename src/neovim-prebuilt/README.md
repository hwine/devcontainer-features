
# NeoVim (No install, from binary)

Install NeoVim instantly from pre-built binaries

Supports amd64 & arm64 architectures. (Based on [this
work](https://github.com/marcosbolanos/devcontainer-features/neovim-prebuilt).)

```json
"features": {
    "ghcr.io/hwine/devcontainer-features/neovim-prebuilt:1": {
        "version": "stable"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| Version | Choose `stable`, `nightly` or a version like `v0.11.5` | string | `stable` |
