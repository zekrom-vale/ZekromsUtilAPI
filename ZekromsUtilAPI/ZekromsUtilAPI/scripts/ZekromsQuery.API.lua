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

function Zquery.where(...)--Returns an unpacked table of {underground,inSurfaceLayer,underWater} for every position
	local arr={}
	if arg==nil then
		arg={entity.position()}
	end
	for _,v in ipairs(arg)do
		table.insert(arr,{world.underground(v),world.inSurfaceLayer(v),world.oceanLevel(v)>=v[2]})
	end
	return table.unpack(arr)
end

function Zquery.underWater(...)--Returns an unpacked table of true or false if the position is underWater
	local arr={}
	if arg==nil then
		arg={entity.position()}
	end
	for _,v in ipairs(arg)do
		table.insert(arr,world.oceanLevel(v)>=v[2])
	end
	return table.unpack(arr)
end

function Zquery.inLiquid(...)--Returns an unpacked table of true or false if the position is in a liquid
	local arr={}
	if arg==nil then
		arg={entity.position()}
	end
	for _,v in ipairs(arg)do
		table.insert(arr,world.liquidAt(v))
	end
	return table.unpack(arr)
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
	return world.objectQuery(poz or object.position(),rect.size(rectangle))
end

if table.unpack==nil then--Fixes table.unpack for v5.1
	table.unpack=unpack
end