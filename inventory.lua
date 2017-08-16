local state = {}

local Text = require "text"
local Item = require "item"
local itemui = {}
local infoui = {}
local items = {}

local weapon_rare = {
	{{"pre", "Legendary", {90,155,155}}, 0.01},
	{{"pre", "Rare", {155,90,90}}, 0.05},
	{{"pre", "Uncommon", {155,90,155}}, 0.10},
	{{"pre", "Common", {200,200,200}}, 0.15},
	{nil, 2}
}

local weapon_mods = {
	{{"post", "Fury", {155,155,90}}, 0.1},
	{{"post", "Freezing", {90,90,155}}, 0.1},
	{{"post", "Bleeding", {200,90,90}}, 0.1}
}

local mod_num = {
	{5, 0.001},
	{4, 0.01},
	{3, 0.01},
	{2, 0.05},
	{1, 0.20},
	{0, 1.00}
}

function createWeapon()
	local mods = {}
	local sum = 0
	local num, prob = getProbabilityItem(mod_num)
	sum = sum + (1-prob)
	local rare, prob = getProbabilityItem(weapon_rare)
	sum = sum + (1-prob)
	if rare ~= nil then
		table.insert(mods, rare)
	end
	for i=1,num do
		local mod, prob = getProbabilityItem(weapon_mods)
		local found = false
		for i,v in ipairs(mods) do
			if v == mod then
				found = true
			end
		end
		if not found then
			table.insert(mods, mod)
			sum = sum + (1-prob)
		end
	end
	return Item("(" .. math.floor(sum*100)/100 .. "%) Sword", "It's a sword I guess.", "Sword", mods)
end

function updateinfo(item)
	infoui = {}
	
	table.insert(infoui, Text("Name:   " .. item:getNormalName(), 200, 70))
	table.insert(infoui, Text("Description:   " .. item.description, 200, 90))
	table.insert(infoui, Text("Type:   " .. item.type, 200, 110))
	table.insert(infoui, Text("___________________", 200, 120))
	for i,v in ipairs(item.options) do
		table.insert(infoui, Text(v.name, 200, 110+i*20, true, v.func))
	end
end

function updateitems()
	itemui = {}
	infoui = {}
	
	table.insert(itemui, Text("Clear", 10, 10, true, function() infoui = {} items = {} updateitems() end))
	table.insert(itemui, Text("Test Probability", 10, 30, true, function()
		if #items == 8 then
			items = {}
			updateitems()
		end
		
		local map = {
			{"Legendary", 0.25}, -- 25% chance
			{"Slow",      0.05}, -- 5% chance
			{"Freezing",  0.05}, -- 5% chance
			{"Fury",      0.65}  -- 65% chance
		}
		local item, prob = getProbabilityItem(map)
		table.insert(items, createWeapon())
		updateitems()
		-- print(item .. " (" .. prob .. "%)")
	end))
	
	for i,v in ipairs(items) do
		table.insert(itemui, Text(v:getRichName(), 20, 50+i*20, true, function() updateinfo(v) end))
	end
	lm.setCursor(lm.getSystemCursor("arrow"))
end

function state:init()
	-- if self.init then return end
	-- self.init = true
	local sword = {
		{"pre", "Slow", {100,100,100}},
		{"pre", "Legendary", {155,90,90}},
		{"post", "Fury", {155,155,90}},
		{"post", "Freezing", {90,90,155}}
	}
	
	-- table.insert(items, Item("Shovel", "Used to shovel shit"))
	-- table.insert(items, Item("Sandwich", "A simple PB&J", "Food"))
	-- table.insert(items, Item("Sword", "It's legendary", "Sword", sword))
	-- table.insert(items, createWeapon())
	
	
	updateitems()
	
end

function state:update(dt)
	for i=#items,1,-1 do
		local v = items[i]
		if v.remove then
			table.remove(items, i)
			updateitems()
		end
	end
end

function state:draw()
	for i,v in ipairs(itemui) do
        v:update(love.timer.getDelta())
        v:draw()
    end
	
	for i,v in ipairs(infoui) do
        v:update(love.timer.getDelta())
        v:draw()
    end
end

function state:mousepressed(x, y, b)
	for i,v in ipairs(itemui) do
		v:mousepressed(x, y, b)
	end
	for i,v in ipairs(infoui) do
		v:mousepressed(x, y, b)
	end
end

function state:mousereleased(x, y, b)
	
end

function state:keypressed(key)
	
end

function state:keyreleased(key)
	
end

return state
