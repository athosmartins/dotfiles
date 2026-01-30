# User Stories Workflow - Claude Code Skill

> **Purpose:** Guide Claude on creating and managing user stories for work tracking
> **When to use:** When starting new work or tracking implementation progress
> **Created:** 2026-01-30

---

## User Stories File Location

**ALWAYS** use this file for tracking user stories, regardless of session working directory:
```
/Users/athos/Library/CloudStorage/GoogleDrive-athosmartins@gmail.com/My Drive/05 Github/.claude-user-stories.md
```

---

## Workflow for New User Requests

When user provides a prompt for new work:

### 1. Check Token Usage FIRST
- Run: `/cost` command to get actual token usage
- Note session cost, duration, and token counts
- Compare to daily budget ($6 avg, $12 max for 90% of users)
- Include in story's "Resource Check" section
- If session already >$10, warn user and suggest waiting

**Resource Check Template:**
```markdown
#### Resource Check
**Session cost so far:** $X.XX (XX% of daily average)
**Session duration:** X.Xh
**Tokens used:** XXXKin / XXKout
**Recommendation:** ✅/⚠️/❌ [Explanation]
**Estimated story cost:** $X-Y
```

### 2. Create User Story
- Read current user stories file to get next story ID
- Draft complete user story following template
- Include: problem statement, acceptance criteria, technical approach, tasks breakdown
- **NEW:** Include "Agent Execution Plan" - which agents will be spawned and why
- **NEW:** Include "Resource Check" - credit % and recommendation
- Add to "Pending Approval" section

### 3. Ask for User Approval
- Present the story to user
- Show credit usage and agent plan
- Use AskUserQuestion if clarification needed
- DO NOT start implementation until approved

### 4. After Approval
- Move story from "Pending Approval" to "Active Stories"
- Update status to "In Progress"
- Begin implementation

### 5. During Implementation
- Check off tasks as completed
- Update progress in the story

### 6. On Completion
- Verify ALL acceptance criteria are met
- Check ALL task boxes
- **CRITICAL: ASK USER TO TEST**
  - Present what was delivered
  - Ask user to test and confirm it works
  - **NEVER mark story as "Completed" yourself**
  - **ONLY the user can mark a story complete**
- After user confirms testing passed:
  - User will tell you to mark it complete
  - Then move story to "Completed Stories"
  - Update status to "Completed"
  - Add completion timestamp
  - Send completion notification via ntfy
  - **Send cost report** (run /cost, then):
    ```bash
    ~/.claude/scripts/report-story-cost.sh "STORY_ID" "STORY_TITLE" "$COST" "DURATION" "CODE_CHANGES"
    ```
  - **Commit changes to git** (if working in a git repo)
  - **Push to remote automatically** (ensure changes are backed up)

---

## Story Lifecycle

```
User Prompt → Create Story → Pending Approval → User Approves → In Progress → Ask User to Test → User Confirms → Completed
```

**CRITICAL:** The user MUST test and confirm before any story is marked complete.

---

## Important Rules

- **One source of truth**: The user stories file is the single source for all work tracking
- **Always check the file first**: Before creating a new story, read the file to see existing stories and get next ID
- **Keep it updated**: Update story status and checkboxes as work progresses
- **Persistent across sessions**: This file persists regardless of where Claude Code session starts
- **Use with multi-agent workflows**: When spawning agents, reference story ID in their prompts

---

**Usage:** Invoke this skill when starting new work that requires tracking or when managing existing user stories.
**Maintenance:** Update when workflow patterns or requirements change.
