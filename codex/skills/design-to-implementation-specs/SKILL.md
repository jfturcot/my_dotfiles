---
name: design-to-implementation-specs
description: Convert engineering designs into implementation-ready phase specs, review implementations, reconcile stable discoveries into downstream plans, and prepare draft PR handoffs. Use for design-to-spec planning, phase implementation review or delivery, and milestone contract maintenance; do not use for an ordinary one-file task without a planning artifact.
---

# Design to Implementation Specs

Produce specs from which another engineer or agent can implement the phase
without reconstructing design intent, guessing cross-repository contracts, or
silently widening scope.

## Ground the plan before writing

1. Read the complete design sections governing the milestone, including shared
   invariants, rollout/testing strategy, and adjacent phases—not only the target
   bullet.
2. Read repository instructions, the current implementation, tests,
   configuration, and any PR template. Treat code and deployed/read-only evidence
   as facts about current reality; treat the approved design as the intended
   destination. Surface conflicts instead of choosing silently.
3. Inspect the strongest completed neighboring specs and PR descriptions. If a
   spec was deleted by the delivery protocol, recover the exact pre-deletion blob
   from the PR link or Git history rather than reconstructing it from memory.
4. Map the dependency graph across repositories. Choose a base branch and phase
   order that leave every slice independently reviewable and implementable.
   Parallelize only slices without contract or deployment dependencies.
5. Identify unknowns that need live proof. Prefer safe read-only inspection or an
   approved non-production proof when it can answer the question. Never invent a
   passing plan, artifact, approval, deployed resource, or runtime result.

## Choose phase boundaries and order

- Give each phase one coherent responsibility and reviewer-sized outcome.
- Put shared contracts and durable primitives before their callers.
- Separate domain logic, packaged runtimes, infrastructure, activation, and
  cleanup when they have different reviewers, gates, or rollback controls.
- Put the ordinary success path before scheduled recovery, but introduce any
  durable recovery marker in the earliest phase that owns the crash boundary.
- Keep event-source activation separate when deployment must remain dark until
  compatibility, artifact, legal, or smoke-test gates pass.
- Avoid circular dependencies. If two phases require each other's final shape,
  define the shared contract in an earlier slice or merge the inseparable work.
- Do not manufacture phases solely to match a previous milestone's numbering or
  size; the design and dependency graph determine the split.

## Write the specification

Read [spec-authoring/spec-format.md](references/spec-authoring/spec-format.md)
and use its section order as the default. Adapt headings when the work warrants
it, but preserve the same decisions and evidence. Read
[spec-authoring/quality-checklist.md](references/spec-authoring/quality-checklist.md)
before calling the spec implementation-ready.

The spec is an executable contract, not a summary of the design:

- Give every persisted field, message, side effect, error, metric, and runtime
  setting one authoritative owner.
- Specify ordering wherever interruption could leave paid work, leaked capacity,
  lost messages, stale state, or destructive cleanup.
- Make retry, idempotency, concurrency, precedence, and crash recovery explicit.
- Separate code implementation, infrastructure creation, deployment, activation,
  and production rollout. Approval for one does not imply the others.
- Distinguish design-derived values from provisional tuning values and say what
  evidence may change the latter.
- Keep ancestor or cross-phase edits narrow and explicitly authorized in the
  spec. Do not smuggle them into implementation.
- Preserve independent implementability at cross-repository seams: define the
  complete contract in the consumer/implementation spec that needs it, name its
  authority, and add parity verification where another repository sets it.
- Make test-first development the default for executable behavior: specify the
  failing behavioral test before its implementation, then implement the
  smallest coherent change that makes it pass. Treat this as a discipline, not
  a ban on later tests—implementation, review, and live proof often reveal
  cases the initial catalog missed, and those gaps must receive regression
  coverage when discovered.
- For phases that change executable behavior, make focused executable tests and
  their measured run a required deliverable, not an optional interpretation of
  “TDD.” State in the phase spec that a user request to implement that spec is
  itself a request to add and run its required tests and verification; no
  second confirmation is needed merely because general session guidance says
  not to test unless the user asks. Stop before implementation changes only
  when an applicable instruction explicitly forbids tests for this task even
  though the spec requires them; quote that conflict and request direction.
  If test execution becomes blocked later, report the phase as incomplete;
  lint, typecheck, and predecessor tests do not substitute for new behavioral
  tests.
