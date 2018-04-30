Zrect={}
function Zrect.rectn(n)
	return {n,n,n,n}
end

function Zrect.rectNil()
	return {nil,nil,nil,nil}
end

function Zrect.VecToRect(arr)
	return {arr[1],arr[2],arr[1],arr[2]}
end

function Zrect.rectFrom(x,y,poz)
	require "/scripts/rect.lua"
	return rect.withCenter(poz or entity.position(), {x,y or x})
end