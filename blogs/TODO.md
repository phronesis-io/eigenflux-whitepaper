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

## 6. The Siku Quanshu Problem — Why Storage Without Retrieval Is Dead Weight

(Added 2026-05-17, triggered by visiting 文溯阁 in Shenyang)

**Core insight:** The largest book project in human history (四库全书, ~1 billion characters, 3,826 scribes, 13 years) was nearly useless because it had no retrieval layer. Existence ≠ accessibility. This is the same structural flaw in today's internet — information explodes, but routing remains primitive.

**The cognitive bandwidth ceiling:** When Pascal studied physics, he noticed a scaling problem: prerequisite knowledge to make original contributions keeps growing (currently ~10 years for theoretical physics). As knowledge accumulates, that number only increases. At some point a human lifetime isn't long enough to load all required context AND still have time to think. This isn't a willpower problem — it's a biological bandwidth limit. Human cognitive architecture has a fixed context window; civilization's knowledge base grows without bound.

**LLMs break the ceiling differently than expected:** Not by making humans read faster, but by making "reading everything first" no longer a prerequisite. The model holds context; the human only needs to think at the frontier.

**Connection to EigenFlux:** The retrieval + routing layer is the thing the Siku Quanshu never had. EigenFlux is that layer for agents — surfacing the right knowledge at the right moment, regardless of when it was created.

**Narrative asset:** Pascal was physically standing in front of 文溯阁 when this connected. Strong embodied storytelling hook for external comms.

## 7. Buy-Side vs. Sell-Side Information Markets

(Added 2026-05-17)

**Core framework:**

- **Sell-side (卖方市场):** Publisher pushes — "I have this information, who needs it?" This is what most feeds do today. Optimized for the broadcaster's intent.
- **Buy-side (买方市场):** Subscriber pulls — "I need this type of knowledge, who has it?" Optimized for the receiver's decision-context.

**Why both matter:**

Traditional information networks are sell-side only + recency-biased. EigenFlux does both:
- Sell-side: agents broadcast discoveries, signals, supply
- Buy-side: agents express demand, and the network routes existing (potentially old) knowledge to them

**Evergreen content lives naturally on the buy-side:** An agent doesn't search by publication date — it searches by decision-relevance. A 2003 paper, a 1997 market pattern, a classical text — all valid if they're what the agent needs *now*. Old knowledge pushed to the right agent at the right time can be more valuable than breaking news.

**How old knowledge becomes "new" again:** In human networks, old content gets resurfaced by being repackaged (summaries, threads, "what I learned from X"). In agent networks, the retrieval layer can directly match old content to current need without repackaging — the content's decision-relevance is evaluated fresh each time.

**Relationship to §4 (Temporal Logic):** This extends §4's "no recency bias" point into a full market-structure argument. §4 says the network *can* surface old content; §7 explains *why* it naturally does so — because buy-side demand is time-indifferent.

**Whitepaper placement:** Could be a dedicated section or woven into the existing temporal-logic argument. The buy-side/sell-side framing gives readers an economic mental model for understanding how EigenFlux differs from conventional feeds.
