# Implementation spec format

Use this as the default shape. Add, merge, rename, or omit sections when the
work requires it, but do not omit the underlying decision merely to make the
document shorter.

## Title

```markdown
# <phase> — <plain-language slice name> (`<repository>`)
```

Use the phase identifier in the planning document. Do not copy it into durable
production identifiers or executable test names.

## What this document is

State the implementation slice, where it sits in the larger flow, what it
consumes and produces, and the principal behavior left to another phase. Keep
this to a short orientation, not a second design document.

## Branch and PR process

Specify the exact branch and base/target, independent or stacked order,
project-specific PR title, spec-first commit protocol, final-spec deletion and
permalink protocol, any required PR first line or repository template, and the
configured project-work-item handoff when one exists. Keep the tracker generic
unless the project has selected one; creating the work item remains an optional,
explicitly authorized delivery action. When a work item has been created or
confirmed, include its exact identifier and canonical URL in the spec and tell
the implementation agent to reuse it without searching for or creating a
replacement. Require the PR title to begin with that identifier in brackets
(for example, `[ISSUE-123]`) when the tracker provides a compact issue key, and
retain the canonical work-item link in the PR description; an ordinary Markdown
link alone may not establish the native Git-integration association. If no work
item exists, record that as a coordinating-session handoff rather than
delegating tracker discovery to the implementation agent.

Make the repository entry sequence a mandatory gate, not an ordinary list item:

1. Start in the named repository and verify the expected base branch/commit.
2. Create and switch to the exact implementation branch before editing code.
3. Verify the active branch with `git branch --show-current` and verify the base
   is its ancestor.
4. Stage only this spec and commit it as the first phase commit.
5. Verify that commit contains the spec and no implementation files.
6. Only then modify implementation or executable-test files.

Include that complete numbered sequence in every generated implementation
spec. Do not compress it into “spec-first,” “standard preflight,” a link back to
this reference, or an unnumbered authorization paragraph. A reader must be able
to see directly in the phase spec that the spec file is the only file in the
first phase commit and that implementation starts afterward.

Give the implementation agent a commit-subject rule in this section. Use a
short, imperative subject that tells a reviewer what behavior or artifact the
commit changes. Do not put the milestone/phase identifier in the subject; the
branch, PR, and work item already carry that context. Avoid subjects that only
say `Implement <phase>`, `Add <phase> specs`, `Fix review findings`, or `Update
tests`. Name the actual change even for the required spec-only first commit,
test-only commits, review fixes, and final spec deletion. For example:

- `Document input classification rules` (spec-only commit)
- `Cover stale and missing inputs` (behavioral tests)
- `Record validated processing outcomes` (implementation)
- `Reject invalid observations before publication` (review fix)
- `Remove published validation spec` (spec deletion)

These examples illustrate specificity, not a prescribed commit sequence. Keep
the subject concise; use a commit body when a non-obvious decision needs context.

State that the one-line request to implement the spec authorizes these local Git
operations. It does not authorize push, PR mutation, deployment, or unrelated
working-tree cleanup. If the branch/base/spec-first checks cannot be satisfied,
the implementer stops and reports the mismatch instead of continuing on the
predecessor branch.

Separate local implementation from PR publication. Keep the spec present until
the draft PR has been created or updated successfully so it can supply the PR
instructions and committed spec link. If publication is not authorized, stop
locally with the spec present. When authorized, reconcile and commit the
pre-deletion spec, push, open or update the draft while that file still exists,
verify the PR, then delete the spec in the immediately following separate commit
and push the deletion. If PR creation fails, do not delete the spec.

The linked pre-deletion blob records the implementation plan used for the PR;
it is not a second as-built contract maintained through every review round.
After deletion, ordinary fixes update code/tests, the PR description, and
affected downstream specs. Restore the archived spec only when it becomes
materially or dangerously false about a public contract, durable schema,
security property, deployment gate, or architectural decision, or when the user
explicitly requests an as-built spec. Specify that the PR remains a draft until
a human marks it ready unless the user explicitly requests a different state.

Include a `PR description contract` subsection that selects the exact outline
the implementation agent must use. Read `../delivery/pr-handoff.md`, detect any
repository-owned PR template, and record:

- the template path or that no template exists;
- the exact headings and their order;
- how the common narrative spine maps into the template's main summary section;
- any phase-specific optional sections and their placement; and
- the facts that must be refreshed after rebases or review corrections.

Use the common heading names whenever they fit. Do not merely list content the
PR must mention and leave the implementation agent to invent its own structure.
The outline may omit genuinely empty sections and add sections needed for
clarity, but differences should be deliberate and recorded in this contract.

## Durable naming, comments, and handoff

