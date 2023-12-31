
section propositional

variables P Q R : Prop


------------------------------------------------
-- Proposições de dupla negaço:
------------------------------------------------

theorem doubleneg_intro :
  P → ¬¬P  :=
begin
  intro p,
  intro h,
  apply h,
  exact p,

end

theorem doubleneg_elim :
  ¬¬P → P  :=
begin
  intro v,
  by_cases x : P,
  exact x,
  have boom : false := v x,
  exfalso,
  exact boom,
  
end

theorem doubleneg_law :
  ¬¬P ↔ P  :=
begin
  split,
  exact doubleneg_elim P,
  exact doubleneg_intro P,

end

------------------------------------------------
-- Comutatividade dos ∨,∧:
------------------------------------------------

theorem disj_comm :
  (P ∨ Q) → (Q ∨ P)  :=
begin
  intro h,
  cases h with hp hq,
  right,
  exact hp,
  left,
  exact hq,
  
end

theorem conj_comm :
  (P ∧ Q) → (Q ∧ P)  :=
begin
  intro h,
  cases h with hp hq,
  split,
  exact hq,
  exact hp,

end


------------------------------------------------
-- Proposições de interdefinabilidade dos →,∨:
------------------------------------------------

theorem impl_as_disj_converse :
  (¬P ∨ Q) → (P → Q)  :=
begin
  intros h p,
  cases h with h¬p hq,
  exfalso,
  exact h(p),
  exact h,

end

theorem disj_as_impl :
  (P ∨ Q) → (¬P → Q)  :=
begin
  intros hpq h¬p,
  cases hpq with hp hq,
  contradiction,
  exact hq,

end


------------------------------------------------
-- Proposições de contraposição:
------------------------------------------------

theorem impl_as_contrapositive :
  (P → Q) → (¬Q → ¬P)  :=
begin
  intros hpq hNq,
  intro p,
  apply hNq,
  exact hpq(p),

end

theorem impl_as_contrapositive_converse :
  (¬Q → ¬P) → (P → Q)  :=
begin
  intros hqp p,
  by_contra hboom,
  have hf := hqp(hboom),
  exact hf(p),

end

theorem contrapositive_law :
  (P → Q) ↔ (¬Q → ¬P)  :=
begin
  split,
  exact impl_as_contrapositive P Q,
  exact impl_as_contrapositive_converse P Q,

end


------------------------------------------------
-- A irrefutabilidade do LEM:
------------------------------------------------

theorem lem_irrefutable :
  ¬¬(P∨¬P)  :=
begin
  intro hp,
  apply hp,
  right,
  intro p,
  apply hp,
  left,
  exact p,

end


------------------------------------------------
-- A lei de Peirce
------------------------------------------------

theorem peirce_law_weak :
  ((P → Q) → P) → ¬¬P  :=
begin
  intro hpqp,
  intro hp,
  apply hp,
  apply hpqp,
  intro p,
  exfalso,
  apply hp,
  exact p,

end


------------------------------------------------
-- Proposições de interdefinabilidade dos ∨,∧:
------------------------------------------------

theorem disj_as_negconj :
  P∨Q → ¬(¬P∧¬Q)  :=
begin
  intro hpq,
  intro hNpNq,
  cases hNpNq with hNp hNq,
  cases hpq with hp hq,
  apply hNp,
  exact hp,
  apply hNq,
  exact hq,

end

theorem conj_as_negdisj :
  P∧Q → ¬(¬P∨¬Q)  :=
begin
  intro hpq,
  intro hNpNq,
  cases hNpNq with hNp hNq,
  apply hNp,
  exact hpq.1,
  apply hNq,
  exact hpq.2,

end


------------------------------------------------
-- As leis de De Morgan para ∨,∧:
------------------------------------------------

theorem demorgan_disj :
  ¬(P∨Q) → (¬P ∧ ¬Q)  :=
begin
  intro hNpq,
  split,
  intro p,
  apply hNpq,
  left,
  exact p,
  intro q,
  apply hNpq,
  right,
  exact q,
  
end

theorem demorgan_disj_converse :
  (¬P ∧ ¬Q) → ¬(P∨Q)  :=
begin
  intro h,
  cases h with hp hq,
  intro hpq,
  apply hp,
  cases hpq,
  exact hpq,
  contradiction,

end

theorem demorgan_conj :
  ¬(P∧Q) → (¬Q ∨ ¬P)  :=
begin
  intro h,
  by_cases q : Q,
  right,
  intro p,
  apply h,
  split,
  exact p,
  exact q,
  left,
  exact q,

end

theorem demorgan_conj_converse :
  (¬Q ∨ ¬P) → ¬(P∧Q)  :=
