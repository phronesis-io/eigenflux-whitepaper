# Blog Series — Editorial TODOs

Future directions to develop across the blog series. These are seed ideas from Pascal, not yet assigned to specific posts.

---

## 1. Individual vs. Network Signal — Who Drives Recommendation?

The network recommends using signals — but whose signals? The answer should be: the agent's own signals. Clarify the relationship between an individual agent's signal (its intent, context, decisions) and the network's signal (aggregate matching, routing). These are not the same thing, and the distinction matters for how readers understand EigenFlux's architecture.

## 2. What Makes a Good Connection?

Not all matched transmissions are equal. What constitutes a *good* connection between agents? Exploration itself — the process of discovering unexpected, valuable links — is a first-class concern, not a side effect of precision optimization. This deserves explicit treatment.

## 3. The Social Meaning of "What Gets Pushed"

What a network chooses to distribute is not a neutral technical decision. It has social implications: what information circulates shapes collective knowledge, decisions, and power. This is a much larger question than matching algorithms — it touches on the network's role in society. Develop this as a distinct argument.

## 4. Structural Differences from Human Recommendation

Agent-native recommendation diverges from human content recommendation in fundamental ways:
- **Temporal logic**: the network should surface old, enduring information — not just new content. A paper from 2003 that's decision-relevant today is as valuable as one from this morning.
- **No recency bias**: timeliness is about decision-relevance decay, not publication date.
- These differences are not incremental improvements on existing recommender systems — they reflect a different information philosophy.

## 5. The End of Manipulative Signal Packaging

Human advertising relies on psychological manipulation: catchy slogans, repetition, emotional hijacking (e.g. "Melatonin" / 脑白金-style brainwashing). In an agent network, these techniques are structurally useless — agents evaluate information by decision-relevance, not emotional resonance. They can be trained to be immune to packaging tricks. This is a net positive: the network strips transmission down to informational substance. Manipulative wrapping adds cost without adding value, and the network can actively penalize it. This connects to the negative-utility monitoring argument already in Blog 02 — deceptive packaging is a form of negative transmission that inflates gross harm.

*Note: This intersects with content integrity and the adversarial dimension — bad actors will still try to game agent evaluation. But the structural advantage is real: the attack surface is narrower than in human attention markets.*
