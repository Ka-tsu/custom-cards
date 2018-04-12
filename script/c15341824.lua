--Gacha Jack Ace
function c15341824.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15341824,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c15341824.sptg)
	e1:SetOperation(c15341824.spop)
	c:RegisterEffect(e1)
	local e4=e1:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
	  --Activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(15341824,1))
	e2:SetCategory(CATEGORY_DICE+CATEGORY_ATKCHANGE+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c15341824.target)
	e2:SetOperation(c15341824.operation)
	c:RegisterEffect(e2)   
end

function c15341824.filter(c,e,tp)
	return c:IsCode(15341824) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c15341824.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c15341824.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c15341824.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c15341824.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c15341824.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c15341824.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0xc1a) and c:IsLocation(LOCATION_EXTRA)
end

function c15341824.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)  
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c15341824.secfilter(c,e,tp)
	return c:IsSetCard(0xc1a) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c15341824.operation(e,tp,eg,ep,ev,re,r,rp)
	local dc=Duel.TossDice(tp,1)
	if dc==2 or dc==5 then
		Duel.Damage(1-tp,dc*200,REASON_EFFECT)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
		if not Duel.IsPlayerCanSpecialSummonMonster(tp,15341825,0,0x4011,0,0,1,RACE_FAIRY,ATTRIBUTE_WATER) then return end
		for i=1,2 do
			local token=Duel.CreateToken(tp,15341824+i)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
		Duel.SpecialSummonComplete()
	elseif dc==4 or dc==1 then 
		if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
		Duel.ConfirmDecktop(tp,3)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		local g=Duel.GetDecktopGroup(tp,3):Filter(c15341824.secfilter,nil,e,tp)
		if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		Duel.Destroy(e:GetHandler(),REASON_EFFECT) 
		end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c15341824.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