begin
  intro h,
  intro f,
  cases f with fp fq,
  cases h with hq hp,
  apply hq,
  exact fq,
  apply hp,
  exact fp,

end

theorem demorgan_conj_law :
  ¬(P∧Q) ↔ (¬Q ∨ ¬P)  :=
begin
  split,
  exact demorgan_conj P Q,
  exact demorgan_conj_converse P Q,

end

theorem demorgan_disj_law :
  ¬(P∨Q) ↔ (¬P ∧ ¬Q)  :=
begin
  split,
  exact demorgan_disj P Q,
  exact demorgan_disj_converse P Q,
  
end

------------------------------------------------
-- Proposições de distributividade dos ∨,∧:
------------------------------------------------

theorem distr_conj_disj :
  P∧(Q∨R) → (P∧Q)∨(P∧R)  :=
begin
  intro h,
  cases h with p qr,
  cases qr with q r,
  left,
  split,
  exact p,
  exact q,
  right,
  split,
  exact p,
  exact r,

end

theorem distr_conj_disj_converse :
  (P∧Q)∨(P∧R) → P∧(Q∨R)  :=
begin
  intro h,
  cases h with h1 h2,
  cases h1 with p q,
  split,
  exact p,
  left,
  exact q,
  cases h2 with p r,
  split,
  exact p,
  right,
  exact r,

end

theorem distr_disj_conj :
  P∨(Q∧R) → (P∨Q)∧(P∨R)  :=
begin
  intro h,
  cases h with h1 h2,
  split,
  left,
  exact h1,
  left,
  exact h1,
  cases h2 with q r,
  split,
  right,
  exact q,
  right,
  exact r,

end

theorem distr_disj_conj_converse :
  (P∨Q)∧(P∨R) → P∨(Q∧R)  :=
begin
  intro h,
  cases h with pq pr,
  cases pq with p q,
  cases pr with p r,
  left,
  exact p,
  left,
  exact p,
  cases pr with p r,
  left,
  exact p,
  right,
  split,
  exact q,
  exact r,

end


------------------------------------------------
-- Currificação
------------------------------------------------

theorem curry_prop :
  ((P∧Q)→R) → (P→(Q→R))  :=
begin
  intro h,
  intros p q,
  apply h,
  split,
  exact p,
  exact q,

end

theorem uncurry_prop :
  (P→(Q→R)) → ((P∧Q)→R)  :=
begin
  intro h,
  intro f,
  cases f with p q,
  apply h,
  exact p,
  exact q,

end


------------------------------------------------
-- Reflexividade da →:
------------------------------------------------

theorem impl_refl :
  P → P  :=
begin
  intro p,
  exact p,
  
end

------------------------------------------------
-- Weakening and contraction:
------------------------------------------------

theorem weaken_disj_right :
  P → (P∨Q)  :=
begin
  intro p,
  left,
  exact p,

end

theorem weaken_disj_left :
  Q → (P∨Q)  :=
begin
  intro q,
  right,
  exact q,

end

theorem weaken_conj_right :
  (P∧Q) → P  :=
begin
  intro h,
  cases h with p q,
  exact p,

end

theorem weaken_conj_left :
  (P∧Q) → Q  :=
begin
  intro h,
  cases h with p q,
  exact q,
end

theorem conj_idempot :
  (P∧P) ↔ P :=
begin
  split,
  intro h,
  cases h with p p,
  exact p,
  intro p,
  split,
  exact p,
  exact p,

end

theorem disj_idempot :
  (P∨P) ↔ P  :=
begin
  split,
  intro h,
  cases h with hp p,
  exact hp,
  exact p,
  intro p,
  left,
  exact p,

end

end propositional


----------------------------------------------------------------


section predicate

variable U : Type
variables P Q : U -> Prop


------------------------------------------------
-- As leis de De Morgan para ∃,∀:
------------------------------------------------

theorem demorgan_exists :
  ¬(∃x, P x) → (∀x, ¬P x)  :=
begin
  intro h,
  intro x,
  intro f,
  apply h,
  existsi x,
  exact f,

end

theorem demorgan_exists_converse :
  (∀x, ¬P x) → ¬(∃x, P x)  :=
begin
  intro h,
  intro h1,
  cases h1 with x hx,
  apply h(x),
  exact hx,

end

theorem demorgan_forall :
  ¬(∀x, P x) → (∃x, ¬P x)  :=
begin
  intro h,
  by_contra hc,
  apply  h,
  intro x,
  by_contra hc1,
  apply hc,
  existsi x,
  exact hc1,
  
end

theorem demorgan_forall_converse :
  (∃x, ¬P x) → ¬(∀x, P x)  :=
begin
  intro h,
  intro h1,
  cases h with x hx,
  apply hx,
  have h3 := h1(x),
  exact h3,

