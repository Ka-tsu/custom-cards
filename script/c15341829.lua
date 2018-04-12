--Gacha Re-Roll
function c15341829.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c15341829.cost)
	e1:SetTarget(c15341829.target)
	e1:SetOperation(c15341829.activate)
	e1:SetCountLimit(3,15341829)
	c:RegisterEffect(e1)
end
function c15341829.costfilter(c,ft)
	return c:IsAbleToGraveAsCost() and c:IsSetCard(0xc1a) and c:IsType(TYPE_MONSTER) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup())
end
function c15341829.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return Duel.IsExistingMatchingCard(c15341829.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,c,ft) end
	local g=nil
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	if ft<=0 then
		g=Duel.SelectMatchingCard(tp,c15341829.costfilter,tp,LOCATION_MZONE,0,1,1,c,ft)
	else
		g=Duel.SelectMatchingCard(tp,c15341829.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,c,ft)
	end
	e:SetLabelObject(g:GetFirst())
	Duel.SendtoGrave(g,REASON_COST)
end
function c15341829.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0xc1a)
end
function c15341829.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c15341829.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,e:GetLabelObject(),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c15341829.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c15341829.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,e:GetLabelObject(),e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end