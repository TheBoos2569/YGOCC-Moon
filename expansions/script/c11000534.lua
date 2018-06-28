--Shya Caretaker
function c11000534.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11000534,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,11000534+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c11000534.condition)
	e1:SetCost(c11000534.cost)
	e1:SetTarget(c11000534.target2)
	e1:SetOperation(c11000534.operation2)
	e1:SetLabel(1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11000534,1))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,11000534+EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(c11000534.condition)
	e2:SetCost(c11000534.cost)
	e2:SetTarget(c11000534.target1)
	e2:SetOperation(c11000534.operation1)
	e2:SetLabel(2)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(11000534,2))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCountLimit(1,11000534+EFFECT_COUNT_CODE_OATH)
	e3:SetCondition(c11000534.condition)
	e3:SetCost(c11000534.cost)
	e3:SetTarget(c11000534.target3)
	e3:SetOperation(c11000534.operation3)
	e3:SetLabel(3)
	c:RegisterEffect(e3)
	--atklimit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e4)
end
function c11000534.condition(e,tp,eg,ep,ev,re,r,rp)
	return (e:GetHandler():IsReason(REASON_COST) and re:GetHandler():IsSetCard(0x1FD)) or
		(re:GetHandler():IsSetCard(0x1FD) and bit.band(r,REASON_EFFECT)~=0)
end
function c11000534.rfilter(c)
	return c:IsSetCard(0x1FD) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeckAsCost()
end
function c11000534.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetLabel()
	if chk==0 then return Duel.IsExistingMatchingCard(c11000534.rfilter,tp,LOCATION_GRAVE,0,ct,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c11000534.rfilter,tp,LOCATION_GRAVE,0,ct,ct,nil)
	Duel.SendtoDeck(g,nil,ct,REASON_COST)
end
function c11000534.target1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c11000534.operation1(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Recover(tp,1500,REASON_EFFECT)
end
function c11000534.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1500)
end
function c11000534.operation2(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c11000534.filter(c)
	return c:IsSetCard(0x1FD) and c:IsAbleToHand()
end
function c11000534.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c11000534.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c11000534.operation3(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c11000534.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		Duel.BreakEffect()
		Duel.Recover(tp,1500,REASON_EFFECT)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
