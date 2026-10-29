# Project work-item handoff

Implementation specs and project tickets serve different readers. Keep the
ticket concise and outcome-oriented; keep executable contracts, test catalogs,
and detailed edge cases in the implementation spec.

## Select the tracker and destination

- Use the tracker, workspace, team, project, board, or repository the user
  names. Do not hardcode Linear, Jira, GitHub Issues, Trello, or a particular
  project into a reusable spec workflow.
- When the destination is not explicit, inspect repository instructions, PR
  templates, nearby work items, and completed sibling phases. Ask only when the
  choice remains material and ambiguous.
- Reuse the project's issue template, title pattern, labels, milestone, status,
  and assignee conventions when they exist. Do not invent missing metadata.
- Search for an existing phase ticket before creating a duplicate.

## Default issue shape

Use this small structure unless the project provides a template:

```markdown
## Summary

<Why this phase exists and what responsibility it owns, in plain language.>

## Outcome

<The observable capability or safety property available when it is complete.>

## Dependencies / rollout

<Only when sequencing, activation, deployment, or an external gate matters.>
```

Prefer one short paragraph per section. Add `Scope` only when a likely boundary
needs to be made explicit. Use the tracker's native link or attachment fields
for design, spec, and PR links when available rather than repeating a link list
inside every description.

Do not copy the implementation spec into the ticket. Avoid source paths, test
case catalogs, exact helper names, and low-level implementation decisions unless
they are the actual deliverable or a reviewer needs them to understand risk.

## Link the work in both directions

- As soon as the coordinating spec session creates or confirms the work item,
  write its exact identifier and canonical URL into the corresponding
  implementation spec. Replace generic placeholders such as “link the issue.”
- The implementation agent consumes that recorded identity when opening or
  updating the draft PR. It must not search for, infer, or create another work
  item. If the spec has no exact identity, report the missing handoff to the
  coordinating session instead of guessing.
- Put the work-item link in the repository's required PR-template field or the
  PR reference section.
- When the work item has a compact issue key, prefix the PR title with the exact
  key in brackets (for example, `[ISSUE-123] <human-readable title>`). Do not
  rely on an ordinary Markdown link alone: preserve the canonical link in the
  description and use the title key so supported Git integrations can establish
  their native association and status automation. If the tracker has no compact
  key, use its documented native-linking mechanism.
- Add the PR as a native link or attachment on the work item when supported.
- Add the committed pre-deletion implementation-plan link while creating the
  draft PR; do not publish a link to a local-only commit. After the PR exists,
  delete the spec in the next separate commit and keep that link as the archived
  plan used for the PR.
- Refresh the link only after a rebase or the narrow, exceptional restoration of
  a materially false archived spec; remove stale links.
- Preserve the established human-readable PR series title after the bracketed
  issue-key prefix.

## State and authorization

- Put unstarted future phases in the project's backlog/planned state. Use the
  active review state for an existing PR only when that matches local practice.
- Record real blockers and rollout gates without claiming that implementation,
  merge, deployment, or activation are the same event.
- Creating, editing, assigning, or linking a work item is an external write.
  Perform it only when the user requested that action, then verify the resulting
  title, destination, state, description, and links.

## Phase-set closeout

Before declaring a generated multi-phase specification set ready for
implementation:

1. Search the selected project for existing work items matching every phase and
   avoid duplicates.
2. Report the exact phases that already have work items and those that do not.
3. If creation/linking is not yet authorized, ask whether the missing work items
   should be created and identify the unresolved tracker/project destination.
4. Do not infer authorization from the request to write specs. Creating the
   specs and creating external tracker records are separate actions.
5. When authorized, create one appropriately scoped work item per implementation
   phase, verify its destination/state/title, and write its exact identifier and
   canonical URL into the matching spec.
6. Treat an umbrella plan, acceptance plan, or future test plan as a separate
   work item only when the user explicitly includes it; do not silently expand a
   request for phase tickets.
7. If the user declines ticket creation, record that decision in the handoff so
   a later implementation agent does not mistake the absence for an unfinished
   search.

The set is not work-item-ready while this decision remains unresolved, even when
the technical specifications themselves are implementation-ready.
