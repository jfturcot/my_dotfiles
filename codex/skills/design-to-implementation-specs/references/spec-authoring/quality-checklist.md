# Spec quality checklist

Use this after drafting and after implementation discoveries are reconciled.

## Design fidelity and ownership

- Every requirement traces to design, current code, an explicit user decision,
  or verified external evidence; refinements and conflicts are visible.
- Every schema field, message, artifact, configuration name, and side effect has
  one authoritative owner.
- Existing serializers, key derivation, normalization, capacity, error, and
  retry owners are reused unless duplication is explicitly justified.
- Cross-repository consumers can implement from their own spec; exact contracts
  replace vague “see the other PR” handoffs.
- Every confirmed, review-converged implementation or live-proof discovery has
  an explicit impact result for each downstream consumer spec: updated or
  audited with no change. Unsettled candidates were not propagated as facts.

## State and side effects

- Ordering is explicit for read, classify, reserve, provider call, persist,
  publish, release, requeue, acknowledge, cleanup, and metric emission.
- Conditions fence every field the next transition relies on.
- Post-write decisions use authoritative stored state, not a losing candidate.
- Duplicate delivery, concurrent advancement, transaction conflict, crashes at
  each durable boundary, and recovery are covered.
- Paid or irreversible work has idempotency and an operationally recoverable ID.
- Send-before-ack and write-before-publish rules are explicit.

## Bounds and failure behavior

- Relevant source, decompressed, normalized, serialized, page, attempt, delay,
  batch, timeout, pagination, and scan bounds are named.
- Each bound maps to the right retryable, permanent, deferred, or anomalous
  outcome rather than an unrelated failure label.
- Optional external fields are narrowed and sanitized at the adapter boundary.
- Malformed continuation tokens and cycles cannot silently duplicate or omit
  data.
- Unknown errors fail safely and remain observable without leaking customer
  text, keys, endpoints, credentials, or provider bodies.
- Error, metric, and log allowlists are closed at the right granularity.

## Deployment and operations

- Artifact, environment, IAM, networking, encryption caller, queue/event source,
  concurrency, visibility, alarms, and pause ownership are explicit.
- Merge, publish, plan, apply, dark deploy, attachment, activation, smoke test,
  and production rollout are not conflated.
- Missing credentials or approval remain gates, never fabricated verification.
- Safe read-only CLI inspection establishes deployed facts where possible;
  mutating proof is approved and non-production.
- Rollback changes the smallest safe control without destroying durable state.

## Tests and verification

- A behavior-changing phase contains new focused executable tests, and the
  handoff names their files, exact run command, and measured result. Lint,
  typecheck, and predecessor tests alone do not close this gate.
- A request to implement the spec was treated as the user's request to add and
  run its required tests, without a redundant permission question. If an
  applicable instruction explicitly forbade tests for that implementation,
  the implementer stopped before implementation and reported the exact
  conflict; if test execution became blocked later, the phase remains
  incomplete.
- TDD cases were normally written and observed failing before their production
  behavior was implemented, and they prove public behavior with zero-call
  assertions on rejected work.
- Cases discovered during implementation, review, or live proof have regression
  tests even when they could not have been anticipated in the initial catalog;
  “test first” was not used as a reason to leave later gaps uncovered.
- Race tests trigger real conditional failure or concurrent mutation rather than
  mocking the desired classification.
- Boundaries cover equality and just-over/under values.
- Full and predecessor regression suites are named.
- Commands use the correct directory and base branch.
- Static checks are scoped, and their messages do not overclaim.
- Executable test names contain no catalog numbering or history and still match
  assertions after corrections.

## Type integrity

- Statically typed code uses authoritative domain/library types, inference,
  narrowing, schemas, guards, and generics before resorting to assertions or
  casts.
- Casts do not conceal malformed external input, an incorrect API assumption,
  or a mismatch between producer and consumer contracts.
- Any unavoidable cast is narrow, located at the boundary whose invariant the
  compiler cannot express, and supported by runtime validation or focused test
  evidence where appropriate.

## Coherence pass

- Every generated phase spec contains the full numbered repository-entry gate;
  “spec-first” or “standard preflight” shorthand is not accepted. The gate
  names the exact repository, branch, base, ancestry proof, spec-only first
  commit, commit-content proof, and implementation start boundary.
- The lifecycle is symmetric: the spec-only commit is first; after successful
  draft publication the spec deletion is the last commit of the initial
  implementation/handoff sequence. If publication is absent or fails, the spec
  remains present.
- The spec tells the implementer to use concrete, behavior-named commit subjects
  without phase IDs or generic `Implement`/`Add specs`/`Fix review` titles,
  including for the spec-first and spec-deletion commits.
- Objective, contract, tests, files, steps, verification, Definition of Done,
  and PR handoff describe the same behavior.
- The spec records an exact PR-description outline. It uses the common narrative
  spine directly or maps it into the repository-owned template, with every
  structural deviation deliberate rather than agent-invented.
- No stale environment name, union member, field count, test total, permalink,
  base, or superseded decision survives a correction or rebase.
- Requested implementation comments are present-tense reasons, not chronology.
- After accepted corrections were implemented and verified, a downstream impact
  audit covered all known later consumers; affected specs were updated
  coherently when authorized, remained outside the current PR, and unaffected
  specs were named in the handoff.
- No phase was declared approved, review-clean, ready to commit/push, or ready
  for its successor before that downstream impact result was reported.
- The implementation spec remained present until draft PR creation/update was
  verified, then was deleted in the immediately following separate commit. A
  deleted spec was not restored for ordinary later corrections.
- When project work items are in scope, tracker destination, phase/title,
  status, PR link, and final-spec link are consistent and no stale link remains.
- For a generated phase set, every phase has an existing linked work item or an
  explicit user decision not to create one; the coordinator did not declare the
  set ready while the work-item handoff was unresolved.
- Markdown fences, headings, references, whitespace, BOM/NUL hygiene, and
  numbered planning catalogs are mechanically clean.
