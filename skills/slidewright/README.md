# SlideWright Skill (Interactive Presentation Builder)

**Language / Ngôn ngữ / 语言:** [English](./README.md) | [Tiếng Việt](./README.vi.md) | [中文](./README.zh.md)

This skill helps you build clean, modern, interactive presentation slides designed to be projected onto a screen for a live audience.

## What is SlideWright?

SlideWright is a presentation builder that creates slide decks as fast, lightweight websites. Instead of struggle with clunky PowerPoint or Keynote interfaces, you can write your slides in Markdown or React. SlideWright sets up a professional design system out of the box, ensuring your presentation looks premium and remains easy to read from the back of the room.

## Why Use It?

- **Zero-Clutter Design System**: Forces key rules for live talks, such as a "typography floor" (main text is at least 40px so it's readable from afar) and strict layout recipes.
- **Two Flexible Tracks**:
  - **Plain HTML (Zero Build)**: Single `index.html` file that runs instantly in any browser. Best for quick decks.
  - **Vite + React**: Scaffolds a full modern React project with Tailwind CSS and Framer Motion for beautiful transitions and custom animations.
- **Presenter-Focused**: Slides only contain visual cues and minimal text. Speaker notes are automatically placed in a separate Markdown file (`*-notes.md`) so you can reference them easily.
- **Easy PDF Export**: Includes scripts to capture the fully-rendered pages into a print-ready PDF document.

## Essential Slide Design Rules

Unlike normal websites, presentations have a different purpose:
- **Big Text Only**: Never use default web-reading sizes.
- **No Complex App Elements**: No form submissions, inputs, or logins. The only interaction is you clicking to reveal the next bullet point or transition.
- **One Idea Per Slide**: Keeps the audience focused on what you are saying, not reading a wall of text.

## How to Trigger

Ask your AI agent tasks like:

```text
Help me create a slide deck for my upcoming tech talk.
```

```text
Scaffold a new presentation about AI agents using the HTML track.
```

```text
Draft the slides and speaker notes for a 10-minute project pitch.
```
