local state = {}

local Text = require "text"
local Item = require "item"
local itemui = {}
local infoui = {}
local items = {}

function updateinfo(item)
	infoui = {}
	
	table.insert(infoui, Text("Name:   " .. item.name, 200, 70))
	table.insert(infoui, Text("Description:   " .. item.description, 200, 90))
	table.insert(infoui, Text("___________________", 200, 100))
	for i,v in ipairs(item.options) do
		table.insert(infoui, Text(v.name, 200, 90+i*20, true, v.func))
	end
end

function updateitems()
	itemui = {}
	infoui = {}
	
	table.insert(itemui, Text("Clear", 10, 10, true, function() infoui = {} end))
	
	for i,v in ipairs(items) do
		table.insert(itemui, Text(v.name, 75, 50+i*20, true, function() updateinfo(v) end))
	end
	lm.setCursor(lm.getSystemCursor("arrow"))
end

function state:init()
	-- if self.init then return end
	-- self.init = true
	
	table.insert(items, Item("Generic Item"))
	table.insert(items, Item("Test Item"))
	table.insert(items, Item("Shovel"))
	
	
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