Require all of the following:

- Production files, types, classes, functions, constants, variables, resources,
  events, logs, and executable tests use domain/behavior names—not milestone,
  PR, spec-section, review-round, implementation-order, or rollout-history names.
- Executable tests describe behavior and agree with their assertions. Catalog
  numbers such as `41a` or `67b` belong only in this spec, never in test titles.
- Comments, docstrings, errors, Terraform descriptions, and test prose explain
  the current invariant, ordering requirement, or failure prevented. They do not
  narrate earlier revisions or refer maintainers to a future phase.
- Chronological words such as `legacy`, `v2`, `MVP`, and `provisional` are used
  only for a real, lasting domain distinction. Actual protocol/API versions,
  release pins, Git refs, and product terminology remain valid.
- Verification messages state only what their checks prove.
- A final audit covers every changed implementation and test file. Review
  matches in context and document legitimate exceptions rather than blindly
  renaming them.
- Rebases and corrections trigger refreshed PR overview, stack/base, gates,
  verification totals, and the sole pre-deletion spec permalink.

## Prerequisites and gates

List concrete dependencies and status: predecessor contracts, cross-repository
schema/environment/IAM/artifact/output seams, compliance approval, artifact
publication, authenticated plans, and non-production/live proof. State how each
gate is verified and what remains blocked. Never report evidence the implementer
cannot observe.

## Objective

Describe the end state in plain language. When ordering matters, include a small
flow that reveals the safety sequence:

```text
trusted input
  -> validate and classify
  -> perform guarded side effect
  -> persist authoritative state
  -> publish or acknowledge only after durability
```

## Scope discipline

State what is in scope and what remains untouched. Name existing owners to
reuse, forbidden duplicate implementations/frameworks, permitted narrow
ancestor edits, and whether this phase creates a library, runtime,
infrastructure, activation, or operational procedure.

## Configuration inputs

For each setting, give its exact name, type, validation, default or owner, and
consumer. Distinguish design-derived values, provisional tuning, secrets,
environment identity, cross-field constraints, and values validated at runtime
rather than by infrastructure. When another repository sets values, include a
normative mapping and mechanical parity check.

## Behavioral contract

Organize subsections in execution order. Specify, as applicable:

1. Trust-boundary parsing and canonicalization.
2. Current-state read and dispatch/classification precedence.
3. Eligibility and capacity admission.
4. Conditional state transition and concurrency fence.
5. External/provider call.
6. Durable result or state write.
7. Publication, acknowledgement, cleanup, or release.
8. Retry, deferral, recovery, and duplicate-delivery behavior.
9. Resource bounds and deadlines.

For every branch, define inputs, returned outcome, durable side effects,
forbidden side effects, and whether an error is retried, deferred, acknowledged,
or escalated. Use tables for closed classifications and state transitions.

Add focused subsections when needed:

- **Data/schema:** variants, field ownership, invariants, migration,
  compatibility, and serialization.
- **Ports:** narrow interfaces, adapter ownership, client construction, and pure
  test seams.
- **Errors:** closed domain taxonomy, sanitized messages, handler mapping, and
  unknown-error behavior.
- **Observability:** exact events/metrics, allowed values, dimensions, emission
  ordering, and prohibited customer/provider data.
- **Runtime/handler:** environment loader, partial batches, client retry
  settings, concurrency, timeout, and process-environment ownership.
- **Infrastructure/IAM:** resources, least privilege, encryption caller,
  networking, alarms, pause controls, and plan/apply gates.
- **Known limitation:** honest operational consequences without inventing an
  unlimited or exactly-once guarantee.

## Files

List expected files and whether each is new, extended, or explicitly untouched.
Include tests, package/barrel wiring, environment files, and authorized ancestor
edits. Reconcile this scope map when implementation discovers a justified
change; do not silently exceed it.

## TDD — write these first

For every phase that changes executable behavior, include a visible
`Required executable-test gate` near the repository-entry gate or before this
catalog. Use direct language equivalent to:

> Focused executable tests are required deliverables. The request to implement
> this spec is itself a request to add and run them; do not seek a second
> authorization merely because general session guidance says to test only
> when the user asks. Before changing
> production behavior, add representative tests from the catalog and observe
> them fail for the intended reason. Add regression tests for behavior found
> during implementation and review. Do not report the phase complete without
> naming the new test files and reporting the exact command and result for both
> the new tests and relevant predecessor regressions. Stop before changing
> implementation files only if an applicable instruction explicitly forbids
> tests for this implementation despite the spec requirement; quote that
> instruction and ask for direction. If tests
> cannot be run after work starts, report the phase as incomplete rather
> than substituting lint, typecheck, or predecessor tests.

