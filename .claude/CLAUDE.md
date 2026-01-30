# Global Claude Code Instructions

## ntfy Notification System

**CRITICAL**: This user relies on ntfy.sh notifications. Follow these rules strictly.

### ntfy Configuration

- **Topic URL**: `https://ntfy.sh/athos-claude-code-x7k9m2p4`
- **This is a private topic** - do not share or change

---

## CLAUDE CREDITS MONITORING (HIGHEST PRIORITY)

### How Claude Max Credits Work

- **Session limits**: 5-hour rolling window from first message
- **Weekly limits**: 7-day rolling window (older usage ages out)
- When exhausted, Claude Code shows: `You're out of extra usage · resets Xpm`
- The reset time shown is the exact time credits will be available again

### Automatic Monitoring System

**IMPORTANT:** Credit monitoring is handled by **system-level automation**, not by Claude:

- **Claude Wrapper** (`~/.claude/scripts/claude-wrapper.sh`) monitors all output
- **Background Daemon** (`~/.claude/scripts/credit-monitor-daemon.sh`) provides backup
- **Both automatically detect** rate limit messages and send notifications
- **No manual intervention needed** - works even when Claude can't execute tools

**Setup Instructions:** See `~/.claude/CREDIT-MONITORING-SETUP.md`

### If Monitoring Not Yet Active

If you see "out of extra usage" and haven't received a notification:

```bash
# Monitoring is not set up - send manual notification
~/.claude/scripts/notify-credits-reset.sh "[RESET_TIME]"
```

### For Claude: What You Can't Do

**You CANNOT reliably notify about credits because:**
1. Rate limit happens AFTER your last tool execution
2. You can't execute bash commands when rate limited
3. Manual notification has failed twice already

**The system-level wrapper/daemon handles this automatically now.**

---

## STATUS LINE - REAL-TIME TOKEN MONITORING

Configured in `~/.claude/settings.json` to show real-time context usage at bottom of terminal.

**Display format:** `[Model] ctx: X.X% (XXK/XXXK)`
**Color coding:** Green (<60%), Yellow (60-80%), Red (>80%)

**Script:** `~/.claude/statusline.sh` - customize thresholds and format as needed.

**Note:** Session/weekly usage limits must be checked manually at https://claude.ai/settings/limits (automated scraping blocked by Cloudflare)

---

## Script/Automation Notifications

All scripts, automation, and long-running code (>30 seconds) MUST include ntfy.sh notifications for completion, failure, crashes, and interruptions.

**For full implementation details, templates, and examples:** See `~/.claude/skills/ntfy-notifications.md` or invoke with the Skill tool when creating scripts.

---

## MULTI-AGENT AUTONOMOUS WORKFLOWS

For complex tasks requiring specialized agents (scrapers, code review, testing, etc.), use multi-agent workflows.

**For full details on spawning agents, coordination patterns, and workflows:** See `~/.claude/skills/multi-agent-workflows.md` or invoke with the Skill tool.

---

## MODEL SELECTION STRATEGY

Choose the right model for cost optimization:
- **Haiku**: 20x cheaper - simple tasks (file reads, tests, exploration)
- **Sonnet**: Default - implementation, debugging, code review
- **Opus**: Rare - complex architecture decisions

**For full guidelines and examples:** See `~/.claude/skills/model-selection.md` or invoke with the Skill tool.

**Quick rule:** Use Haiku for straightforward tasks, Sonnet when unsure, Opus rarely.

---

## MCP TOOL SEARCH (ON-DEMAND LOADING)

Enabled via `ENABLE_TOOL_SEARCH=auto:5` to defer MCP tool definitions until needed.

**Saves 10-15% tokens** by loading tools only when used. First call has slight delay.

### Active MCP Servers (Optimized)

**OAuth-connected (claude.ai):**
- **Notion** - Documentation work (keep connected)
- **ClickUp, Hex, Honeycomb** - Deferred (minimal context usage via tool search)

**User-installed (CLI):**
- **Puppeteer** - Web automation for scrapers (actively used)

**Removed (failed connections):**
- playwright, gsheets, filesystem, git, memory - Cleaned up 2026-01-30

**Key insight:** With tool search enabled, OAuth servers consume minimal context even when connected (tools only load on explicit ToolSearch calls). Disconnecting via https://claude.ai/settings/integrations provides marginal additional savings.

---

## CLI TOOLS VS MCP SERVERS

**Prefer CLI tools over MCP servers** for context efficiency (6-20x less tokens).

**Use CLI for:** GitHub (gh), HTTP (curl+jq), files (cat/ls), git commands
**Use MCP for:** Complex auth, multi-step workflows, no CLI equivalent

**For full decision matrix and examples:** See `~/.claude/skills/cli-vs-mcp.md` or invoke with the Skill tool.

---

## USER STORIES WORKFLOW

