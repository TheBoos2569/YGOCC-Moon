--"Santos, the Spell Sealer Espadachim"
local m=70024
local cm=_G["c"..m]
function cm.initial_effect(c)
    --"Special Summon"
    local e0=Effect.CreateEffect(c)
    e0:SetType(EFFECT_TYPE_FIELD)
    e0:SetCode(EFFECT_SPSUMMON_PROC)
    e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e0:SetRange(LOCATION_HAND)
    e0:SetCountLimit(1,70024)
    e0:SetCondition(c70024.spcon)
    c:RegisterEffect(e0)
     --"Negate"
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetCode(EVENT_CHAINING)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition(c70024.condition)
    e1:SetCountLimit(1)
    e1:SetCost(c70024.cost)
    e1:SetTarget(c70024.target)
    e1:SetOperation(c70024.operation)
    c:RegisterEffect(e1)
end
function c70024.filter(c)
    return c:IsFaceup() and c:IsAttackAbove(2000)
end
function c70024.spcon(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsExistingMatchingCard(c70024.filter,tp,0,LOCATION_MZONE,1,nil)
end
function c70024.condition(e,tp,eg,ep,ev,re,r,rp)
    return re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c70024.cfilter(c)
    return c:IsSetCard(0x509) and c:IsDiscardable()
end
function c70024.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if Duel.IsPlayerAffectedByEffect(tp,EFFECT_DISCARD_COST_CHANGE) then return true end
    if chk==0 then return Duel.IsExistingMatchingCard(c70024.cfilter,tp,LOCATION_HAND,0,1,nil) end
    Duel.DiscardHand(tp,c70024.cfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c70024.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
    if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
        Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
    end
end
function c70024.operation(e,tp,eg,ep,ev,re,r,rp)
    if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
        Duel.Destroy(eg,REASON_EFFECT)
    end
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
    e1:SetTargetRange(0,1)
    e1:SetValue(c70024.aclimit)
    e1:SetLabel(re:GetHandler():GetCode())
    Duel.RegisterEffect(e1,tp)
end
function c70024.aclimit(e,re,tp)
    return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(e:GetLabel())
end