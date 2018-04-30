Zattract={}
function Zattract.vacuumItems()
	self.vacuumRange=self.vacuumRange or config.getParameter("vacuumRange",5)
	local arr=world.itemDropQuery(object.position(), self.vacuumRange)
	for _,a in pairs(arr) do
		local item=world.takeItemDrop(a,object.id())
		item=world.containerAddItems(object.id(), item)
		if item~=nil or next(item)~=nil then
			world.spawnItem(item.name,entity.position(),item.count)
			break
		end
	end
end

function Zattract.npc(rad,dt,poz)
	poz=poz or entity.position()
	Zattract.call(world.npcQuery(poz,rad),poz,dt)
end

function Zattract.monster(rad,dt,poz)
	poz=poz or entity.position()
	Zattract.call(world.monsterQuery(poz,rad),poz,dt)
end

function Zattract.all(rad,dt,poz)
	poz=poz or entity.position()
	Zattract.call(world.monsterQuery(poz,rad),poz,dt)
	Zattract.call(world.npcQuery(poz,rad),poz,dt)
end

function Zattract.call(arr,poz,dt)
	require "/scripts/pathing.lua"
	for _,id in pairs(arr) do
		world.callScriptedEntity(id,"PathMover:move",poz,dt)
	end
end