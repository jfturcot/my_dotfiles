# PR handoff

A draft PR is the portable boundary between an implementation agent and the
coordinating reviewer, including when they do not share a workspace. The
implementation agent records a concise, accurate handoff; the coordinating or
master session turns it into the final human-facing review guide before a human
marks the PR ready.

## Use the repository template first

Locate repository-owned templates:

```sh
rg --files .github | rg -i 'pull.request|template'
```

If one exists, preserve its headings, required links, QA choices, checklists,
screenshots, and documentation requirements. Put the technical narrative inside
the appropriate sections rather than replacing the template. Fill required
fields honestly; use `N/A` with a reason when appropriate. Link the expected
project work item using the configured tracker.

Repository templates control the outer headings, but they do not eliminate the
common narrative structure below. Put that structure inside the template's main
summary section, using one lower heading level. For example, under
`#### What does this PR do? (required)`, use `##### In one sentence`,
`##### Goal and place in the milestone`, and the remaining applicable common
sections. Do not prepend a second unheaded technical essay before the template,
and do not collapse the whole narrative into one uninterrupted block.

## Common narrative structure

Use this base order for every PR description. Without a repository template,
these are the outer headings. With a template, nest them under its primary
summary heading as described above.

```markdown
## In one sentence

<The durable purpose of this slice.>

## Goal and place in the milestone

<Why it exists, where it fits, and why this order is safe.>

<A small text flow showing guarded ordering, when useful.>

## What this PR adds

- <Concrete reviewer-oriented capabilities.>

## Important safety properties

- <Ordering, idempotency, concurrency, bounds, and privacy.>

## Important limitation

<Only when it affects review or operation.>

## Suggested review order

1. `<path>` — <what the reviewer should understand there>.

## Scope / deployment

<What changes, what stays untouched, and whether anything becomes active.>

## Stack and references

- Base/stack
- Permanent implementation-spec link
- Project ticket
- Design link when useful

## Verification

- [x] <Measured local result>
- [ ] <Open external gate and owner>
```

The shared spine is:

1. `In one sentence`
2. `Goal and place in the milestone`
3. `What this PR adds`
4. `Important safety properties`
5. `Suggested review order`
6. `Scope / deployment`
7. `Stack and references`
8. `Verification`

Keep these headings and this order when they apply. A small PR may merge
`In one sentence` into `Goal and place in the milestone`, or omit a genuinely
empty safety/review section. A specialized PR may insert focused sections such
as `Important limitation`, `Live non-production proof`, `Migration`,
`Deployment / rollback`, or `Operational evidence` next to the common section
they clarify. Prefer adding a specific section over renaming a common one to a
phase-specific synonym such as `Outcome`, `Harness additions`, `Deployment
scope`, or `Measured verification`; consistent names make stacked PRs easier to
scan.

The initial implementation-agent draft may use a compact subset only when the
PR is still explicitly an early draft. Before publication handoff or human
review, expand it to the applicable common spine, remove implementation-diary
detail, and keep specialized sections only where they improve review.

## Write for ESL and ADHD readers

Make the description easy to understand on the first pass without sacrificing
technical accuracy.

- Start each section with its takeaway. Put supporting mechanism and edge cases
  after the outcome they explain.
- Use short sentences and short paragraphs. Prefer one idea per bullet; split a
  bullet when it contains multiple guarantees, failure modes, or review tasks.
- Use plain, literal language. Avoid idioms, clever phrasing, unexplained
  abbreviations, long parenthetical chains, and sentences with several nested
  clauses.
- Give important labels a stable visual anchor such as `Purpose:`, `Safety:`,
  `Does not do:`, or `Owner:` when that makes a dense section easier to scan.
  Use bold sparingly for these labels, not for general emphasis.
- Separate what changed, why it matters, and how it is enforced. A reviewer
  should not need to infer the user-visible or operational effect from class
  names and implementation details.
- Put the highest-risk safety property or limitation first. State who owns an
  open gate or follow-up and what must happen next.
- Keep code identifiers only where they help review. Pair each path, class, or
  command with a short description of its role.
