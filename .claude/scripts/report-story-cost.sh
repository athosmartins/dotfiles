#!/bin/bash
# Report cost for completed user story via ntfy notification
# Usage: report-story-cost.sh STORY_ID "STORY_TITLE" TOTAL_COST DURATION CODE_CHANGES
# Example: report-story-cost.sh "009" "Fix Anuar Donato API" "$3.45" "1.5h" "+234/-56"

set -euo pipefail

STORY_ID="${1:-}"
STORY_TITLE="${2:-}"
TOTAL_COST="${3:-}"
DURATION="${4:-}"
CODE_CHANGES="${5:-}"

NTFY_URL="https://ntfy.sh/athos-claude-code-x7k9m2p4"

# Validate inputs
if [[ -z "$STORY_ID" ]] || [[ -z "$STORY_TITLE" ]]; then
    echo "Usage: report-story-cost.sh STORY_ID \"STORY_TITLE\" TOTAL_COST DURATION CODE_CHANGES"
    echo "Example: report-story-cost.sh \"009\" \"Fix Anuar Donato API\" \"\$3.45\" \"1.5h\" \"+234/-56\""
    exit 1
fi

# Build notification message
MESSAGE="Story: ${STORY_TITLE}"

if [[ -n "$TOTAL_COST" ]]; then
    MESSAGE="${MESSAGE}

Cost: ${TOTAL_COST}"
fi

if [[ -n "$DURATION" ]]; then
    MESSAGE="${MESSAGE}
Duration: ${DURATION}"
fi

if [[ -n "$CODE_CHANGES" ]]; then
    MESSAGE="${MESSAGE}
Code changes: ${CODE_CHANGES}"
fi

MESSAGE="${MESSAGE}

View full report with /cost in Claude Code"

# Send notification
curl -s -X POST "$NTFY_URL" \
  -H "Title: Story #${STORY_ID} Completed 📊" \
  -H "Priority: default" \
  -H "Tags: chart_with_upwards_trend,money_with_wings" \
  -d "$MESSAGE" > /dev/null 2>&1

if [[ $? -eq 0 ]]; then
    echo "✅ Cost report sent for Story #${STORY_ID}"
else
    echo "❌ Failed to send cost report"
    exit 1
fi
