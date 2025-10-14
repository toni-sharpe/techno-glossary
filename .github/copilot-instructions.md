# Copilot Instructions for Techno Glossary

## Project Overview

This is a simple HTML-based glossary project focused on electronic dance music terminology for beginner-level music producers. The project values simplicity, web performance, and accessibility.

## Technology Stack

- **HTML**: Single `index.html` file containing all content
- **CSS**: Inline styles in the `<head>` section for simplicity
- **No Build Process**: Direct HTML with no compilation or bundling required
- **No Testing Framework**: Manual verification only

## Key Principles

1. **Simplicity First**: Keep everything in a single HTML file. No frameworks, no build tools.
2. **Accessibility**: Ensure semantic HTML and proper heading hierarchy.
3. **Web Performance**: Keep file size minimal, no external dependencies.
4. **Responsive Design**: Mobile-first approach using CSS media queries.

## Code Style

- Use semantic HTML5 elements (`<article>`, `<section>`, etc.)
- Maintain consistent anchor ID naming (lowercase, no spaces)
- Keep inline styles organized in logical groups
- Use monospace font family for consistency with the project aesthetic

## Content Guidelines

- Glossary entries should be clear and beginner-friendly
- Cross-reference related terms using anchor links (e.g., `<a href='#termname'>term</a>`)
- Each term should be in its own `<article>` within a `<li>` element
- Use "CONTENT REQUIRED" placeholder for incomplete entries

## Making Changes

- **HTML Structure**: Maintain the existing list structure with articles inside list items
- **Styling**: All CSS should remain inline in the `<head>` section
- **Anchors**: Use lowercase IDs without spaces for term anchors
- **Testing**: Manually open `index.html` in a browser to verify changes
- **No Dependencies**: Do not introduce npm, package managers, or external libraries

## Common Tasks

### Adding a New Glossary Entry
1. Add a new `<li>` element within the `<ol>` in alphabetical order
2. Include an `<article>` with an `<h1>` containing an anchor ID
3. Add descriptive paragraph(s) with appropriate cross-references
4. Use lowercase, concatenated names for IDs (e.g., "signal path" → "signalpath")

### Updating Styles
1. Modify the inline `<style>` block in the `<head>` section
2. Test on both desktop (>600px) and mobile (<600px) viewports
3. Ensure changes maintain accessibility and readability

### Cross-Referencing Terms
- Use relative anchor links: `<a href='#termid'>Term Name</a>`
- Ensure the target term exists before adding the link
- Use the proper term ID that matches the anchor

## Validation

Before completing work:
1. Open `index.html` in a modern browser
2. Verify all internal links work correctly
3. Check responsive behavior by resizing the browser window
4. Ensure text is readable and hierarchy is clear
5. Validate HTML if possible (though strict validation is not required)
