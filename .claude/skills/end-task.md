# End Task Skill

This skill helps you cleanly end a task and clear context between unrelated work.

## Purpose

When switching from one task to an unrelated task (e.g., from scraper debugging to documentation), stale context wastes tokens on every subsequent message. This skill helps build the habit of cleaning up between tasks.

## When to Use

Use this skill when:
- You've completed a task and want to start something unrelated
- You're switching projects (scrapers → documentation)
- You're switching domains (coding → data analysis)
- Context is getting full and current task is done

## Workflow

When invoked, this skill:

1. **Ask user for task description**
   - "What should I name this session for later resume?"
   - Use their description for /rename

2. **Rename the session**
   - Execute: `/rename "[user's description]"`
   - This allows resuming later with `/resume "[description]"`

3. **Clear the context**
   - Execute: `/clear`
   - Removes all conversation history

4. **Confirm to user**
   - "Session renamed to '[description]' and cleared. You can resume later with `/resume '[description]'`"
   - "Ready for your next task!"

## Example Usage

```
User: /end-task
Claude: What should I name this session for later resume?
User: QuintoAndar rate limiting fix
Claude: [Executes /rename "QuintoAndar rate limiting fix"]
Claude: [Executes /clear]
Claude: Session renamed to 'QuintoAndar rate limiting fix' and cleared.
        You can resume later with `/resume 'QuintoAndar rate limiting fix'`

        Ready for your next task!
```

## Expected Savings

10-15% token savings by eliminating stale context on subsequent work.

## Notes

- The renamed session is saved and can be resumed later
- /clear removes conversation history but preserves settings
- This is a habit-building tool - requires discipline to use consistently
- Works best when paired with task completion notifications