Adapt the number of tests to the behavior and risk; this gate does not require
one executable example per numbered catalog item. A phase with no executable
behavior may instead state why executable tests do not apply and what evidence
will verify its deliverable.

Use a numbered planning catalog for traceability while forbidding those numbers
in executable test titles. Cover happy paths, every closed outcome, exact
boundaries, malformed input, duplicates, races, conditional conflicts, crashes
around durable boundaries, retry exhaustion, no-call assertions, data
non-disclosure, config parity, handler wiring, and reused-owner regressions.

Default to a red-green-refactor loop: add a focused behavioral test and confirm
it fails for the intended reason before writing the production behavior, make
the smallest coherent implementation pass it, then refactor with the suite
green. Do not turn the catalog into a claim that all useful cases can be known
up front. When implementation, review, or live proof exposes an omitted branch,
boundary, race, or regression risk, add the missing test then—even when the
production code already exists—and verify that it would have detected the gap.

Prefer behavior through public entry points. Use source checks only for
structural requirements that observable tests cannot prove economically.

## Type safety

For statically typed implementation languages, require real type discovery and
narrowing before type assertions or casts. Prefer the authoritative exported
type, inference from the actual API, discriminated unions, generics, schema
parsing, and explicit type guards. Do not use broad casts such as
`as { error: number }` merely to make a mismatch compile or to bypass an
unmodeled trust boundary. If a library or external boundary makes a cast
unavoidable, keep it at that boundary, make it as narrow as possible, explain
the invariant it represents, and cover the runtime validation or behavior with
a test. Do not require awkward abstraction solely to eliminate every cast.

## Implementation steps

A common sequence is:

1. Pass the mandatory repository/branch/base preflight.
2. Commit only the spec as the first phase commit and verify its contents.
3. Add contract/configuration and behavioral tests first; run them and confirm
   new cases fail for the intended reason.
4. Implement pure domain logic and narrow ports until those tests pass, keeping
   the language's real types intact rather than casting around mismatches.
5. Add adapters, runtime, or infrastructure with the same test-first loop where
   observable behavior can be exercised economically.
6. Add observability after durable-action ordering is correct.
7. Reconcile the current spec with discoveries affecting this phase and add
   regression tests for cases that were not anticipated by the initial catalog.
8. Run predecessor regressions and full verification against the committed diff.
9. If PR publication is not authorized, stop with the spec present and report
   the local implementation.
10. When authorized, reconcile and commit the spec, push, open or update the
    factual draft PR while the spec is present, link that committed revision,
    and verify that PR creation/update succeeded.
11. Delete the spec in the immediately following separate commit and push that
    deletion. This is the last commit of the initial implementation/draft-PR
    handoff. Leave the PR link on the pre-deletion blob. Later review fixes may
    add ordinary code/test commits without restoring the archived spec.
12. Resolve later review findings in code/tests and refresh the PR description.
    Do not restore the archived spec for ordinary corrections; run the mandatory
    downstream audit when review converges.

Adapt this sequence to risk; do not force it when infrastructure or live proof
must precede implementation.

## Verification

Give commands runnable from an explicit directory. Include the relevant subset:
tests; typecheck/build/lint/format; `git diff --check <base>...HEAD`; scope and
forbidden-dependency checks; contract/env parity; Terraform validation and
authenticated plans; and non-production/live proof.

Make checks truthful. Grep can prove a named string is present or absent, not IAM
exactness, execution ordering, or runtime success. Use tests, plan/code review,
or live evidence for those properties. Do not build a fragile parser solely to
make a verification bullet appear automated.

## Definition of Done

Restate externally meaningful completion: functional outcomes, safety
invariants, boundedness/idempotency/concurrency, security and observability,
required live gates, independent implementability, the naming/comment audit,
and anything created but deliberately left dark or disabled. Downstream-plan
reconciliation belongs to the coordinating review workflow, not the zero-context
implementation agent's Definition of Done, unless the user explicitly assigns
that planning work to the implementer.

## Out of scope — do not expand

Name adjacent tempting work and its owner/phase when known. Include prohibited
abstractions, migrations, cleanup, rollout, or provider behavior. These are
boundaries, not a backlog hidden inside the implementation PR.

## Optional sections

- **Revision note:** material design reconciliation after implementation; keep
  history here rather than in production comments.
- **Compliance/Legal gate:** place near the top when it blocks activation.
- **Deployment/rollback:** when merge, apply, dark deploy, attachment, and
  enablement are separate.
- **Open decisions:** unresolved choices with criteria and blocking status.
- **PR description contract:** exact common/template heading order, optional
  phase-specific sections, and handoff details that are easy to omit.
