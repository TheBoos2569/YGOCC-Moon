--created by Walrus, coded by Lyris
local cid,id=GetID()
function cid.initial_effect(c)
	c:SetUniqueOnField(c,1,0,id)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(cid.target)
	e1:SetOperation(cid.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(cid.eqlimit)
	c:RegisterEffect(e2)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_SET_ATTACK)
	e4:SetValue(0)
	c:RegisterEffect(e4)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_SET_DEFENSE)
	e3:SetValue(0)
	c:RegisterEffect(e3)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetValue(cid.atktg)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetCode(EFFECT_REVERSE_DAMAGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetTargetRange(1,0)
	e7:SetValue(cid.rev)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_EQUIP)
	e8:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e8:SetValue(1)
	c:RegisterEffect(e8)
end
function cid.eqlimit(e,c)
	return c:IsControler(1-e:GetHandlerPlayer())
end
function cid.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function cid.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function cid.atktg(e,c)
	return c~=e:GetHandler():GetEquipTarget()
end
function cid.rev(e,re,r,rp,rc)
	local ec=e:GetHandler():GetEquipTarget()
	return bit.band(r,REASON_BATTLE)>0 and (Duel.GetAttacker()==ec or Duel.GetAttackTarget()==ec)
end