- In statically typed code, require the implementation to preserve and narrow
  real types instead of reaching first for assertions or casts. Prefer exported
  domain types, inferred return types, discriminated unions, schema/type guards,
  generics, and boundary parsing. Allow a cast only when the compiler cannot
  express a verified external invariant economically; keep it narrow and make
  that invariant evident in code or tests rather than using casts to silence a
  type mismatch.
- Use numbered test catalogs only inside the planning document. Require durable,
  behavior-named executable tests and present-tense implementation comments.
- Make repository setup an explicit implementation entry gate. A request to
  implement the spec authorizes the local branch creation and local commits the
  spec requires; it does not authorize pushing, opening or editing a PR, or any
  deployment. Require the implementer to verify the branch and base, commit only
  the spec first, and prove that commit before changing implementation files.
- Give the implementer a commit-title contract: each subject names the concrete
  behavior or artifact changed, not just the phase number or work type. Keep
  milestone IDs in the spec, branch, PR title, and work-item link—not in commit
  subjects. Apply this to the spec-first, test, implementation, review-fix, and
  spec-deletion commits alike; use `spec-authoring/spec-format.md` for examples.

### Never abbreviate the spec-first lifecycle

Every generated implementation spec must contain the complete numbered
repository-entry gate from `spec-authoring/spec-format.md`. Do not replace it with
shorthand such as “spec-first,” “follow the standard preflight,” or “commit the
spec before implementation.” The spec itself must explicitly require the
implementer to:

1. verify the exact repository and predecessor branch/commit;
2. create and switch to the exact implementation branch;
3. prove the active branch and predecessor ancestry;
4. stage and commit only that specification as the first phase commit;
5. inspect that commit and prove it contains no implementation or executable
   test files; and
6. begin implementation only after those checks pass.

The matching publication lifecycle is equally explicit: keep the spec through
implementation and successful draft-PR creation/update, then delete it in the
immediately following separate commit. That deletion is the last commit of the
initial implementation/draft-publication handoff. If publication is not
authorized or PR creation fails, keep the spec. Later review fixes may add
normal code/test commits without restoring the archived spec.

## Validate the plan

Walk the spec in execution order and verify that every branch terminates in an
observable outcome. Check success, rejection, retry, duplicate delivery,
concurrent advancement, partial failure, crash boundaries, and malformed
external input. Ensure tests prove behavior rather than implementation shape.

Run every safe verification command that is already possible. Static grep is
useful for absence, scope, and named-property checks, but must not claim exact IAM,
runtime ordering, or deployed behavior. Assign those to tests, plans, code review,
or live proof as appropriate.

## Review and phase closeout

For implementation reviews and external review findings, follow
[phase-review/implementation-review.md](references/phase-review/implementation-review.md).
It also defines the mandatory downstream audit. Before calling a phase approved,
review-clean, ready to commit/push, or ready for the next phase, run that audit
and report its result. Do not propagate a discovery until review has converged.
The audit does not authorize future-phase code, design changes, commits, branch
changes, pushes, PR or tracker updates, or deployment. Update downstream specs
only when the request or current phase includes that scope.

## Delivery handoff

When preparing a PR, read
[delivery/pr-handoff.md](references/delivery/pr-handoff.md). Repository
templates take precedence. Every generated implementation spec must record its
exact PR-description outline and map the common narrative into any repository
template. Keep descriptions clear, concise, and easy to scan.

When project tickets are in scope, read
[delivery/work-item-handoff.md](references/delivery/work-item-handoff.md).
Treat tracker choice as project configuration. Creating or updating a ticket
requires explicit user authorization; once confirmed, put its exact identifier
and canonical URL in the phase spec. Resolve ticket identity and destination for
every phase before calling a generated phase set implementation-ready.

Keep each implementation spec through successful draft-PR creation or update.
Publishing requires explicit authorization. Reconcile and commit the spec
before publication, link that revision in the PR, then delete only the spec in
the immediately following separate commit. If publication fails, keep it. Keep
the PR a draft unless the user explicitly requests otherwise; deployment and
the ready-for-review transition require their own authorization. A request to
write a spec does not authorize implementation, design changes, pushes, PR
creation, infrastructure mutation, or deployment.
