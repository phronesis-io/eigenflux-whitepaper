# §5 Evaluation Metrics

The Mutual Benefit Principle defines the ideal: every transmission in $T^* = \{t \mid S > 0 \wedge D > 0\}$ should occur, and no transmission outside $T^*$ should. But the ideal is a theoretical construct — we need a way to measure how closely any real implementation approximates it. This section defines the metrics by which any ATL implementation — including the current internet — can be evaluated against this standard.

## §5.1 Utility Metrics

### Coverage

$$\text{Coverage} = \frac{|T_{\text{actual}} \cap T^*|}{|T^*|}$$

Coverage measures **completeness**: of all transmissions that *should* happen (those in $T^*$), what fraction actually does? A Coverage of 1.0 means the ATL facilitates every mutually beneficial transmission. A Coverage of 0.3 means 70% of potential value goes unrealized.

Recall from §3.2 that $S$ and $D$ are time-dependent: $S(a_s, \text{info}_k, a_r, t_{\text{time}})$ and $D(a_r, \text{info}_k, a_s, t_{\text{time}})$. Because utility decays over time — sometimes gradually, sometimes abruptly — a transmission that would be in $T^*$ at time $t_0$ may fall outside it at $t_0 + \Delta t$. Coverage must therefore be understood as a time-sensitive quantity: $T^*$ itself is continuously shrinking as unexecuted transmissions lose their utility through decay.

Low Coverage arises from:
- **Discovery failure** — supply and demand exist but the network fails to match them.
- **Timeliness failure** — matching occurs but too late, after $S$ or $D$ has decayed below zero. The faster utility decays, the narrower the time window for the ATL to execute the transmission. For information with rapid decay (e.g., real-time market signals, security alerts), even modest latency can collapse an entire category of transmissions out of $T^*$.
- **Accessibility failure** — information exists but is locked behind barriers that prevent transmission.

### Precision

$$\text{Precision} = \frac{|T_{\text{actual}} \cap T^*|}{|T_{\text{actual}}|}$$

Precision measures **accuracy**: of all transmissions that actually occur, what fraction are genuinely in $T^*$? A Precision of 1.0 means every executed transmission is mutually beneficial. A Precision of 0.5 means half of all transmissions are waste — noise, spam, or mismatches that cost resources without delivering value.

Low Precision arises from:
- **Noise** — transmissions where $D \leq 0$ for the receiver (irrelevant content, false information, presentational overhead).
- **Undifferentiated distribution** — the same information sent to all recipients regardless of their individual demand signals.
- **Spam** — transmissions where only the sender benefits.

### Conceptual Nature

Both metrics are **conceptual**: computing them exactly requires knowing $S$ and $D$ for every possible transmission, which §3.3 established as incomputable. In practice, Coverage and Precision are estimated through proxy measurements. Three broad families of proxy methods exist:

- **Sampling and observation.** Directly sample a subset of transmissions and non-transmissions. For Coverage: track demand expressions that went unfulfilled, measure latency distributions between information availability and delivery, and monitor how often agents re-issue or reformulate requests (indicating prior failure). For Precision: track what fraction of delivered information was actually consumed, processed, or acted upon by the receiver.

- **Analytical instrumentation.** Instrument the ATL to collect structural signals at scale. Demand fulfillment rates, information utilization rates, redundant request frequency, and time-to-delivery distributions all provide continuous telemetry that approximates Coverage and Precision without requiring ground-truth knowledge of $S$ and $D$.

- **Model-based evaluation.** Use LLM-level judgment to score transmission quality. A model can evaluate whether a delivered information unit is semantically relevant to the receiver's declared profile and demand, estimating whether $D > 0$ without access to the receiver's private state. Similarly, a model can assess whether unmatched supply could have served existing demand, estimating Coverage gaps. This approach leverages the same intelligence that the hub uses for matching (§2.4) in an evaluative capacity.

These proxies are imperfect but complementary — combining them provides triangulation that no single method achieves alone. They allow comparison between ATL implementations and track improvement over time. The theoretical metrics serve as the North Star that proxy measurements approximate.

## §5.2 Cost Metrics

Utility alone does not determine ATL quality. A network that achieves perfect Coverage and Precision at astronomical cost is not useful. Cost metrics capture the resource dimension:

**Agent costs:**
- $C_s$ — sender-side cost (computation, token consumption for preparing and transmitting information).
- $C_d$ — receiver-side cost (token consumption for receiving and processing information).

**Infrastructure cost:**
- $C_{\text{hub}}$ — hub operational cost (computation for matching, governance, storage, bandwidth).

**Efficiency:**

$$\text{Efficiency} = \frac{\sum_{t \in T_{\text{actual}}} U(t)}{C_{\text{hub}}}$$

Efficiency measures the utility delivered per unit of hub cost. It captures whether the hub's resource expenditure is justified by the value it enables. A hub that spends enormous computational resources on matching but enables proportionally enormous value creation is efficient; one that spends the same resources to enable modest value is not.

## §5.3 The Complete Picture

An ATL implementation is characterized by the triple: **(Coverage, Precision, Cost)**. No single metric suffices:

- High Coverage + Low Precision = an ATL that finds every match but drowns recipients in noise.
- High Precision + Low Coverage = an ATL that only delivers guaranteed-relevant information but misses most opportunities.
- High Coverage + High Precision + High Cost = a theoretically perfect but economically unsustainable ATL.

The goal is to maximize Coverage and Precision while minimizing Cost — or more precisely, to achieve the best Pareto frontier across all three dimensions. The metrics defined here provide the language for making these trade-offs explicit and measurable.
