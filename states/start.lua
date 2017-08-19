local state = {}

local Link = require "interface.link"
local Input = require "interface.input"
local Label = require "interface.label"

local backdrop = nil
local spox = 70
local spos = 100

local classes = {
{
name="Barbarian",
blurb=[[
This is a blurb about the Barbarian class.
Eventually there will be something useful
here but for now this is all you get.
]]
},
{
name="Warlock",
blurb=[[
Warlock's are powerful wizards that use
their rage to summon demonic creatures.
]]
},
{
name="Archer",
blurb=[[
Archer's prefer long range encounters
and use specially crafted arrows to
poison or slow enemies.
]]
}
}
local blurb = ""
local class = ""

local function updateblurb(index)
	interface:clear("start_blurb")
	interface:add("start_blurb", Label(classes[index].blurb, 320+20, 100))
	class = classes[index].name
end

local function updateui()
	interface:clear("class_selection", "start_other")

	-- interface:add("class_selection", Link("Barbarian", spox, spos, function()
	-- 	updateblurb("barbarian")
	-- end))
	-- interface:add("class_selection", Link("Warlock", spox, spos+20, function()
	-- 	updateblurb("warlock")
	-- end))
	-- interface:add("class_selection", Link("Archer", spox, spos+40, function()
	-- 	--[[ TODO: Select class ]]
	-- end))

	for i,v in ipairs(classes) do
		interface:add("class_selection", Link(v.name, spox, spos+((i-1)*20), function() updateblurb(i) end))
	end

	interface:add("start_other", Input("Name", spox, spos+180))

end

function state:init()
	backdrop = lg.newImage("data/start.png")
	updateui()
end

function state:update(dt)
end

function state:draw()
	lg.draw(backdrop)
	interface:update("class_selection", "start_other", "start_blurb")
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
