Ztrig={}

function Ztrig.wrap(a,t)--Faster than util.wrapAngle
	if t=="deg"then
		return a%360
	elseif t=="rev"then
		return a%1
	else
		return a%(2*math.pi)
	end
end

function Ztrig.rad(a,t)
	if t=="rev"then
		return a*2*math.pi
	else
		return a*math.pi/180
	end
end

function Ztrig.deg(a,t)--Faster than util.wrapAngle
	if t=="rev"then
		return a*360
	else
		return a*180/math.pi
	end
end

function Ztrig.rev(a,t)--Faster than util.wrapAngle
	if t=="deg"then
		return a/360
	else
		return a/(2*math.pi)
	end
end

Ztrig.quadrant(a,t)
	if t=="deg"then
		return math.ceil(a/90)
	elseif t=="rev"then
		return math.ceil(a*4)
	else
		return math.ceil(a*2/math.pi)
	end
end

function Ztrig.prime(a)
	if a<=90 then
		return a
	elseif a<=180 then
		return 180-a
	elseif a<=270 then
		return a-180
	elseif a<=360 then
		return 360-a
	end
end