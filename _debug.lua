DEBUG_ENABLE = false

--Just makes things easier to read
function ternary ( cond , T , F )
    if cond then return T else return F end
end

function debugLog( o, file, overwrite)
	if not DEBUG_ENABLE then return end
	if file == nil then
		file = "log"
	end
	if overwrite == nil then
		overwrite = false
	end
    printh(o, file, overwrite)
end

function debugToScreen (o, x, y)
	print(o, ternary(x ~= nil, x, 1), ternary(y ~= nil, y, 1), 7)
end

function dumpObject(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dumpObject(v) .. ', '
	   end
	   return s .. '} '
	else
	   return tostr(o)
	end
end
