--created and scripted by rising phoenix
function c100001124.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,100001110,100001111,false,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
		local e11=Effect.CreateEffect(c)
	e11:SetDescription(aux.Stringid(100001124,0))
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
		e11:SetRange(LOCATION_MZONE)
	e11:SetType(EFFECT_TYPE_IGNITION)
		e11:SetCountLimit(1)
	e11:SetTarget(c100001124.htg)
	e11:SetOperation(c100001124.hop)
	c:RegisterEffect(e11)
		--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(100001124,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_MZONE)
		e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetCondition(c100001124.spcon)
	e4:SetCost(c100001124.spcost)
	e4:SetTarget(c100001124.sptg)
	e4:SetOperation(c100001124.spop)
	c:RegisterEffect(e4)
	end
	function c100001124.spcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetFlagEffect(100001124)==0
end
function c100001124.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDeckOrExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,2,REASON_COST)
end
function c100001124.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100001124.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return false end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=1
		and Duel.IsExistingTarget(c100001124.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,100001108)
		and Duel.IsExistingTarget(c100001124.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp,100001109) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c100001124.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp,100001108)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c100001124.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp,100001109)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,2,0,0)
end
function c100001124.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()~=2 or ft<2 then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
function c100001124.htg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,100001153,0,0x4011,500,0,1,RACE_WARRIOR,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c100001124.hop(e,tp,eg,ep,ev,re,r,rp)
	local ft=5
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	ft=math.min(ft,Duel.GetLocationCount(tp,LOCATION_MZONE))
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,100001153,0,0x4011,500,0,1,RACE_WARRIOR,ATTRIBUTE_EARTH) then return end
	repeat
		local token=Duel.CreateToken(tp,100001153)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
		e2:SetLabelObject(token)
	e2:SetCondition(c100001124.condition)
	e2:SetOperation(c100001124.operation)
		Duel.RegisterEffect(e2,tp)
		ft=ft-1
	until ft<=0 or not Duel.SelectYesNo(tp,aux.Stringid(100001124,1))
	Duel.SpecialSummonComplete()
end
function c100001124.condition(e,tp,eg,ep,ev,re,r,rp)
			local tok=e:GetLabelObject()
	if eg:IsContains(tok) then
		return true
	else
		if not tok:IsLocation(LOCATION_MZONE) then e:Reset() end
		return false
	end
end
function c100001124.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,500,REASON_EFFECT)
	end