Ztrig={}
function Ztrig.wrapRad(rad)--Faster than util.wrapAngle
	return rad%(2*math.pi)
end

function Ztrig.wrapDeg(deg)
	return deg%360
end

function Ztrig.toRad(deg)
	return math.rad(deg%360)
end