--Deep Leviathan Dragon Aquabizarre
--scripted by Rawstone
local s,id=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	c:RegisterEffect(e1)
	--excavate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(s.target)
	e2:SetOperation(s.operation)
	c:RegisterEffect(e2)
end
	function s.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xb23) and not c:IsCode(720051)
end
	function s.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
	function s.filta(c,tp,code)
	local ae=c:GetActivateEffect()
	return ae and ae:IsActivatable(tp,true) and c:IsSetCard(0xb23) and c:IsType(TYPE_SPELL) and c:IsType(TYPE_FIELD+TYPE_CONTINUOUS) and not c:IsCode(code)
end
	function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and
	Duel.IsExistingMatchingCard(s.filta,tp,LOCATION_DECK,0,1,nil,tp,code) end
end
	function s.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	local code=tc:GetCode()
		if tc:IsType(TYPE_SPELL) and tc:IsType(TYPE_FIELD+TYPE_CONTINUOUS) and Duel.GetMatchingGroup(s.filta,tp,LOCATION_DECK,0,1,nil,tp,code) then
		local tr=Duel.GetMatchingGroup(s.filta,tp,LOCATION_DECK,0,nil,tp,code)
			if tr:GetCount()>0 then
			Duel.Remove(tc,REASON_TEMPORARY)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
			local sg=tr:Select(tp,1,1,nil)
			local sc=sg:GetFirst()
			Duel.MoveToField(sc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.ShuffleDeck(tp)
		local te=sc:GetActivateEffect()
			Duel.BreakEffect()
		end
			Duel.SendtoDeck(tc,nil,0,REASON_EFFECT+REASON_REVEAL)
		else
			Duel.DisableShuffleCheck()
			Duel.SendtoDeck(tc,nil,0,REASON_EFFECT+REASON_REVEAL)
	end
end