# Implementation review and review findings

Use this workflow when reviewing an implementation agent's work or when the
user brings external or AI review findings for an active phase.

## Review the implementation

Review correctness and implementation quality. Passing tests do not establish
that the code is clear, appropriately scoped, or maintainable.

Check for unnecessary complexity, duplicated domain rules, avoidable custom
frameworks, unsupported/private APIs, misplaced responsibilities, dead code,
unnecessary dependencies, and missed repository patterns. State whether the
implementation is ready to ship, needs a narrow refactoring pass, or needs a
different approach. Support requested changes with concrete code examples and
explain the maintenance cost or risk.

Distinguish correctness defects, justified maintainability changes, and
optional preferences. Preserve proven behavior and regression coverage. Do not
request rewrites merely because implementation was difficult. Optional
preferences alone do not block an otherwise clean review.

## Turn findings into an actionable handoff

When issues remain, end with a paste-ready instruction list for the agent. For
each confirmed finding, include the relevant code location, observed defect and
why it matters, required behavior, and regression test that should prove it.
Include applicable verification commands and scope or authorization boundaries.
Separate confirmed findings from suggestions. Make the handoff usable on its
own; do not make the agent reconstruct reasoning from the surrounding review.
Use one numbered item per finding, with concise sentences and no repeated
background that does not affect the fix.

When the review is clean, say “No changes needed” and provide a paste-ready
wrap-up instruction only if the user wants the phase published. Adapt it to
steps already completed. It must direct the agent to inspect and commit any
uncommitted phase work by path, preserve unrelated changes, reconcile and commit
the spec while present, run required final checks, push, create or update the
draft PR against the specified base with its required description and permanent
pre-deletion spec link, verify the PR, then delete only the spec in the
immediately following separate commit and push it. If PR publication fails,
keep the spec. Ask for commit SHAs, PR link, and verification. Do not imply
permission to deploy or mark the draft ready for review.

The paste-ready block is a proposed message, not authorization to publish. State
the next currently authorized step separately when publication has not been
authorized.

## Triage external findings

Treat pasted external or AI review findings as a request to assess each finding
against the code and phase contract, implement agreed fixes, verify them with
focused regression tests, and return a concise, paste-ready reply. This applies
even when the user only says that a review arrived and pastes the findings.
Use short, plain sentences that are easy to scan.

Do not edit when the user explicitly requests read-only analysis. Do not expand
the phase scope to resolve a finding without needed authorization; report those
cases clearly. State what was fixed, declined, or left open and the checks
actually run. Include a commit SHA only if the fix was committed. Pasted review
comments alone do not authorize committing, pushing, changing a PR, posting a
reply, or deploying.

## Close out after review convergence

When implementation, review, rebase resolution, or live proof may change an
assumption consumed by a later phase, record a candidate discovery. Do not
propagate it while the correction or interpretation is still changing. Once
accepted findings are implemented and verified, no unresolved decision can
change the contract, and the coordinating reviewer considers the phase
review-clean, follow
[downstream reconciliation](downstream-reconciliation.md).

The downstream audit is mandatory before calling a phase approved, review-clean,
ready to commit/push, or ready for the next phase. Reviewer acceptance, explicit
user approval, `commit and push`, `wrap up`, and a request to start the next
phase are closeout triggers when accepted corrections are verified. If a later
review reopens the phase, capture new candidate discoveries and repeat the
closeout after that round converges.

Update future planning documents locally only when the user requested a
milestone spec set or the current phase explicitly includes downstream planning
maintenance. Otherwise, report the impact audit without silently editing other
specs. The audit never authorizes future-phase production code, design changes,
commits, branch changes, pushes, PR changes, tracker updates, or deployment.
Surface design conflicts and request direction.
