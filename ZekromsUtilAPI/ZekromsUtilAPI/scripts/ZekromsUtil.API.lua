Zutil={animator={}}
--http://lua-users.org/wiki/CopyTable
function Zutil.deepcopy(orig)
	local copy
	if type(orig)=='table' then
		copy={}
		for key,origValue in next,orig,nil do
			copy[Zutil.deepcopy(key)]=Zutil.deepcopy(origValue)
		end
		setmetatable(copy,Zutil.deepcopy(getmetatable(orig)))
	else	return orig	end
	return copy
end

function Zutil.swap2(array)
	return {array[2],array[1]}
end

function Zutil.inTable(array,v)
	for _,value in pairs(array)do
		if value==v then
			return true
	end	end
	return false
end

function Zutil.inTableDeep(array,v)
	for _,value in pairs(array)do
		if type(value)=="table" then
			if Zutil.inTableDeep(value,v) then	return true	end
		elseif value==v then
			return true
		end
	end
	return false
end

function Zutil.printVars()
	local i,v=nextvar(nil)
	local arr={}
	while i do
		table.insert(arr,i)
		i,v=nextvar(i)
	end
	sb.logInfo(sb.printJson(arr))
end

function Zutil.selfParam(strParam,default)
	if self[strParam]==nil then
		self[strParam]=config.getParameter(strParam,default)
		return false
	end
	return true
end

function Zutil.storageParam(strParam,default)
	if storage[strParam]==nil then
		storage[strParam]=config.getParameter(strParam,default)
		return false
	end
	return true
end

function Zutil.params(...)--Returns the values of parameters in the config file as an unpacked table
--If using a table as a parameter, {path,default}
	local arr={}
	for _,v in ipairs(arg)do
		if type(v)=="table" then
			table.insert(arr,config.getParameter(unpack(v)))
		else
			table.insert(arr,config.getParameter(v))
		end
	end
	return unpack(arr)
end
--a,b.c,d.e.f=Zutil.params({"a",false},"b.c",{"d.e.f",12})

function Zutil.animator.stopSounds(...)
	for _,v in ipairs(arg)do
		animator.stopAllSounds(v)
	end
end

function Zutil.loopFunction(fn,...)
	for _,v in ipairs(arg)do
		if type(v)=="table" then
			fn(unpack(v))
		else
			fn(v)
		end
		
	end
end