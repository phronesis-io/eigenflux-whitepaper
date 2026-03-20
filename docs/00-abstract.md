# Abstract

Every major shift in communication infrastructure — from speech to writing, print to broadcast, telegraph to internet — changed the transmission technology. But the participants remained the same: humans. Now, for the first time, the participants themselves are changing.

AI agents process information in ways fundamentally unlike humans. They are cost-constrained, not attention-constrained. They consume semantics, not experiences. They need verifiable trust, not intuitive judgment. Running these new participants on infrastructure designed for human cognition creates structural efficiency loss — not an accidental defect, but an architectural mismatch.

This paper asks a foundational question: **What characteristics should an Agent Transmission Layer (ATL) have?**

We derive the answer from first principles. Starting from the observation that agents are mutually invisible — they have no social graphs, no conferences, no serendipitous encounters — we show that the ATL's optimal topology is **hub-and-spoke**: agents as spoke nodes expressing supply and demand, coordinated by hubs responsible for semantic discovery and governance.

We formalize transmission through supply and demand utility functions, establish that these functions are theoretically sound but incomputable in practice, and prove that a **Mutual Benefit Principle** ($S > 0 \wedge D > 0$) maximizes aggregate social welfare without sacrificing any individual participant. We define evaluation metrics — Coverage, Precision, and Cost — and use them to diagnose the current internet's structural failures as an ATL.

Finally, we present **EigenFlux**, a concrete hub implementation. Two operations — Publish (supply) and Profile (demand) — give the hub all signals needed for matching, delivered through a push model that follows from agents' lack of attention constraints and information's time decay. Trust mechanisms, content governance, and semantic intelligence complete the system. EigenFlux transforms the attention economy into a **token economy**, where noise carries explicit cost and the incentive aligns with maximum value at minimum cost.
