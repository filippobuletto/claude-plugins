<div align="center">

# claude-plugins

A Claude Code plugin marketplace with every plugin by Filippo Buletto. Add it once, then install any plugin from it.

[![License](https://img.shields.io/github/license/filippobuletto/claude-plugins)](LICENSE)
[![Last commit](https://img.shields.io/github/last-commit/filippobuletto/claude-plugins)](https://github.com/filippobuletto/claude-plugins/commits/main)
[![Plugins](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Ffilippobuletto%2Fclaude-plugins%2Fmain%2F.claude-plugin%2Fmarketplace.json&query=%24.plugins.length&label=plugins)](.claude-plugin/marketplace.json)
[![Claude Code](https://img.shields.io/badge/Claude_Code-marketplace-D97757?logo=claude&logoColor=white)](https://code.claude.com/docs/en/plugins)

</div>

```text
/plugin marketplace add filippobuletto/claude-plugins
```

## Plugins

| Plugin | What it does | Install |
| :- | :- | :- |
| [kubectl-guard](https://github.com/filippobuletto/kubectl-Guard-for-Claude-Code) | Allowlist `PreToolUse` hook that lets Claude inspect Kubernetes clusters with `kubectl` and `helm` without changing them, reading secrets or switching identity | `/plugin install kubectl-guard@filippobuletto` |
| [toon-mcp-squeeze](https://github.com/filippobuletto/toon-mcp-squeeze) | Re-encodes JSON returned by MCP tools as [TOON](https://toonformat.dev/) before Claude reads it, cutting tokens on large tabular results | `/plugin install toon-mcp-squeeze@filippobuletto` |

Each plugin lives in its own repository, with its own README, options and releases. This repository holds only the catalog in [`.claude-plugin/marketplace.json`](.claude-plugin/marketplace.json).

## Updates

Entries track each plugin's default branch. Claude Code picks up a new release when the `version` in the plugin's `plugin.json` changes. Run `/plugin marketplace update filippobuletto` to refresh the catalog by hand.

## Adding a plugin

1. Give the plugin repository a `.claude-plugin/plugin.json`.
2. Add an entry to `.claude-plugin/marketplace.json` with a `github` source. Use the manifest's `name`, and copy `description`, `homepage`, `license` and `keywords`. Claude Code shows only the entry's fields before install.
3. Check it:

   ```bash
   claude plugin validate .
   bash tests/run.sh
   ```

   `tests/run.sh` fetches each plugin's `plugin.json` from GitHub and checks that the name, description, homepage and license match the entry.
