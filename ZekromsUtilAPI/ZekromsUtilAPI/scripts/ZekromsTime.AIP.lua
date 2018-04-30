Ztime={}
function Ztime.setNoon()
	local t=world.timeOfDay()
	if t<=.25 or t>=.75 then	world.setSkyTime(world.dayLength()/2)	end
end

function Ztime.setDawn()
	local t=world.timeOfDay()
	if t<=.25 or t>=.75 then	world.setSkyTime(world.dayLength()/4)	end
end

function Ztime.setMidNight()
	local t=world.timeOfDay()
	if t>.25 and t<.75 then	world.setSkyTime(0)	end
end

function Ztime.setSunSet()
	local t=world.timeOfDay()
	if t>.25 and t<.75 then	world.setSkyTime(3*world.dayLength()/4)	end
end

function Ztime.setFloat(n)
	world.setSkyTime(n*world.dayLength())
end

function Ztime.setInt(n)
	world.setSkyTime(world.dayLength()/n)
end