# Agent Skills

A collection of skills for AI coding agents. Compatible with [Claude Code](https://code.claude.com), [Cursor](https://cursor.com), [GitHub Copilot](https://github.com/features/copilot), and [20+ other AI tools](https://agentskills.io) that support the open [Agent Skills standard](https://agentskills.io).

## Available Skills

### cv-scorer

Score candidate CVs on a 100-point scale against a Job Description.

**What it does:**
- Scores CVs across 5 weighted criteria: JD Matching, Work Experience, Project & Impact, Education, CV Quality
- Detects red flags: repetitive content, inflated metrics, contradictory information
- Outputs structured JSON with per-criterion scores, highlights, red flags, and a recommendation (Recommend / Maybe / Pass)
- Supports batch processing: scores multiple CVs independently then ranks them

**Trigger phrases:** "review CV", "screen resume", "score candidate", "rate candidates", "shortlist applicants", "match resume to JD"

### system-prompt-creator

Create high-quality, model-aware system prompts for any LLM (Claude, GPT, Gemini, open-source).

**What it does:**
- Walks you through a structured 5-step workflow: Interview, Analyze, Structure, Draft, Review
- Applies 12 universal principles derived from the official prompting guides of Anthropic, OpenAI, and Google
- Produces model-specific optimizations (Claude XML tags, GPT-5 verbosity params, Gemini temperature settings)
- Includes domain patterns: operational playbooks, raw data preservation, confidence scoring
- Provides 7 ready-to-adapt templates for common use cases

**Trigger phrases:** "create a system prompt", "write system instructions", "prompt engineering", "build a chatbot prompt", "design an agent prompt"

## Installation

```bash
# Using the skills CLI (recommended)
npx skills add tronghieu/agent-skills

# Or manually for Claude Code
cp -r skills/cv-scorer ~/.claude/skills/
cp -r skills/system-prompt-creator ~/.claude/skills/
```

## Skill Structure

```
skills/
  cv-scorer/
    SKILL.md                    # Core skill (workflow + scoring rubric)
    references/
      scoring-rubric.md         # Detailed 5-criterion rubric with scoring guides
      output-format.md          # JSON output templates (single CV + batch)
  system-prompt-creator/
    SKILL.md                    # Core skill (workflow + 12 principles)
    references/
      principles.md             # Detailed principles with examples
      model-specific.md         # Claude / GPT-5 / Gemini tips
      templates.md              # 7 templates (chatbot, agent, extractor, etc.)
```

## Contributing

We welcome contributions from the community! This project follows the open [Agent Skills standard](https://agentskills.io) and is compatible with 30+ AI coding tools.

### How to contribute

1. **Fork** this repository
2. **Create a skill** following the structure below
3. **Test** your skill with at least 2-3 realistic prompts
4. **Submit a PR** with a clear description of what the skill does and when it triggers

### Creating a new skill

```bash
# Scaffold a new skill
mkdir -p skills/your-skill-name/references

# Create the required SKILL.md
cat > skills/your-skill-name/SKILL.md << 'EOF'
---
name: your-skill-name
description: What it does + when to trigger + relevant keywords
---

# Your Skill Name

Instructions for the agent when this skill is activated.
EOF
```

See [AGENTS.md](./AGENTS.md) for the full skill creation guide, including directory structure, naming conventions, SKILL.md format, and packaging instructions.

### Skill quality checklist

Before submitting a PR, make sure your skill:

- [ ] Has a `SKILL.md` with `name` and `description` in frontmatter
- [ ] Description is specific about **when** to trigger (not just what it does)
- [ ] Instructions are clear, actionable, and explain the *why* behind rules
- [ ] Includes examples where format/accuracy matters
- [ ] Keeps `SKILL.md` under 500 lines (use `references/` for detailed docs)
- [ ] Does not contain secrets, credentials, or sensitive data
- [ ] Has been tested with realistic prompts

### Contribution ideas

- New skill templates for specific domains (DevOps, data science, mobile, etc.)
- Translations of existing skills for non-English workflows
- Improvements to existing skills based on real-world usage
- Bug fixes and documentation updates

## Open Standard

This project is built on the [Agent Skills open standard](https://agentskills.io), originally developed by Anthropic and now adopted by 30+ AI platforms including Claude Code, Cursor, GitHub Copilot, Codex, Gemini CLI, and more.

Skills you create here work everywhere the standard is supported. No vendor lock-in.

| Platform | Support |
|----------|---------|
| Claude Code | Native |
| Cursor | Native |
| GitHub Copilot | Native |
| Codex (OpenAI) | Native |
| Gemini CLI | Native |
| Windsurf, Cline, Roo Code, ... | Native |

Full list at [agentskills.io](https://agentskills.io).

## References

| Resource | URL |
|----------|-----|
| Agent Skills Standard | https://agentskills.io |
| Claude Code Skills Docs | https://code.claude.com/docs/en/skills |
| Anthropic Skills (official) | https://github.com/anthropics/skills |
| Skills CLI (Vercel) | https://github.com/vercel-labs/skills |
| Skills Marketplace | https://skills.sh |

## License

MIT — use, modify, and distribute freely.
