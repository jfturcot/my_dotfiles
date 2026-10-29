# Downstream spec reconciliation

A completed phase can invalidate assumptions embedded in later planning
documents. Treat downstream reconciliation as part of maintaining one
milestone-wide contract, not as optional cleanup after the current PR. The
implementation and coordinating-review roles may be separate sessions or the
same agent; the convergence boundary matters, not the session layout.

## Capture discoveries during implementation and review

Record a candidate discovery when implementation, review, rebase resolution,
deployed-state inspection, or live proof may change a downstream-consumed fact,
including:

- schema fields, message shapes, status/outcome values, or error taxonomy;
- configuration or environment-variable names, defaults, validation, or
  ownership;
- ordering, idempotency, retry, concurrency, recovery, or crash-boundary rules;
- artifact names, IAM/resource needs, outputs, infrastructure addresses, or
  deployment and activation gates;
- branch bases, stack order, permanent spec links, or the evidence required to
  unblock a later phase.

The implementation session should reconcile the current phase's spec and report
facts or conflicts it encountered. It does not need to identify or edit later
planning documents unless the user explicitly assigns that work. The master or
coordinating-review session owns the downstream-consumer search after the current
implementation has converged.

If a downstream phase is already being implemented in parallel, notify that
work immediately and mark the assumption as unsettled so it does not build on a
known risk. Finalize the downstream wording only after convergence.

## Convergence gate

Run the downstream audit when all of the following are true:

- accepted review findings that affect the contract are implemented;
- focused and relevant regression verification passes;
- no unresolved design or implementation decision can change the discovery;
- the coordinating review considers the phase review-clean; and
- any user decision required for a design, product, security, retention, or
  rollout change has been obtained.

This is the phase-completion gate. A clean audit is an explicit result, not an
assumption. Run it before describing the phase as approved, review-clean, ready
to commit/push, or ready for the next phase. Reviewer acceptance, user approval,
`commit and push`, `wrap up`, and a request to start the next phase are concrete
triggers when the accepted corrections are already verified. Do not defer the
audit until the user asks whether downstream plans are current.

The draft-PR lifecycle normally deletes the current spec immediately after the
draft is created. Do not restore it merely because a later review changed code.
Use the verified implementation and review decision as the discovery source.

## Perform the audit

1. State each confirmed discovery as a present-tense fact. Identify the earlier assumption
   it replaces without copying that history into production names or comments.
2. Rebuild the affected dependency edges. Search every known unimplemented
   downstream spec across repositories, not only the next numbered phase.
3. For each consumer, inspect all relevant sections: prerequisites and gates,
   configuration/contracts, behavioral flow, files, TDD catalog, implementation
   steps, verification, Definition of Done, out-of-scope boundaries, and PR
   handoff.
4. Update every affected statement together. Do not patch only the first prose
   occurrence while leaving a stale test, check, field count, example, or gate.
5. Run mechanical parity checks when contracts are represented in multiple
   places. Compare exact sets and mappings rather than relying on counts alone.
6. Re-read each changed downstream spec from beginning to end and verify that it
   remains independently implementable on its declared base.
7. Report the discovery, every downstream spec changed, every downstream spec
   audited with no change, the checks run, and any remaining conflict or gate.

## Scope and history boundaries

- Update future planning documents locally only when the user's request or the
  current spec includes that scope. Otherwise produce the impact report and
  identify the exact edits still needed.
- Keep downstream spec edits out of the current implementation PR. Do not stage
  or commit them on the current phase branch; each future spec retains its own
  spec-first lifecycle unless the user explicitly requests a different history.
- Do not modify future-phase production code during this audit.
- Do not restore or rewrite a completed phase's deleted spec merely to narrate a
  later discovery. Code and tests own implementation truth; the approved design
  owns architecture; the archived spec records the plan used for the PR. Restore,
  reconcile, and delete it again only when it is materially or dangerously false
  about a public contract, durable schema, security property, deployment gate,
  or architectural decision, or when the user explicitly asks for an as-built
  spec.
- If the discovery contradicts the approved design or changes architecture,
  product behavior, security/retention policy, or rollout authority, stop and
  surface the conflict. Do not amend the design document implicitly.
- Tracker tickets and PR descriptions may also need refreshed dependencies or
  links, but those external writes still require explicit authorization.

## Master-session responsibility

Do not copy this downstream-audit workflow into ordinary phase implementation
specs. A zero-context implementation agent owns the current phase and reports the
facts and blockers it encounters. After review convergence, the master or
coordinating-review session searches and reconciles downstream plans. Include
downstream-spec work in an implementation spec only when the user explicitly
assigns that planning responsibility to the implementation agent; keep those
planning changes outside the current implementation PR unless separately
authorized.
