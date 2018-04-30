Zquery={}
function Zquery.closestValidTarget(range,param,poz)--pass nil as param to get to poz without setting param
	param={includedTypes=param or{"player","npc","monster"},order="nearest"}
	local ID=world.entityQuery(poz or entity.position(),range,param)
	return util.find(ID,function(ID)	return entity.isValidTarget(ID)and entity.entityInSight(ID)	end)or 0
end

function Zquery.closestTarget(range,param,poz)
	param={includedTypes=param or{"player","npc","monster"},order="nearest"}
	local ID=world.entityQuery(poz or entity.position(),range,param)
	return util.find(ID,function(ID)	return entity.isValidTarget(ID)	end)or 0
end

function Zquery.where(poz)
	poz=poz or entity.position()
	return world.underground(poz),world.inSurfaceLayer(poz),world.oceanLevel(poz)>=poz[2]
end

function Zquery.underWater(poz)
	poz=poz or entity.position()
	return world.oceanLevel(poz)>=poz[2]
end

function Zquery.inLiquid(poz)
	return world.liquidAt(poz or entity.position())
end

function Zquery.liquidAbove(poz,y)
	local lq=world.liquidAlongLine(poz,{poz[1],poz[2]+y})
	for k,l in pairs(lq)do
		if l[2]==0 then	return k-2,l[1][2]-1	end
	end
	return #lq-1,lq[#lq][1][2]
end

function Zquery.nextTo(poz,box,pad)--I think
	box=rect.pad(box or object.boundBox(),pad or 1)
	world.objectQuery(poz or object.position(),rect.size(rectangle))
end