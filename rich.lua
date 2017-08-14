
function richPrint(str)
	-- for w in string.gmatch("(#AABBCCDD)test1 (#FFFFFFFF)test2", "%(#(%a+)%)") do
	for w in string.gmatch("(#AABBCCDD)test1 (#FFFFFFFF)test2", "(%(#(%a+)%))%a+") do
		print(tostring(w))
	end
end
