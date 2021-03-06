--created by Seth, coded by Lyris
local cid,id=GetID()
function cid.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(cid.condition)
	e1:SetOperation(cid.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(cid.sptg)
	e2:SetOperation(cid.spop)
	c:RegisterEffect(e2)
end
	function cid.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x83e) and c:IsType(TYPE_MONSTER)
end
	function cid.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetAttacker()~=nil and Duel.GetAttacker():IsControler(1-tp)
end
	function cid.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if Duel.IsExistingMatchingCard(cid.filter,tp,LOCATION_REMOVED,0,1,nil) and Duel.NegateAttack() then
		Duel.BreakEffect()
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
end
	function cid.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(cid.filter,tp,LOCATION_REMOVED,0,1,nil)
	and Duel.GetMatchingGroupCount(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,nil)>=1 end
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	end
end
	function cid.spop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(cid.filter,tp,LOCATION_REMOVED,0,1,nil) then return false end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,0,LOCATION_ONFIELD,1,1,nil)
	local tc=g:GetFirst()
		if tc then
		Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)
	end
end