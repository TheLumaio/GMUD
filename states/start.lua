local state = {}

local Link = require "interface.link"
local Input = require "interface.input"

local backdrop = nil
local spox = 70
local spos = 100

function updateUi()
	interface:clear("class_selection", "start_other")
	
	interface:add("class_selection", Link("Barbarian", spox, spos, function()
		--[[ TODO: Select class ]]
	end))
	interface:add("class_selection", Link("Warlock", spox, spos+20, function()
		--[[ TODO: Select class ]]
	end))
	interface:add("class_selection", Link("Archer", spox, spos+40, function()
		--[[ TODO: Select class ]]
	end))
	
	interface:add("start_other", Input("Name", spox, spos+180))
	
end

function state:init()
	backdrop = lg.newImage("data/start.png")
	updateUi()
end

function state:update(dt)
end

function state:draw()
	lg.draw(backdrop)
	interface:update("class_selection", "start_other")
end

function state:mousepressed(x, y, b)
	interface:mousepressed(x, y, b, "class_selection", "start_other")
end

function state:mousereleased(x, y, b)
	
end

function state:keypressed(key)
	interface:keypressed(key, "start_other")
end

function state:textinput(text)
	interface:textinput(text, "start_other")
end

function state:keyreleased(key)
	
end

return state
