local state = {}

local Link = require "interface.link"
local Label = require "interface.label"
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
	interface:clear("info")
	
	interface:add("info", Label("Name:   " .. item:getNormalName(), 300, 70))
	interface:add("info", Label("Description:   " .. item.description, 300, 90))
	interface:add("info", Label("Type:   " .. item.type, 300, 110))
	interface:add("info", Label("___________________", 300, 120))
	for i,v in ipairs(item.options) do
		interface:add("info", Link(v.name, 300, 110+i*20, v.func))
	end
end

function updateitems()
	interface:clear("item")
	interface:clear("info")
	
	interface:add("item", Link("Clear", 10, 10, function() infoui = {} items = {} updateitems() end))
	interface:add("item", Link("Test Probability", 10, 30, function()
		if #items == 14 then
			items = {}
			updateitems()
		end
		
		table.insert(items, createWeapon())
		updateitems()
	end))
	
	for i,v in ipairs(items) do
		interface:add("item", Link(v:getRichName(), 20, 50+i*20, function() updateinfo(v) end))
	end
	lm.setCursor(lm.getSystemCursor("arrow"))
end

function state:init()
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
	interface:update("item", "info")
	
end

function state:textinput(text)
	
end

function state:mousepressed(x, y, b)
	interface:mousepressed(x, y, b, "item", "info")
end

function state:mousereleased(x, y, b)
	
end

function state:keypressed(key)
	
end

function state:keyreleased(key)
	
end

return state