When starting new work, create and track user stories in:
```
/Users/athos/Library/CloudStorage/GoogleDrive-athosmartins@gmail.com/My Drive/05 Github/.claude-user-stories.md
```

**For full workflow details (creation, approval, testing, completion):** See `~/.claude/skills/user-stories.md` or invoke with the Skill tool.

**Key rule:** Check credit usage FIRST, and ONLY the user can mark stories as completed after testing

---

## TASK SWITCHING WORKFLOW

When switching to unrelated work, clear context to avoid wasting tokens on stale information.

### Workflow

1. **Rename current session** (for later resume):
   ```
   /rename "Fix QuintoAndar scraper rate limiting"
   ```

2. **Clear context:**
   ```
   /clear
   ```

3. **Start fresh** with new task

4. **Resume later** if needed:
   ```
   /resume "Fix QuintoAndar"
   ```

### When to Clear

- Switching projects (scrapers → documentation)
- Switching domains (coding → data analysis)
- Task completed, starting new unrelated work

### When NOT to Clear

- Related follow-up work
- Debugging same issue
- Iterating on same feature

**Expected savings:** 10-15% by eliminating stale context

---

## PROMPT OPTIMIZATION GUIDELINES

Writing token-efficient prompts reduces exploratory work and saves 10-15% on token usage.

### Vague Prompts (Trigger Expensive Exploration)

❌ "Improve this codebase"
❌ "Fix the bug"
❌ "Make it faster"
❌ "Review the scraper"

### Specific Prompts (Enable Direct Action)

✅ "Add input validation to login() in scrapers/base.py:45"
✅ "Fix TypeError in process_listings() - expects dict not list"
✅ "Cache property_ids in Redis to avoid duplicate API calls in scrapers/loft/scraper.py:123"
✅ "Review rate limiting logic in scrapers/quintoandar/scraper.py:67-89"

### Guidelines for Effective Prompts

**Include when possible:**
- File paths: `scrapers/loft/scraper.py`
- Function names: `process_listings()`
- Line numbers: `:45` or `:67-89`
- Error messages: `TypeError: expected dict, got list`
- Expected behavior: "should return 200, returns 404"

### User Story Acceptance Criteria

**Good acceptance criteria (specific):**
- ✅ Update MAX_WORKERS in scrapers/quintoandar/scraper.py from 15 to 6
- ✅ Add exponential backoff in fetch_property() with delays: 1s, 2s, 4s, 8s
- ✅ Success rate improves from 21% to >80% on test run

**Bad acceptance criteria (vague):**
- ❌ Fix the scraper
- ❌ Make it work better
- ❌ Improve performance

**Expected savings:** 10-15% through reduced exploration

---

## EXTENDED THINKING BUDGET

Thinking tokens are billed as expensive output tokens. Tune thinking budget based on task complexity.

### Shell Aliases

```bash
claude-quick   # 5K thinking - simple tasks
claude         # 31K thinking - default (normal implementation)
claude-deep    # 50K thinking - complex architecture
```

### When to Use Each

**Use `claude-quick`** (5K thinking) for:
- Reading files
- Running tests
- Grep/find operations
- Simple edits (typos, config changes)

**Use `claude`** (31K default) for:
- Writing features
- Debugging
- Code review
- Refactoring

**Use `claude-deep`** (50K thinking) for:
- Complex architecture decisions
- Multi-file refactors
- When unsure (can always restart with more)

### Expected Savings

- Quick task: 31K → 5K = 26K tokens saved (~80% reduction per task)
- Over 20 quick tasks/day = 520K tokens saved
- Overall: 5-10% savings (assuming 40% of tasks are simple)

**Note:** Requires discipline to choose correct alias. If task becomes complex, restart with standard `claude`.

---

## CODE INTELLIGENCE (PYRIGHT LSP)

Pyright LSP is **installed and enabled** for Python projects (verified in settings.json).

### Benefits

- **Go to definition** without grep (one LSP call vs 5-10 file reads)
- **Type checking** after edits (catches errors early)
- **Auto-completion** suggestions
- **Symbol navigation** across files

### Token Savings

**Without LSP:**
- Grep for `def function_name` (search all files)
- Read 5+ candidate files
- Find correct definition
- Total: ~15K tokens

**With LSP:**
- Query LSP for definition
- Get exact file + line number
- Read only that section
- Total: ~2K tokens

**Savings:** ~13K tokens per code navigation operation

### Usage

Claude Code automatically uses Pyright LSP when navigating Python code. No manual action needed.

### Verification

Check enabled plugins in settings:
```bash
cat ~/.claude/settings.json | grep -A2 enabledPlugins
```

Should show: `"pyright-lsp@claude-plugins-official": true`

---

## COMPACT INSTRUCTIONS

When compacting conversation, preserve:
- User story IDs/status, active scraper configs, ntfy setup, current task context
- Error messages, acceptance criteria, task list items, active file paths

Deprioritize/summarize:
- Completed task history, exploratory reads, old test output, intermediate debugging steps
