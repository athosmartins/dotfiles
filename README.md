# Dotfiles - Claude Code Configuration

Personal configuration files for Claude Code and shell environment.

## Contents

### Claude Code Configuration

- **`.claude/CLAUDE.md`** - Global instructions for Claude Code
  - ntfy notification system setup
  - Credit monitoring configuration
  - Multi-agent workflows
  - Model selection strategy
  - Task switching workflow
  - Prompt optimization guidelines
  - Extended thinking budget
  - Code intelligence (Pyright LSP)
  - Compact instructions

- **`.claude/skills/`** - Custom Claude Code skills
  - `end-task.md` - Clean task ending with /rename and /clear
  - `user-stories.md` - User story workflow and tracking

- **`.claude/scripts/`** - Automation scripts
  - `report-story-cost.sh` - Send ntfy notifications with story cost breakdown

### Shell Configuration

- **`.zshrc`** - Zsh shell configuration
  - Extended thinking budget aliases (claude-quick, claude-deep)
  - MCP tool search configuration
  - Environment variables

## Installation

These files are currently copied from `~/.claude/` for version control. They remain in their original locations and function normally.

### Option 1: Keep as backup/reference (current setup)
Files remain in `~/.claude/` and `~/` - this repo serves as version-controlled backup.

### Option 2: Use symlinks (advanced)
To use this repo as the source of truth:

```bash
# Backup existing files
mv ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.bak
mv ~/.zshrc ~/.zshrc.bak

# Create symlinks
ln -s "/path/to/dotfiles/.claude/CLAUDE.md" ~/.claude/CLAUDE.md
ln -s "/path/to/dotfiles/.zshrc" ~/.zshrc
ln -s "/path/to/dotfiles/.claude/skills/end-task.md" ~/.claude/skills/end-task.md
ln -s "/path/to/dotfiles/.claude/skills/user-stories.md" ~/.claude/skills/user-stories.md
ln -s "/path/to/dotfiles/.claude/scripts/report-story-cost.sh" ~/.claude/scripts/report-story-cost.sh
```

## Usage

After modifying configuration files in `~/.claude/`, copy them back to this repo:

```bash
cd /path/to/dotfiles
cp ~/.claude/CLAUDE.md .claude/
cp ~/.zshrc .
cp ~/.claude/skills/*.md .claude/skills/
cp ~/.claude/scripts/*.sh .claude/scripts/
git add .
git commit -m "Update configuration files"
git push
```

## Stories Completed (2026-01-30)

This repository tracks configuration from these user stories:

- **Story #018**: Task Switching Habit Reminder (10-15% savings)
- **Story #019**: /cost Integration into User Story Workflow
- **Story #020**: Post-Task Cost Reporting with ntfy
- **Story #021**: Prompt Optimization Best Practices (10-15% savings)
- **Story #022**: Extended Thinking Budget (5-10% savings)
- **Story #023**: Pyright LSP Verification (~13K tokens per navigation)

**Combined impact**: 30-50% token savings across optimizations

## Notes

- User stories file (`.claude-user-stories.md`) is tracked separately in Google Drive
- Other skills and scripts in `~/.claude/` may exist but aren't tracked here yet
- See `CLAUDE.md` for full documentation on each optimization

## Maintenance

When adding new configuration files:
1. Add to this repo
2. Update README with description
3. Commit and push changes
