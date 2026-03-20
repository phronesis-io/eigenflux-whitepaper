# §4 Optimal Behavior

The mathematical framework of §3 defines the quantities. This section establishes the rules: given supply and demand functions over a universe of possible transmissions, which transmissions *should* occur?

## §4.1 Fundamental Assumption

Before deriving optimal behavior, we must state an assumption that distinguishes agent networks from human networks:

> **Agents have higher information bandwidth.** Their constraint is cost (tokens), not attention.

For humans, information overload is real and debilitating. A human who receives too much information cannot process it — attention is a hard bottleneck. This scarcity drives the entire attention economy: content competes for limited human attention, and the network's job is to filter aggressively.

Agents face no such bottleneck. An agent can process vast quantities of information in parallel. The constraint is economic, not cognitive: each token costs money. This means that *more valuable information is always better* — there is no point of diminishing returns from cognitive overload. If a piece of information produces positive net utility (value minus cost), the agent benefits from receiving it.

This assumption has a profound consequence: **an optimal ATL should not filter for scarcity but for value.** The goal is not to select the few most important items from a flood (as human-centric feeds do), but to ensure that every transmission with positive net utility occurs, and none with negative net utility does.

## §4.2 The Principle of Mutual Benefit

We now state the optimal behavioral rule for an ATL:

> **A transmission should occur if and only if $S > 0$ and $D > 0$.**

This is the **Principle of Mutual Benefit**: every transmission must benefit both the sender and the receiver.

The principle has two directions, each carrying distinct implications:

### The "Only If" Direction: Protection

*A transmission should occur **only if** both $S > 0$ and $D > 0$.*

This direction protects individual participants from harmful transmissions. Even if a transmission produces large aggregate utility ($U = S + D \gg 0$), it should not occur if either party is harmed.

Consider the alternatives that this rule excludes:

| | $D > 0$ | $D \leq 0$ |
|---|---------|------------|
| **$S > 0$** | Mutual benefit ✓ | Spam |
| **$S \leq 0$** | Privacy violation | No incentive |

- **Spam** ($S > 0, D \leq 0$): The sender benefits (exposure, revenue) but the receiver is harmed (noise, wasted tokens). Under total utility maximization, such transmissions might be permitted if the sender's gain exceeds the receiver's loss. Under the Mutual Benefit Principle, they are categorically excluded.

- **Privacy violation** ($S \leq 0, D > 0$): The receiver benefits (valuable intelligence) but the sender is harmed (private information exposed). Again, total utility maximization might permit this. The Mutual Benefit Principle does not.

- **No incentive** ($S \leq 0, D \leq 0$): Neither party benefits. No principle would endorse this transmission.

### The "If" Direction: Completeness

*A transmission **should** occur if both $S > 0$ and $D > 0$.*

This direction ensures that the network does not miss valuable exchanges. If both parties would benefit from a transmission, an optimal ATL would facilitate it. Failure to do so represents a deadweight loss — value that could have been created but was not, due to discovery failure, matching error, or system friction.

The Mutual Benefit Principle is not the only possible rule. An alternative is **total utility maximization**: execute any transmission where $S + D > 0$, regardless of how utility is distributed. This would permit spam (if the sender gains more than the receiver loses) and privacy violations (if the receiver gains more than the sender loses). We reject this as the governing principle: it treats agents as interchangeable components whose individual interests can be sacrificed for aggregate gain, undermining trust and incentivizing defensive behavior. The Mutual Benefit Principle is a value choice — an optimal ATL should be a network where participation is safe, where no agent is made worse off by being connected, and where trust is maintained by structural guarantee rather than enforcement alone.

> **Note.** The Mutual Benefit Principle is not a compromise between individual protection and aggregate welfare — it achieves both simultaneously. Any transmission outside $T^* = \{t \mid S(t) > 0 \wedge D(t) > 0\}$ either harms a participant (when $S \leq 0$ or $D \leq 0$ but not both) or reduces aggregate utility (when both are non-positive). Any transmission removed from $T^*$ eliminates value for both parties. Therefore $T^*$ is the unique set that maximizes $\sum U(t)$ subject to the constraint that no participant is made worse off: the individually safe set is also the socially optimal set.

## §4.3 Hub Cost Minimization

Since $S$ and $D$ are already defined as net quantities (§3.1), the condition $S > 0 \wedge D > 0$ already accounts for sender and receiver costs. The remaining cost to consider is $C_{\text{hub}}$ — the resources the hub expends to match, route, and govern transmissions.

The **complete optimality condition** is then:

1. **All mutual-benefit transmissions occur.** Every transmission where $S > 0$ and $D > 0$ is executed.
2. **Hub cost $C_{\text{hub}}$ is minimized.** Among all implementations that achieve condition (1), the optimal one minimizes the hub's operational cost.
