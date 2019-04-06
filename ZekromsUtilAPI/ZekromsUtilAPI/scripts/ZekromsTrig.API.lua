Ztrig={}

function Ztrig.wrap(a,t)--Faster than util.wrapAngle
	if t=="deg"then
		return a%360
	elseif t=="rev"then
		return a%1
	elseif t=="tau"then
		return a%math.pi
	else
		return a%(2*math.pi)
	end
end

function Ztrig.rad(a,t)
	if t=="rev"then
		return a*2*math.pi
	elseif t=="tau"then
		return 2*a
	else
		return a*math.pi/180
	end
end

function Ztrig.deg(a,t)--Faster than util.wrapAngle
	if t=="rev"then
		return a*360
	elseif t="tau"then
		return a*360/math.pi
	else
		return a*180/math.pi
	end
end

function Ztrig.rev(a,t)--Faster than util.wrapAngle
	if t=="deg"then
		return a/360
	elseif t=="tau"then
		return a/math.pi
	else
		return a/(2*math.pi)
	end
end

Ztrig.quadrant(a,t)--Returns the quadrant a is in (if a is a quadrantal angle it returns a .5 value)
--0=0.5, 90=1.5, 180=2.5, 270=3.5, 360=0.5,...
	a=Ztrig.wrap(a,t)
	if t=="deg"then
		a=a/90
	elseif t=="rev"then
		a=a*4
	elseif t=="tau"then
		a=a*4/math.pi
	else
		a=a*2/math.pi
	end
	if a%1==0 then
		if a==0 then
			return 0.5,{1,4}
		end
		return a+0.5,{a,a+1}
	end
	return math.ceil(a)
end

function Ztrig.prime(a,t)--Returns a'
	require "/scripts/ZekromsUtil.API.lua"
	if t=="deg"then
		a=math.abs(a-180)
		return fif(a>90,180-a,a)
	elseif t=="rev"then
		a=math.abs(a-0.5)
		return fif(a>0.25,0.5-a,a)
	elseif t=="tau"then
		a=math.abs(a-math.pi/2)
		return fif(a>math.pi/4,math.pi/2-a,a)
	else
		a=math.abs(a-math.pi)
		return fif(a>math.pi/2,math.pi-a,a)
	end
end