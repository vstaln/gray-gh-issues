<p align="center">
  <img src="assets/gray-logo.svg" alt="gray" width="96">
  <img src="assets/github.svg" alt="github" width="96">
</p>
<h1 align="center">gray-gh-issues</h1>
<p align="center">Resolves #N references into GitHub issue titles when a prompt is submitted.</p>
<p align="center">
  <a href="https://github.com/vstaln/gray-gh-issues/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-7aa2f7.svg">
  <img alt="rust" src="https://img.shields.io/badge/built%20with-rust-orange.svg">
</p>

## What it does

Hooks `input/submit` (protocol 2.0). When the submitted text mentions `#<n>`
and the session cwd is a checkout with a GitHub remote, each issue is looked
up with `gh issue view <n>` (5s timeout, cached in-memory for the process)
and the input is rewritten with an appended context block:

```
Referencing issues: #12 'Fix crash (OPEN)' · #9 'Add login (MERGED)'
```

Fail-open everywhere: `gh` missing, non-GitHub repo, or every lookup
failing → the input passes through unchanged. Requires the `gh` CLI.

`/ghissues` reports status; `/ghissues on|off` toggles (state in
`~/.gray/gh-issues/`).

## Wire methods

- `plugin/manifest`, `plugin/shutdown`
- `input/submit` — `{text}` rewrite / `{}` pass
- `command/run` — `/ghissues`, `/ghissues on|off`
- no sidecar→host requests, no capabilities

## Install

```sh
gray plugin install gh-issues
```

## Develop

```sh
cargo test
gray account check      # entry point + manifest handshake
gray account publish    # check → build → release → publish to the gray registry
```

Bump `version` in `Cargo.toml` before each `publish`; the registry refuses to
republish a version.

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
