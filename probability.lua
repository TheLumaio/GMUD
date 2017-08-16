
--[[
Returns an item from list based on random probability
Probability map example:
{
	{"Legendary", 0.25}, -- 25% chance
	{"Slow", 0.05}, -- 5% chance
	{"Freezing", 0.05} -- 5% chance
	{"Fury", 0.65} -- 65% chance
}
]]
function getProbabilityItem(map)
	local sum = 0
	for i,v in ipairs(map) do
		sum = sum + v[2]
	end
	
	local rand = math.random()*sum
	local cum = 0
	
	for i,v in ipairs(map) do
		cum = cum + v[2]
		if rand < cum then
			return v[1], v[2]
		end
	end
	return nil
end
