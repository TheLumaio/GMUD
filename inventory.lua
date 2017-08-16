local state = {}

local Text = require "text"
local Item = require "item"
local itemui = {}
local infoui = {}
local items = {}

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
	
	table.insert(itemui, Text("Clear", 10, 10, true, function() infoui = {} end))
	table.insert(itemui, Text("Test Probability", 10, 20, true, function()
		local map = {
			{"Legendary", 0.25}, -- 25% chance
			{"Slow",      0.05}, -- 5% chance
			{"Freezing",  0.05}, -- 5% chance
			{"Fury",      0.65}  -- 65% chance
		}
		local item, prob = getProbabilityItem(map)
		print(item .. " (" .. prob .. "%)")
	end))
	
	for i,v in ipairs(items) do
		table.insert(itemui, Text(v:getRichName(), 75, 50+i*20, true, function() updateinfo(v) end))
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
	
	table.insert(items, Item("Shovel", "Used to shovel shit"))
	table.insert(items, Item("Sandwich", "A simple PB&J", "Food"))
	table.insert(items, Item("Sword", "It's legendary", "Sword", sword))
	
	
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
