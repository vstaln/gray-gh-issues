<div align="center">
  <img alt="gray-gh-issues" src="assets/github.svg" width="120" height="120" />
  <h1>gray-gh-issues</h1>
  <p><strong>Append referenced GitHub issue titles to prompts that mention them.</strong></p>
  <p>
    <a href="https://gray.alignment.id">Website</a> ·
    <a href="https://gray.alignment.id/plugins/gray-gh-issues">Store</a> ·
    <a href="https://github.com/vstaln/gray-gh-issues">Source</a> ·
    <a href="https://github.com/vstaln/gray">gray</a>
  </p>
  <p>
    <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-1c1c20?style=flat-square&labelColor=0a0a0b" /></a>
    <a href="https://www.rust-lang.org"><img alt="Built with Rust" src="https://img.shields.io/badge/built%20with-rust-1c1c20?style=flat-square&labelColor=0a0a0b&logo=rust&logoColor=d4a373" /></a>
    <a href="https://gray.alignment.id/plugins/gray-gh-issues"><img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-1c1c20?style=flat-square&labelColor=0a0a0b&color=7aa2f7" /></a>
  </p>
</div>

<br/>

```bash
gray plugin install gray-gh-issues
```

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

## Tags

`gray` `plugin` `gh-issues` `rust`

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
