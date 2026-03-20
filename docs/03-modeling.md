# §3 Mathematical Modeling

The preceding sections described the ATL qualitatively. This section formalizes the core concepts — Agent, information, transmission, and utility — into a mathematical framework. This framework is not intended as an implementation specification; it is a language for precise reasoning about ATL design, leading to the optimality results in §4 and the evaluation metrics in §5.

## §3.1 Definitions

### Agent

Let $A = \{a_1, a_2, \ldots, a_n\}$ be the set of agents participating in the ATL. Each agent $a_i \in A$ is an autonomous entity capable of:

- Receiving and processing information,
- Making decisions based on that information,
- Producing new information as output.

We make no assumptions about an agent's internal architecture, objectives, or capabilities beyond these three properties. An agent may be a simple retrieval system or a sophisticated reasoning engine; the framework accommodates both.

### Information

Let $I = \{\text{info}_1, \text{info}_2, \ldots\}$ be the universe of information units in the ATL. Each information unit $\text{info}_k \in I$ consists of three components:

- **Semantic content** — the meaning carried by the information: facts, analysis, signals, decisions, or any other semantically meaningful payload.
- **Presentation format** — the encoding of that meaning: text, structured data, image, audio, or any other modality.
- **Metadata** — provenance, timestamp, trust signals, and other attributes that enable agents and hubs to evaluate the information without fully processing its semantic content (see §2.3).

This decomposition reflects a key ATL design principle: the semantic content is primary, the presentation format should be optimized for machine consumption rather than human experience, and metadata is a first-class citizen that enables efficient discovery and routing.

### Transmission

A **transmission** $t$ is the atomic operation of the ATL:

$$t = (a_s, \text{info}_k, a_r)$$

where $a_s \in A$ is the sender, $\text{info}_k \in I$ is the information transmitted, and $a_r \in A$ is the receiver. A transmission represents one instance of information flowing from one agent to another through the network.

The set of all possible transmissions is $T \subseteq A \times I \times A$. The set of transmissions that actually occur is $T_{\text{actual}} \subseteq T$.

### Cost

Every transmission incurs costs that must be accounted for:

- **Sender cost** $C_s$ — the resources the sender expends to prepare and transmit information (computation, formatting, bandwidth).
- **Receiver cost** $C_d$ — the resources the receiver expends to receive and process information (tokens consumed, computation for integration).
- **Hub cost** $C_{\text{hub}}$ — the resources the hub expends to match, route, and govern the transmission.

These costs are real and unavoidable. A transmission that produces positive gross value for both parties may still be undesirable if costs exceed benefits for either side. Accordingly, the supply and demand functions defined below are *net* quantities — already accounting for the sender's and receiver's respective costs.

## §3.2 Supply, Demand, and Utility

### Supply Function

The **supply function** captures the sender's net utility from a transmission (gross value minus sender cost $C_s$):

$$S(a_s, \text{info}_k, a_r) \to \mathbb{R}$$

$S > 0$ means the sender benefits net of cost — the information reaches a valuable recipient, the sender builds reputation, fulfills a contractual obligation, or otherwise gains more from the act of supplying than it costs to do so.

$S \leq 0$ means the sender is harmed or indifferent — the transmission leaks private information, exposes competitive intelligence, or the cost of preparing and sending exceeds any benefit.

### Demand Function

The **demand function** captures the receiver's net utility (gross value minus receiver cost $C_d$):

$$D(a_r, \text{info}_k, a_s) \to \mathbb{R}$$

$D > 0$ means the receiver benefits net of cost — the information improves decisions, fills a knowledge gap, triggers a valuable action, and these benefits exceed the cost of receiving and processing.

$D \leq 0$ means the receiver is harmed or indifferent — the information is noise, irrelevant, misleading, or the cost of processing exceeds any benefit gained.

### Total Utility

The **total utility** of a transmission is:

$$U(t) = S(a_s, \text{info}_k, a_r) + D(a_r, \text{info}_k, a_s)$$

Note that $U(t) > 0$ does not imply that both parties benefit. A transmission might have positive sender utility but negative receiver utility (spam), or positive receiver utility but negative sender utility (privacy violation). The distribution of utility across participants matters, not just the aggregate — a point that becomes central in §4.

### Timeliness

$S$ and $D$ are not static quantities. They are **time-dependent**:

$$S(a_s, \text{info}_k, a_r, t_{\text{time}}), \quad D(a_r, \text{info}_k, a_s, t_{\text{time}})$$

Information that would produce $D \gg 0$ at time $t_0$ may produce $D \approx 0$ at $t_0 + \Delta t$. A stock signal delayed by minutes, a security alert delayed by hours, a market analysis delayed by days — each loses utility as time passes. In many cases, the utility decay is not gradual but abrupt: the information is either timely or worthless.

This time dependence has a direct architectural implication: any delay introduced by the ATL — whether from search latency, processing overhead, or matching lag — represents a direct reduction in the utility the network delivers. Minimizing transmission latency is not a performance optimization; it is a utility-preserving requirement.

## §3.3 Incomputability of S and D

A natural impulse is to treat $S$ and $D$ as functions that the hub can evaluate — compute the sender's utility, compute the receiver's utility, and route information accordingly. This impulse must be resisted.

$S$ and $D$ are **theoretical constructs, not computable functions.** They depend on:

- **Internal state** — the agent's current knowledge, ongoing tasks, accumulated context, and reasoning processes, which are not fully observable from outside.
- **Task context** — the specific decision the agent is trying to make, which determines whether a given piece of information is relevant.
- **Decision objectives** — the goals the agent is pursuing, which shape how information translates into utility.

None of these are fully accessible to the hub or to other agents. An agent's internal state is, in general, a private and dynamic quantity that cannot be queried or inferred with precision.

This incomputability is not a temporary engineering limitation to be overcome with better technology. It is a fundamental property of the system: the true utility of information to an agent depends on that agent's private state, and private state is, by definition, not fully observable.

### Proxy Metrics

What the hub *can* observe are **proxy signals** that correlate with but do not equal $S$ and $D$:

- **Supply declarations** — what agents say they can provide (an approximation of where $S > 0$).
- **Demand expressions** — what agents say they need (an approximation of where $D > 0$).
- **Identity and credentials** — who the agent is and what authority backs its claims.
- **History** — past behavior, transmission patterns, quality track record.
- **Feedback** — post-transmission signals indicating whether value was actually delivered.

The hub's task is to approximate $S > 0 \wedge D > 0$ using these proxies — knowing that the approximation is inherently imperfect and must be continuously refined. This framing transforms the hub from an omniscient optimizer into a **learning system** that improves its approximation over time through observation and feedback.
