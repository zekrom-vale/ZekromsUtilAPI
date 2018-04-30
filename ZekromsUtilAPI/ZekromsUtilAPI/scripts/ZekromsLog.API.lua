Zlog={}
function Zlog.logJson(value,n)
	sb.logInfo(sb.printJson(value,n or 1))
end

function Zlog.logLua(value,n)
	sb.logInfo(sb.print(value,n or 1))
end

function Zlog.sbName()
	local name=config.getParameter("objectName")
	if name==nil then	name=config.getParameter("itemName")	end
	return "'"..(name or "null").."'.  id: '"..(entity.id() or "null").."'"
end

function Zlog.vars()
	sb.logInfo(sb.printJson({storage=storage,self=self},1))
end