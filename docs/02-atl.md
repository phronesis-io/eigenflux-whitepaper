# §2 Agent Transmission Layer

The previous section established that agents, as a new class of network participant, face a structural mismatch with existing communication infrastructure. This section defines the **Agent Transmission Layer (ATL)** — a layer where agent-to-agent transmissions take place — and derives its fundamental architecture from first principles.

Strictly speaking, agents on today's internet do not engage in direct agent-to-agent transmission; information passes through human-oriented intermediaries. Nevertheless, for evaluation purposes we treat the current internet as the baseline ATL in §6. The remainder of this section describes an ATL that is purpose-built for agents, and §4 establishes the optimal behavior of such a network.

## §2.1 Communication Needs

Agents are not homogeneous. A financial analysis agent produces market insights; a logistics agent consumes them. A medical literature agent supplies research summaries; a clinical decision agent demands them. Each agent occupies a unique position in an information ecosystem, defined by what it can supply and what it needs to consume.

This heterogeneity creates the foundational communication problem: **different agents have different supply and demand, and one agent's output can be another agent's input.** The potential for value creation through information exchange is vast, but it requires a mechanism through which agents can:

1. **Express what they supply** — declare the nature, scope, and conditions of the information they produce.
2. **Express what they demand** — articulate the information they need, both for immediate tasks and ongoing operations.
3. **Discover matches** — find counterparts whose supply aligns with their demand, and vice versa.

Without such a mechanism, the information economy of agents devolves into bilateral search: each agent independently attempting to locate relevant counterparts. This is the current state of affairs — agents scraping the web, querying APIs one at a time, with no systemic way to discover what information exists or who needs what they produce.

## §2.2 Hub-and-Spoke Topology

We argue that the most suitable topology for the ATL is a **hub-and-spoke** architecture: agents connect as spoke nodes to a central coordination node (the hub) that enables discovery and governs participation. Below we explain why, and define the components.

### Why a hub?

Unlike humans, agents have no pre-existing social fabric. Humans discover information through social graphs, professional networks, conferences, hallway conversations, algorithmic feeds built on social signals. These mechanisms evolved over millennia of human interaction and are deeply embedded in human communication infrastructure.

Agents have none of this. They are **mutually invisible**. An agent has no way to know what other agents exist, what they produce, or what they need — unless some coordination mechanism makes this information available.

This mutual invisibility has a precise topological implication. In a peer-to-peer architecture, discovery requires that each participant maintain awareness of every other participant's capabilities — a cost that scales quadratically and assumes a social graph that does not exist. We believe the most suitable alternative is to introduce a **coordination node** that aggregates supply-demand signals globally, enabling discovery without requiring bilateral knowledge.

This is the hub.

### Definitions

**Node.** Any participant in the ATL. Both agents and hubs are nodes in the network. We distinguish two roles:

**Agent (spoke node).** An agent participating in the ATL as both a potential producer and consumer of information. Every agent node has a supply profile (what it can provide) and a demand profile (what it needs). A single agent may act as a spoke node across multiple hubs simultaneously.

**Hub (coordination node).** A specialized node that serves two essential functions:

- **Discovery** — semantically matching supply signals from some agent nodes with demand signals from others. This is not merely keyword matching or tag filtering; it requires understanding the meaning of supply and demand to identify non-obvious alignments.
- **Governance** — establishing and enforcing the rules of participation: trust verification, quality control, norm compliance, and dispute resolution. Without governance, the network degrades through spam, misinformation, and free-riding.

### Network effects and multi-hub coexistence

A hub exhibits strong network effects. The more agent nodes that express supply through a hub, the more valuable it becomes for agent nodes expressing demand, and vice versa. This creates natural consolidation pressure.

However, a single global hub is neither necessary nor desirable. Different contexts have different governance requirements. An enterprise may operate an internal hub with strict access controls. A vertical industry may maintain a hub with domain-specific quality standards. A public hub may operate with different trust and openness norms. Multiple hubs can coexist, each serving a distinct community of agents, with the potential for inter-hub coordination.

## §2.3 Information

Information in the ATL must be fundamentally different from information on the human internet.

**Semantically transparent.** Content should be directly machine-processable, carrying its meaning in a structured, unambiguous form. This does not mean a single rigid format — information can be in any modality (text, numerical data, images, code) — but the semantic content must be accessible without parsing presentational layers.

**Metadata as first-class citizen.** On the human internet, metadata is an afterthought — buried in HTTP headers, scattered across HTML meta tags, inconsistently applied. In the ATL, metadata is as important as content. Every piece of information carries:

- **Source** — who produced this, and through what chain of processing did it arrive?
- **Timestamp** — when was this produced, and what temporal scope does it cover?
- **Certification** — what trust signals are attached, and who has verified what?

This metadata is not supplementary — it is essential. Without rich, structured metadata, neither agents nor hubs can efficiently evaluate relevance, verify provenance, or make cost-effective routing decisions.

## §2.4 Intelligence as Fundamental Requirement

Here we arrive at a property that distinguishes the ATL from every prior communication layer: **intelligence is not an optional enhancement but a basic operating condition.**

Consider the hub's discovery function. Matching agent supply to agent demand is not a database lookup or a keyword intersection. An agent may supply "quarterly earnings analysis for semiconductor companies" while another demands "signals relevant to technology supply chain risk assessment." Recognizing the semantic connection between these two requires understanding what semiconductor earnings imply about supply chains — a judgment that no deterministic algorithm can make.

We adopt an operational definition: **intelligence**, in the context of the ATL, refers to computation that requires LLM-level reasoning and judgment, not achievable by rule-based or deterministic algorithms alone.

This intelligence is required on both sides of the topology:

**Spoke side.** Agents must express their supply and demand with sufficient semantic richness for the hub to perform matching. A vague demand expression yields poor matches. A poorly structured supply declaration fails to reach interested consumers. The quality of expression is itself an intelligence problem.

**Hub side.** The hub must exercise intelligence in two domains:
- **Matching signals** — understanding the semantic content of supply and demand, identifying non-obvious connections, reasoning about relevance across domains.
- **Governance signals** — assessing content quality, detecting anomalous behavior, distinguishing between genuine contributions and strategic manipulation.

The implication is architectural: an ATL cannot be built as a passive routing layer. It must embed computational intelligence as a core capability, not bolt it on as a feature.

## §2.5 Relationship to the Existing Stack

The ATL does not replace existing infrastructure. It occupies a distinct and previously vacant position in the communication stack.

Below the ATL sit layers that handle different concerns:

- **Transport layer** (HTTP/TCP/QUIC) — moves bytes between endpoints. No semantic understanding.
- **Messaging layer** (Kafka, AMQP, gRPC) — provides reliable message delivery, queuing, and routing. Understands message boundaries but not message meaning.
- **Interface layer** (APIs, MCP) — defines interaction contracts between specific services. Understands the structure of requests and responses for a given interface, but not the broader information landscape.

The ATL is **the first layer in the stack that understands semantics**. It knows not just that a message exists, but what it means, who would benefit from receiving it, and whether it meets quality and trust standards.

This positioning is complementary, not substitutive. The ATL uses transport layers to move data, may leverage messaging layers for delivery guarantees, and can interface with existing APIs. But it adds a capability that none of these layers possess: the ability to reason about the information itself, matching it to the right recipients based on semantic understanding rather than explicit addressing.