- Prefer a small flow, table, or checklist when it makes ordering or status
  materially clearer. Do not add visuals for simple prose.
- Remove review-history narration. Describe the final behavior and current
  limitations, not the sequence of mistakes and corrections that produced it.

Before publishing or refreshing the description, scan it as a reviewer would:
the purpose, risk, scope, review order, deployment effect, and verification
should each be findable in seconds.

## Make the implementation spec choose the outline

Every implementation spec must contain a `PR description contract` subsection
under `Branch and PR process` (or an equivalent clearly named section). It must:

- say whether a repository-owned template exists and name its path when known;
- list the exact PR-description headings in their intended order;
- map the common narrative spine into the repository template when one exists;
- identify any additional phase-specific sections and where they belong;
- require the final description to follow the ESL/ADHD readability rules above:
  short sentences, one idea per bullet, plain language, and progressive detail;
- require final measured verification, stack/base, gates, links, and deployment
  state to be refreshed after rebases and review corrections; and
- forbid the implementation agent from inventing a new parallel outline when
  the recorded outline still fits.

This is a presentation contract, not a demand for boilerplate. The content and
length still follow the PR's risk and reviewer needs.

## Title, branch, and stack

- Infer the project title prefix from the design and existing PRs. Follow the
  repository's established title pattern when one exists.
- When the spec records a confirmed work item with a compact issue key, prefix
  the PR title with that exact key in brackets, for example
  `[ISSUE-123] <project or milestone> <phase>: <slice name>`. This is both
  human-visible context and a native Git-integration link signal. If the tracker
  has no compact issue key, follow its native linking convention instead.
- Follow repository branch conventions.
- A stacked PR targets its predecessor branch and states stack order. Do not
  target `main` merely because the stack eventually lands there.

## Draft status and authorization

- Pushing a branch and opening or updating a PR require explicit user
  authorization.
- Once authorized, create an agent-authored PR as a draft unless the user
  explicitly requests otherwise.
- Leave the PR in draft state after creating or updating it. A human owns the
  ready-for-review transition unless the user explicitly authorizes the agent to
  make that transition.
- A short instruction such as `Open the PR` supplies the authorization; obtain
  all title, base, template, description, link, and draft-state details from the
  implementation spec and repository conventions rather than asking the user to
  repeat them.
- Use the exact work-item identifier and canonical URL recorded in the spec.
  The implementation agent does not search for, infer, or create a replacement
  ticket during PR handoff.
- A draft may be opened before review convergence. Keep the implementation spec
  present until PR creation succeeds, and link its reconciled committed revision
  so a remote coordinating session can review both contract and code.

## Spec lifecycle

1. Commit the spec before implementation.
2. Keep it reconciled while implementing and commit the pre-deletion revision
   that accurately describes the initial completed handoff.
3. If PR publication is not authorized, stop locally with the spec present.
4. When authorized, push and open or update a draft PR while the spec is still
   present; link that committed pre-deletion revision and verify the PR exists.
5. Only after successful PR creation/update, delete the spec in the immediately
   following, separate commit and push the deletion. If PR creation fails, keep
   the spec.
6. Leave the PR link pointing to the pre-deletion blob and leave the PR as a
   draft for coordinating review and a human's ready-for-review decision.
7. During later review rounds, update code/tests, the PR description, and
   downstream specs. Do not restore the archived spec for ordinary corrections.
8. Restore/reconcile/delete the archived spec, and replace its permalink, only
   when it is materially or dangerously false about a public contract, durable
   schema, security property, deployment gate, or architectural decision, or
   when the user explicitly requests an as-built spec.

## Accuracy rules

- Describe the final diff, not a diary of review rounds.
- Lead with the goal; implementation details follow.
- Do not paste the whole spec into the PR.
- Refresh measured tests, base/stack, artifact/gate state, review order, and
  permalink after rebases or corrections.
- Do not imply merge authorizes artifact publication, apply, activation, or
  production rollout.
- Distinguish grep/property checks from plan, IAM-policy review, and live proof.
- Include honest limitations and pending approvals.
