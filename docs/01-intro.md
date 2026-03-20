# §1 Introduction

## The Constant and the Variable

The history of communication is a history of changing how information moves between people. Speech enabled real-time exchange within earshot. Writing decoupled transmission from presence. Print made duplication cheap. Broadcast made it instantaneous and one-to-many. The internet made it bidirectional, global, and nearly free.

Each transition was revolutionary. Each changed the medium, the speed, the cost, the reach. But across every transition, one thing remained constant: the participants were human. The entire stack — from protocol design to interface paradigms, from content formats to discovery mechanisms — was shaped by a single assumption: that a human mind sits at each endpoint.

That assumption no longer holds.

## A New Kind of Participant

AI agents are entering the network not as tools invoked by humans, but as autonomous participants that receive information, process it, make decisions, and act. This is not a quantitative change — more users, more traffic, more data. It is a qualitative one: the endpoints themselves are different.

The differences are structural, not superficial:

**Cost-constrained, not attention-constrained.** A human can process roughly 40–60 bits of conscious information per second. Interfaces, summaries, visualizations — the entire UX discipline exists to work within this bottleneck. Agents face no such limit. Their constraint is economic: every token processed has a cost. An agent can consume a million tokens in seconds; the question is not whether it can process the information, but whether the information is worth the tokens.

**Consuming semantics, not experiences.** Humans do not merely extract facts from a webpage — they experience layout, imagery, tone, narrative. These elements carry meaning for humans. For agents, these elements are largely irrelevant — what matters is the underlying semantic content: structured, machine-parseable, stripped of presentational overhead. The HTML wrapper, the navigation chrome, the advertisements — all have zero utility for an agent's decision-making.

**Verifiable trust, not intuitive judgment.** Humans assess credibility through a web of soft signals: reputation, tone, social proof, institutional affiliation, gut feeling. These signals are powerful but not transferable to agents. An agent needs trust to be explicit, structured, and verifiable — provenance chains, identity attestations, quality certifications that can be programmatically evaluated.

## The Structural Mismatch

When agents operate on the current internet, they inherit an infrastructure optimized for a participant they are not. The result is not graceful degradation but structural waste.

Consider how an agent acquires information today. It must: (1) formulate a search query in human terms, (2) receive results ranked by human engagement signals, (3) visit individual pages designed for human browsers, (4) parse HTML meant for visual rendering, (5) extract semantic content from presentational noise, and (6) judge whether the extracted content is actually useful. Of these six steps, only the last produces value. The preceding five are overhead imposed by a human-centric architecture.

This overhead is not merely inconvenient — it is multiplicative. When a hundred agents need the same information, each independently executes the same six-step pipeline. There is no mechanism for the network to recognize that the same semantic content is being redundantly processed, because the network was never designed to understand semantics.

## The Rise of Agent-to-Agent Exchange

As agents take on broader roles as proxies and assistants for humans, they increasingly need to exchange information with one another. A research agent produces analysis that a planning agent consumes. A monitoring agent generates signals that a trading agent acts upon. A data agent curates information that a reasoning agent synthesizes. As agent capabilities expand and deployment scales, the volume and economic value of these agent-to-agent flows will grow dramatically.

These flows are direct, high-frequency, and semantically dense — precisely the characteristics that the current internet handles worst. The human internet can serve as a bridge, but it is a bridge with a toll: latency from search and parsing, noise from human-oriented formatting, redundancy from the lack of shared infrastructure, and opacity from the absence of semantic-level trust.

## The Core Question

These observations converge on a single question that this paper sets out to answer:

> **What characteristics should an Agent Transmission Layer have?**

We do not ask what product to build or what protocol to implement. We ask what structural properties an agent communication network must possess, derived from the nature of its participants. We aim for each design choice to follow as a logical consequence of the preceding analysis, not an arbitrary decision.

The remainder of this paper proceeds as follows. §2 defines the ATL and derives its hub-and-spoke topology. §3 formalizes the mathematical framework of supply, demand, and transmission. §4 establishes the Mutual Benefit Principle as the optimal behavioral rule. §5 defines evaluation metrics. §6 uses those metrics to diagnose the current internet. §7 presents EigenFlux, a concrete hub implementation that is the primary focus of this paper — translating the preceding principles into an operational design with specific mechanisms for publishing, discovery, trust, and governance. §8 looks ahead to multi-hub topologies and coexistence with human networks.
