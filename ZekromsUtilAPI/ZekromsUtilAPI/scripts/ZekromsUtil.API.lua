Zutil={animator={}}
--http://lua-users.org/wiki/CopyTable
function Zutil.deepcopy(orig)
	local copy
	if type(orig)=='table'then
		copy={}
		for key,origValue in next,orig,nil do
			copy[Zutil.deepcopy(key)]=Zutil.deepcopy(origValue)
		end
		setmetatable(copy,Zutil.deepcopy(getmetatable(orig)))
	else	return orig	end
	return copy
end

function Zutil.swap2(array)
	return{array[2],array[1]}
end

function Zutil.inTable(array,v)--Checks if a value exists in the array
	for _,value in pairs(array)do
		if value==v then
			return true
	end	end
	return false
end

function Zutil.inTableDeep(array,v)--Checks if a value exists in the array
	for _,value in pairs(array)do
		if type(value)=="table"then
			if Zutil.inTableDeep(value,v)then	return true	end
		elseif value==v then
			return true
		end
	end
	return false
end

function Zutil.printVars()--Prints all global vars
	local i,v=nextvar(nil)
	local arr={}
	while i do
		table.insert(arr,i)
		i,v=nextvar(i)
	end
	sb.logInfo(sb.printJson(arr))
end

function Zutil.params(...)--Returns the values of parameters in the config file as an unpacked table
--If using a table as a parameter: {path,default}
	local arr={}
	for _,v in ipairs(arg)do
		if type(v)=="table"then
			table.insert(arr,config.getParameter(table.unpack(v)))
		else
			table.insert(arr,config.getParameter(v))
	end	end
	return table.unpack(arr)
end
--a,b.c,d.e.f,self.time=Zutil.params({"a",false},"b.c",{"d.e.f",12},"time")

function Zutil.animator.stopSounds(...)
	for _,v in ipairs(arg)do
		animator.stopAllSounds(v)
	end
end

function Zutil.loopFunction(fn,...)--Loops fn() for all args if type(arg[n])=="table" then it unpacks the table as args.  Returns an unpacked table of returns
	local arr={}
	for _,v in ipairs(arg)do
		table.insert(arr,
			FIF(type(v)=="table",
				function()return fn(table.unpack(v))end,
				function()return fn(v)end
			)
		)
	end
	return table.unpack(arr)
end

function fif(c,t,f)--Acts like a ternary operator (c)?t:f
	if c then	return t	end
	return f
end

function FIF(c,t,f)--Acts like a ternary operator but t and f must be a function
	if c then	return t()	end
	return f()
end

function fifA(c,t,f)--Auto detects t or f as functions
	if c then
		if type(t)=="function"then
			return t()
		else
			return t
		end
	elseif type(f)=="function"then
		return f()
	else
		return f
	end
end

function fifLoop(...)--Runs fifA for `{c,t},{c,t},...` Where `c` is condition, `t` is when true.  Use `or` for else `fifLoop(...) or e`
	for k,v in ipairs(arg)do
		if v[1]then
			if type(v[2])=="function"then
				return v[2](),k
			else
				return v[2],k
			end
		end
	end
end--`fifLoop({a=="one",1},{a=="two",2},...) or "not in list"`

function Zutil.switch(v,arr)--Runs a switch for each arr return arr[i][2], key
	for key,value in ipairs(arr)do
		if value[1]==v then
			return value[2],key
		end
	end
end
--Zutil.switch(3,{{1,"a"},{2,"b"},{3,"c"},{4,"d"}})or "e"

function Zutil.switchKey(v,arr)--Returns the the key that v matches
	for key,value in ipairs(arr)do
		if value==v then
			return key
		end
	end
end
--[[
a=2
local values={
	function()return 1+a end,
	function()return 2-a end,
	function()return 3*a end,
	function()return 4/a end,
	function()return 5%a end
}
local key=Zutil.switchKey(3,{1,2,3,4,5,6,7})
print(values[key]())
]]

function Zutil.version()
	sb.logInfo(tostring(_VERSION))
end