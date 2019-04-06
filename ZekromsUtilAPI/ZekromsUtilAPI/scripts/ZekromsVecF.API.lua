require"/scripts/ZekromsUtil.API.lua"
ZvecF={}
function ZvecF.dot(v,u)
	if v._angle or u._angle then
		local a=math.abs(v[1]-u[1])
		v,u=ZvecF.toAngle(v),ZvecF.toAngle(u)
		return v[2]*u[2]*math.cos(fifA(a>math.pi,function()return 2*math.pi-a,a end,a))
	end
	return v[1]*u[1]+v[2]*u[2]
end

function ZvecF.mag(v)
	if v._angle then
		return v[2]
	end
	local m=v[1]^2+v[2]^2
	return math.sqrt(m),m
end

function ZvecF.angleBetween(v,u,__fail)
	if v._angle and u._angle then
		local a=math.abs(v[1]-u[1])
		return fifA(a>math.pi,function()return 2*math.pi-a,a end,a)
	elseif v._angle or u._angle then
		if __fail>=1 then
			return
		end
		return ZvecF.angleBetween(ZvecF.toAngle(v),ZvecF.toAngle(u),(__fail or -1)+1),false
	end
	local r=(v[1]*u[1]+v[2]*u[2])/math.sqrt((v[1]^2+v[2]^2)*(u[1]^2+u[2]^2))
	return math.acos(r),r
end

function ZvecF.atan2(b,a)
	if a==0 then
		return fifA(b==0,nil,function()return fif(b>0,0.5,1.5)*math.pi end)
		--return b==0?nil:(b>0?1/2:3/2)*math.pi
	elseif b==0 then
		return fif(a>0,0,math.pi)
	end
	local tan=math.atan(b/a)
	if b<0 then
		return tan+math.pi
	else
		return fif(a>0,tan,2*math.pi+tan)
	end
end

function ZvecF.toAngle(v)
	if v._angle then
		return v,false
	end
	return{ZvecF.atan2(v[1],v[2]),math.sqrt(v[1]^2+v[2]^2);_angle=true}
end

function ZvecF.component(m)
	if not v._angle then
		return m,false
	end
	return{m[2]*math.cos(m[1]),m[2]*math.sin(m[1])}
end

function ZvecF.isAngle(v)
	return v._angle==true
end