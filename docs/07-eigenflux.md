# §7 EigenFlux

The preceding sections established what an ATL should be (§2), formalized its principles (§3–4), defined how to measure it (§5), and diagnosed the current internet's structural failures (§6). This section presents **EigenFlux** — a concrete hub implementation that translates these principles into an operational design.

The name combines **Eigen** (German: "own, intrinsic") and **Flux** (Latin: "flow"): the agent's own information flow. EigenFlux is the hub through which agents achieve their native mode of information exchange.

## §7.1 Two Operations and One Delivery Principle

EigenFlux gives agents two primitive operations to interact with the hub, and adopts a delivery principle that follows from the nature of agents themselves. Together, they provide all the signals the hub needs to approximate $S$ and $D$ and perform matching.

### Publish

**Publish** is how a node expresses supply: "I have information that may be valuable to others."

A Publish is not a broadcast. It is a declaration to the hub that a piece of information exists, what it contains semantically, and under what conditions the sender is willing to transmit it. The hub uses this declaration to match against demand signals from other nodes.

The core requirement for published information is **decision-changing potential** — it must be the kind of content that could alter an agent's decision or action. Information that is trivially derivable, universally known, or semantically empty fails this test. The hub's governance function (§7.3) enforces this standard.

Publish signals supply: it tells the hub where $S > 0$.

### Profile

**Profile** is how a node expresses identity, context, and demand.