end

theorem demorgan_forall_law :
  ¬(∀x, P x) ↔ (∃x, ¬P x)  :=
begin
  split,
  exact demorgan_forall U P,
  exact demorgan_forall_converse U P,

end

theorem demorgan_exists_law :
  ¬(∃x, P x) ↔ (∀x, ¬P x)  :=
begin
  split,
  intro h,
  intro x,
  intro px,
  apply h,
  existsi x,
  exact px,
  intro h,
  intro h1,
  cases h1 with x hx,
  have h1x := h(x),
  apply h1x,
  exact hx,


end


------------------------------------------------
-- Proposições de interdefinabilidade dos ∃,∀:
------------------------------------------------

theorem exists_as_neg_forall :
  (∃x, P x) → ¬(∀x, ¬P x)  :=
begin
  intro h,
  cases h with x hx,
  intro f,
  have f1 := f(x),
  contradiction,
  
end

theorem forall_as_neg_exists :
  (∀x, P x) → ¬(∃x, ¬P x)  :=
begin

  intro h,
  intro h1,
  cases h1 with x hx,
  apply hx,
  exact h(x),

end

theorem forall_as_neg_exists_converse :
  ¬(∃x, ¬P x) → (∀x, P x)  :=
begin
  intro h,
  intro x,
  by_contra hc,
  apply h,
  existsi x,
  exact hc,

end

theorem exists_as_neg_forall_converse :
  ¬(∀x, ¬P x) → (∃x, P x)  :=
begin
  intro h,
  by_contra hc,
  apply h,
  intro x,
  intro px,
  apply hc,
  existsi x,
  exact px,

end

theorem forall_as_neg_exists_law :
  (∀x, P x) ↔ ¬(∃x, ¬P x)  :=
begin
  split,
  exact forall_as_neg_exists U P,
  exact forall_as_neg_exists_converse U P,

end

theorem exists_as_neg_forall_law :
  (∃x, P x) ↔ ¬(∀x, ¬P x)  :=
begin
  split,
  exact exists_as_neg_forall U P,
  exact exists_as_neg_forall_converse U P,

end


------------------------------------------------
--  Proposições de distributividade de quantificadores:
------------------------------------------------

theorem exists_conj_as_conj_exists :
  (∃x, P x ∧ Q x) → (∃x, P x) ∧ (∃x, Q x)  :=
begin
  intro h,
  cases h with x hx,
  cases hx with px qx,
  split,
  existsi x,
  exact px,
  existsi x,
  exact qx,

end

theorem exists_disj_as_disj_exists :
  (∃x, P x ∨ Q x) → (∃x, P x) ∨ (∃x, Q x)  :=
begin
  intro h,
  cases h with x hx,
  cases hx with px qx,
  left,
  existsi x,
  exact px,
  right,
  existsi x,
  exact qx,

end

theorem exists_disj_as_disj_exists_converse :
  (∃x, P x) ∨ (∃x, Q x) → (∃x, P x ∨ Q x)  :=
begin
  intro h,
  cases h with h1 h2,
  cases h1 with x px,
  existsi x,
  left,
  exact px,
  cases h2 with x qx,
  existsi x,
  right,
  exact qx,

end

theorem forall_conj_as_conj_forall :
  (∀x, P x ∧ Q x) → (∀x, P x) ∧ (∀x, Q x)  :=
begin
  intro h,
  split,
  intro x,
  have hx := h(x),
  cases hx with px qx,
  exact px,
  intro x,
  have hx := h(x),
  cases hx with px qx,
  exact qx,

end

theorem forall_conj_as_conj_forall_converse :
  (∀x, P x) ∧ (∀x, Q x) → (∀x, P x ∧ Q x)  :=
begin
  intro h,
  cases h with hp hq,
  intro x,
  have px := hp(x),
  have qx := hq(x),
  split,
  exact px,
  exact qx,

end


theorem forall_disj_as_disj_forall_converse :
  (∀x, P x) ∨ (∀x, Q x) → (∀x, P x ∨ Q x)  :=
begin
  intro h,
  cases h with hp hq,
  intro x,
  have px := hp(x),
  left,
  exact px,
  intro x,
  have qx := hq(x),
  right,
  exact qx,
  
end


/- NOT THEOREMS --------------------------------

theorem forall_disj_as_disj_forall :
  (∀x, P x ∨ Q x) → (∀x, P x) ∨ (∀x, Q x)  :=
begin
end

theorem exists_conj_as_conj_exists_converse :
  (∃x, P x) ∧ (∃x, Q x) → (∃x, P x ∧ Q x)  :=
begin
end

---------------------------------------------- -/

end predicate
