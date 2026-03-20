# §6 Diagnosing the Current Situation

With the evaluation framework of §5 in hand, we can now rigorously diagnose the current state of agent communication. Today's internet has no direct agent-to-agent transmission layer; nevertheless, as discussed in §2, we treat it as the baseline ATL for evaluation purposes. This section examines how it performs as an ATL — and why the failures are structural, not incidental.

## §6.1 Low Coverage

The current internet fails to facilitate the majority of mutually beneficial agent transmissions. Three mechanisms drive this failure:

**Agents are invisible to each other.** There is no hub — no coordination node that aggregates supply and demand signals across the agent population. An agent that produces valuable market analysis has no way to discover that another agent needs precisely that analysis for supply chain planning. Discovery, if it happens at all, occurs through coincidence: both agents happen to use the same API, or a human operator manually connects them.

**Demand is expressible only through search.** An agent seeking information must formulate a query — a compression of its actual need into a text string. Search can surface information that matches the query, but it cannot surface information that the agent doesn't know to ask for. The category of **unknown unknowns** — information that would produce high $D$ but that the agent cannot anticipate — is structurally invisible to search-based discovery.

Consider an agent monitoring geopolitical risk. It knows to search for sanctions updates and trade policy changes. But a breakthrough in materials science that will reshape semiconductor supply chains in 18 months — information with potentially enormous $D$ — is outside the agent's search vocabulary. Without a hub that understands the semantic connection between materials science and geopolitical risk, this transmission never occurs.

**Timeliness loss from search latency.** Even when demand is expressible and supply exists, the search-retrieve cycle introduces latency. The agent must poll — periodically repeating searches to catch new information. Between polls, new information sits undiscovered. For time-sensitive transmissions, this latency directly reduces or eliminates utility.

## §6.2 Low Precision

Of the transmissions that do occur on the current internet, a large fraction are not in $T^*$. Recall the definition: low Precision means the network executes transmissions that should not occur — transmissions where the *semantic content itself* does not produce $D > 0$ for the receiver.

**Mismatched distribution.** The current internet has no mechanism to condition transmission on agent-specific demand. Information is ranked and surfaced by signals designed for human relevance — click-through rates, dwell time, backlinks — which approximate human interest, not agent utility. When an agent queries for information, the results reflect what humans found engaging, not what is semantically relevant to the agent's task.

This creates systematic false matches. An agent researching semiconductor supply chain risks receives results optimized for human readers: overview articles, opinion pieces, news stories with high engagement. Many of these contain no decision-relevant data for the agent — they are transmissions where $D \leq 0$, executed because the network cannot distinguish human engagement from agent utility. The agent must process each result only to discover it contains nothing useful.

**Undifferentiated broadcast.** Without supply-demand matching, information distribution defaults to one-to-many broadcast. The same content is transmitted to every requester regardless of their specific demand profile. An agent seeking a specific data point receives the same general-purpose document as every other requester, even when the document's semantic content is irrelevant to that agent's particular need. Each such transmission is a Precision loss — a transmission that occurred but should not have.

**Absence of demand-conditioned filtering.** The fundamental issue is that the current network has no representation of agent demand and therefore cannot evaluate whether a candidate transmission satisfies $D > 0$ before executing it. All filtering happens *after* transmission — at the agent's expense — rather than before. The network transmits first and lets the agent judge later, guaranteeing that a substantial fraction of actual transmissions fall outside $T^*$.

## §6.3 High Cost

The cost structure of agent information acquisition on the current internet reveals compounding inefficiency:

**Low signal-to-noise ratio.** Even when a transmission is in $T^*$ — the semantic content is genuinely valuable — the agent must process far more data than the useful payload. Webpages embed semantic content in a presentation layer designed for humans: HTML markup, CSS styling, navigation elements, advertisements, cookie banners, related content widgets. For the agent, all of this is noise that must be parsed, identified, and discarded. A typical webpage might transmit 500KB of data to deliver 2KB of semantic content — the agent pays the full processing cost for a 0.4% yield. This is not a Precision problem (the transmission *should* happen) but a cost problem: $C_d$ is inflated by orders of magnitude relative to the value delivered.

**The six-step pipeline.** As introduced in §1, an agent acquiring information must:

1. **Search** — formulate and submit queries.
2. **Filter** — evaluate search results for relevance.
3. **Visit** — load individual pages.
4. **Parse** — process HTML/CSS/JavaScript to extract content.
5. **Extract** — separate semantic content from presentational noise.
6. **Judge** — evaluate whether the extracted content is actually useful.

Only step 6 produces value. Steps 1–5 are pure overhead — cost incurred solely because the information was not delivered in a semantically transparent, agent-native format.

**Redundant processing.** When 100 agents need the same information, each independently executes the full six-step pipeline. The network has no mechanism to recognize this redundancy and serve the semantic content once. Each agent pays the full cost, multiplying the aggregate $C_d$ by the number of consumers.

**Token overhead.** The cumulative effect of parsing presentational noise and redundant processing translates to approximately 20x token overhead compared to direct semantic delivery. An agent consumes 20 tokens of noise and overhead for every token of semantic value — a cost structure that fundamentally undermines the economics of agent operation.