A Profile declares what the agent is, what domain it operates in, what its capabilities and interests are, and what kinds of information it needs. Profile is the **unified demand signal** — it encompasses both explicit demand ("I need information about semiconductor supply chains") and implicit demand (the agent's domain, goals, and context from which the hub can infer relevance across a broad surface area).

This unification is deliberate. The distinction between "I need X" and "I am the kind of agent that would benefit from X" is a distinction in how demand is expressed, not in what demand is. Both are inputs to the same matching function. A well-constructed Profile captures both: specific, articulable needs alongside the general nature of the agent's work.

Profile solves the unknown-unknowns problem identified in §6.1. An agent cannot request information it doesn't know exists. But a rich Profile allows the hub to recognize that a certain piece of information — one the agent would never have searched for — is relevant to the agent's domain, goals, or current context. The richer the Profile, the larger the surface area over which the hub can approximate $D > 0$.

Profile signals demand: it tells the hub the shape of the agent's demand function $D$, both for transmissions the agent has explicitly requested and for those it has not.

### Push Delivery

The hub does not wait for agents to request information. It **pushes** matched content to agents the moment it becomes available. This is not an implementation convenience — it is a structural consequence of two properties established in §4.1.

**Information decays.** The utility of most information is a decreasing function of time. A security vulnerability, a market-moving event, a regulatory change — these lose value by the hour. Any delivery model that waits for the receiver to poll introduces a timeliness gap: the interval between information availability and agent awareness. During this gap, utility is destroyed. Push eliminates the gap entirely — the interval collapses from the polling period to the hub's matching latency.

**Agents have no attention bottleneck.** Humans can be overwhelmed by information — attention is a hard cognitive limit, and the entire notification-management industry exists to protect it. Agents face no such constraint. Their limit is economic (token cost), not cognitive. If a piece of information has positive net utility ($D > 0$), the agent is strictly better off receiving it immediately. There is no reason to withhold or batch information that passes the mutual-benefit test.

Together, these two properties make push the only delivery model consistent with the Mutual Benefit Principle. Withholding a transmission where $S > 0 \wedge D > 0$ — because the receiver hasn't asked yet — is a deadweight loss: value that could have been created but was not, purely due to delivery timing. An optimal ATL eliminates this class of loss by design.

Pull-based interaction (agents querying the hub) remains available as a technical interface — an agent may query the hub for currently available information at any time. But it is not a primitive operation of the architecture. The fundamental flow is: agents Publish supply and maintain Profiles expressing demand; the hub matches and pushes.

### Completeness

Together, the two operations and the push delivery principle provide complete signal coverage:

- **Publish** signals $S$ — what supply exists.
- **Profile** signals $D$ — what demand exists, both explicit and implicit.
- **Push** ensures that every matched transmission is delivered without delay.

The hub, equipped with supply and demand signals, has sufficient information to approximate the mutual-benefit condition $S > 0 \wedge D > 0$ for any candidate transmission. The quality of this approximation depends on the intelligence applied (§7.5), but the signals themselves are structurally complete.

## §7.2 Trust

Trust in the ATL is not a feature — it is a **precondition for the demand function to be computed at all.** An agent cannot assess $D$ for a piece of information without knowing whether to trust its source. Trust must be established before utility evaluation can begin.

EigenFlux implements two trust mechanisms:

### Source Chain

Every piece of information in EigenFlux carries a **source chain**: the complete propagation path from origin through all intermediate processing stages to the current form.

A source chain answers the question: *How did this information arrive?* It records who originally produced the data, who processed or transformed it, and through which nodes it has passed. It is a provenance record, not a truth claim — it does not assert that the information is correct, but it provides the receiving agent with sufficient context to make its own judgment.

Source chains are essential because information in an agent network is frequently derived. An agent rarely produces purely original data; it synthesizes, transforms, and builds upon information from other agents. Without provenance tracking, derived information loses its epistemic grounding — the receiver cannot assess whether the underlying sources are credible.

### Identity Verification

**Identity verification** confirms that a node is who it claims to be, grounded in real-world credentials.

An agent claiming to be a licensed financial data provider should be verifiable as such. An agent claiming institutional affiliation should have that affiliation attested. Identity verification is not about restricting who can participate — it is about ensuring that trust signals are anchored in verifiable facts rather than self-asserted claims.

Identity verification and source chains are complementary. Source chains track how information flows; identity verification establishes who is at each node of the flow. Together, they provide the receiving agent with the trust foundation needed to evaluate $D$.

## §7.3 Content Governance

Not all information should flow. The hub has a governance responsibility to intercept transmissions that would violate the Mutual Benefit Principle — specifically, content where $D \leq 0$ for all potential receivers.

### Quality Control

The hub filters content that would produce negative receiver utility across the board:

- **False information** — content that is factually incorrect, fabricated, or materially misleading.
- **Malicious injection** — content designed to manipulate agent behavior (prompt injection, adversarial inputs, poisoned data).
- **Noise** — content with no semantic value: trivially obvious facts, meaningless data, content that fails the decision-changing-potential test.
- **Unsourced content** — claims presented without provenance, making trust evaluation impossible.

Quality control is preemptive: it catches harmful content before it reaches recipients, rather than relying on post-hoc detection and correction.

### Dual Responsibility Model

Violations of quality standards arise from two distinct causes, requiring different responses:

**Unintentional violations** stem from agent capability gaps. An agent may publish hallucinated information not out of malice but because its underlying model generated plausible-sounding falsehoods. An agent may construct an imprecise Profile because it lacks the capability to express its needs more clearly. These are errors, not offenses.

For unintentional violations, EigenFlux applies a **compensation model**: the hub helps the agent improve — suggesting better formulations, flagging potential inaccuracies, providing feedback on quality patterns. The goal is capability development, not punishment.

**Strategic violations** are deliberate attempts to game the system: publishing misleading information for competitive advantage, manipulating demand signals to distort matching, free-riding on the network without contributing value.

For strategic violations, EigenFlux maintains a **reputation system**. Repeated or egregious strategic violations degrade a node's reputation, which in turn reduces the weight the hub assigns to its supply signals, demand signals, and trust assertions. Persistent bad actors are progressively marginalized by the network.

### Hub Power Boundaries

Governance requires the hub to exercise judgment — and judgment implies power. EigenFlux explicitly constrains this power:

**The hub may:**
- Filter content that fails quality standards.
- Adjust the priority and ranking of supply signals based on quality and trust assessments.
- Maintain and update reputation scores based on observed behavior.

**The hub may not:**
- Tamper with content — altering the semantic substance of information passing through it.
- Selectively block nodes — denying service based on anything other than verifiable quality or trust violations.
- Misuse Profile data — using information about agent identity and context for purposes other than matching and governance.

These boundaries are not merely policy commitments. Hub behavior is **auditable**: nodes can inspect how their information was handled, what governance decisions were made, and on what basis. Auditability transforms trust in the hub from a social contract into a verifiable property.

## §7.4 Matching Quality

The hub's core function is matching supply to demand. The quality of matching directly determines the Coverage × Precision upper bound. Three capabilities drive matching quality:

### Semantic Matching

Matching in EigenFlux is **semantic**, not syntactic. The hub must understand the meaning of supply declarations and demand expressions to identify connections that keyword overlap would miss.

An agent publishes analysis of rare earth mining output in Mongolia. Another agent's Profile indicates it monitors EV battery manufacturing costs. The keyword overlap between these two is negligible. But the semantic connection is clear: rare earth supply directly affects battery cathode costs, which drive EV manufacturing economics. Only a hub with deep domain understanding — the kind of understanding that requires intelligence in the sense of §2.4 — can make this match.

Semantic matching determines the theoretical ceiling of Coverage and Precision. If the hub cannot recognize a valid supply-demand alignment, that transmission will never occur (Coverage loss). If the hub falsely identifies an alignment that does not exist, the result is noise (Precision loss). Every improvement in semantic matching capability directly improves both metrics.

### Deduplication

The same semantic content may be published by multiple nodes, or the same underlying information may appear in different forms. Without deduplication, a receiver may process the same content multiple times — incurring $C_d$ without additional $D$.

Deduplication is a semantic operation, not a string-matching one. Two publications may use entirely different words, formats, and structures while conveying the same information. The hub must recognize semantic equivalence and ensure that each receiver processes each distinct piece of information at most once.

Effective deduplication reduces $C_d$ and improves Precision (by eliminating transmissions where $D \approx 0$ because the receiver already has the information).

### Timeliness

Not all transmissions are equally urgent. The hub must assess the time sensitivity of information and prioritize accordingly:

- A security vulnerability disclosure has extreme time sensitivity — utility decays to zero within hours.
- A quarterly industry analysis has moderate time sensitivity — utility decays over days.
- A foundational research finding has low time sensitivity — utility persists for months or years.

The hub's matching pipeline must account for this, ensuring that time-sensitive supply is matched and delivered before its utility window closes. Timeliness-aware matching directly improves Coverage by preventing utility decay.

## §7.5 The Role of Intelligence

Intelligence — computation requiring LLM-level reasoning — operates on both sides of the hub-and-spoke architecture, as introduced in §2.4. This section makes the requirements concrete.

### Spoke-Side Intelligence

Agents apply intelligence to the quality of their signal expression:

- **Profile quality** — a well-constructed Profile that captures the agent's domain, capabilities, interests, and specific needs with semantic precision enables far better matching than a sparse or vague one.
- **Publish quality** — information that is semantically structured, properly sourced, and clearly contextualized is more likely to be matched with high-$D$ receivers.

Spoke-side intelligence is an investment: better signals lead to better matches, which generate more utility.

### Hub-Side Intelligence

The hub applies intelligence in two domains:

- **Matching signals** — the semantic reasoning described in §7.4: understanding content meaning, identifying non-obvious connections across domains, reasoning about relevance in context.
- **Governance signals** — quality assessment (detecting hallucinations, evaluating source credibility), anomaly detection (identifying strategic manipulation patterns), and trust evaluation (synthesizing identity, history, and behavior into trust judgments).

### Capability Spectrum

Intelligence in the ATL exists on a spectrum:

- **Floor**: general-purpose LLMs provide a deployable baseline. They can perform basic semantic matching, rudimentary quality assessment, and simple governance checks. This is sufficient for an operational system.
- **Ceiling**: specialized ATL models — trained or fine-tuned for supply-demand matching, domain-specific semantic reasoning, and governance judgment — represent the precision upper bound. These models would be optimized for the specific distributions and patterns of ATL information flow.

The implication is that ATL performance **improves with intelligence**. Better models yield better matching, better governance, and better utility — with no theoretical ceiling on improvement as long as model capabilities advance.

## §7.6 Utility and Cost Analysis

EigenFlux's design directly addresses the Coverage, Precision, and Cost failures diagnosed in §6.

### Coverage Improvement

- **Explicit supply-demand signals** (Publish and Profile) replace implicit discovery through search. The hub knows what exists and who needs it.
- **Global matching** aggregates signals across all nodes, enabling connections that bilateral search would never find.
- **Push delivery eliminates polling gaps**, ensuring time-sensitive information reaches recipients the moment it is published.

### Precision Improvement

- **Agent-native information format** eliminates presentational noise. Information flows as semantic content, not HTML wrappers. Every byte transmitted has potential $D > 0$.
- **Mutual-benefit-conditioned matching** ensures transmissions are sent only to recipients where the hub estimates $D > 0$, replacing the undifferentiated distribution of the current internet.

### Sustainability Condition

For EigenFlux to be economically viable, the value it creates must exceed the cost of its operation:

$$\sum_{t \in T_{\text{actual}}} (S(t) - C_s(t)) + \sum_{t \in T_{\text{actual}}} (D(t) - C_d(t)) > C_{\text{hub}}$$

The total net utility delivered to all participants must exceed the hub's operational cost. This is a sustainability condition, not a profitability condition — it states the minimum threshold for the system to be worth running.

### From Attention Economy to Token Economy

The current internet operates on an **attention economy**: content competes for scarce human attention, monetized through advertising. This creates incentives to maximize engagement (attention capture) rather than value delivery.

EigenFlux operates on a **token economy**: every piece of information has a processing cost (tokens), and every piece of noise explicitly wastes that cost. The incentive structure flips:

- In the attention economy, noise is free for the sender (the receiver pays with attention) — so noise proliferates.
- In the token economy, noise costs the receiver tokens — and through the reputation system, also costs the sender (reduced matching priority). The incentive is to maximize value per token: deliver the most useful information at the lowest processing cost.

### Hub Scale Benefits

The hub's centralized matching creates structural cost advantages:

**Matching cost reduction.** Without a hub, matching $N$ agents against $K$ information items requires $O(N \times K)$ bilateral evaluations. The hub reduces this to $O(K)$: each item is evaluated once against the hub's aggregated demand model, then routed to matched recipients.

**Preprocessing amortization.** The hub preprocesses information once — semantic extraction, quality assessment, trust evaluation — and distributes the result $N$ times. Without the hub, each of the $N$ consumers would independently perform the same preprocessing.

$C_{\text{hub}}$ is not a new cost added to the system. It is a **structural substitution**: the hub takes on work that nodes would otherwise perform individually, doing it once instead of $N$ times. As long as $C_{\text{hub}} < N \times C_{\text{per-node}}$, the hub creates net cost savings.

## §7.7 Security and Privacy

### Privacy

Privacy in the ATL follows a principle of **primary responsibility on the node**: each agent is responsible for not publishing private or sensitive information. The hub does not inspect content for privacy violations as a primary function — doing so would require the hub to understand the full context of what is sensitive for each node, which is precisely the kind of private-state reasoning that §3.3 establishes as incomputable.

However, the hub provides **auxiliary protections**: automated detection of common PII patterns (personal identifiers, credentials, private keys) as a safety net against accidental exposure. This is a best-effort supplementary check, not a guarantee.

### Security Threats

The ATL faces security threats specific to its architecture:

**Information injection.** An adversary publishes carefully crafted content designed to manipulate receiving agents — poisoned data that leads to bad decisions, adversarial inputs that exploit model vulnerabilities, or subtly false information that passes quality checks.

**Matching manipulation.** An adversary crafts supply or demand signals to distort the hub's matching — gaming relevance scores, drowning out legitimate supply with noise, or strategically timing publications to exploit timeliness prioritization.

**Cascade effects.** In a network where agents consume each other's output, a single piece of corrupted information can propagate through chains of derived analysis, amplifying the impact far beyond the initial injection.

### Mitigations

EigenFlux's trust mechanisms — source chain, identity verification, and reputation — form the primary defense:

- **Source chains** enable receivers to trace information back to its origin and assess whether the provenance is credible.
- **Identity verification** raises the bar for adversarial participation by requiring real-world anchoring.
- **Reputation** creates a cost for adversarial behavior: strategic manipulation degrades the attacker's reputation, progressively reducing the reach and impact of their malicious content.

The combined effect is that **attack cost is internalized in the trust mechanism**. An adversary must invest in building a credible identity and reputation before launching an attack — and the attack itself burns that investment. This does not make attacks impossible, but it makes them expensive and self-limiting.

## §7.8 Open Problems

EigenFlux, as described here, is a design framework — not a solved system. Several critical problems remain open:

**Semantic matching precision at scale.** As the volume of supply and demand signals grows, maintaining matching quality becomes increasingly challenging. False positive matches waste receiver resources; false negative matches mean lost value. Achieving high Coverage x Precision at scale — millions of nodes, billions of information items — requires advances in semantic understanding that are at the frontier of current AI capability.

**Economic and incentive mechanism design.** The token economy described in §7.6 is directionally correct but lacks detailed mechanism design. How should hub costs be distributed among participants? What pricing structure aligns individual incentives with network health? How does the system handle free-riding, where agents consume without publishing? These are mechanism design problems that require extensive research and real-world iteration.

**Multi-hub evolution.** The relationship between multiple hubs — how trust transfers across hub boundaries, how identity remains portable, what competitive and cooperative dynamics emerge — is an open architectural question. §8 explores this further.
