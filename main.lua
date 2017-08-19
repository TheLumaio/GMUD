lg = love.graphics
lm = love.mouse

math.randomseed(os.time())

love.keyboard.setKeyRepeat(true)

lg.setDefaultFilter("linear", "linear")
lg.setLineStyle("rough")
lg.setLineWidth(1)
local font = lg.newFont("data/cherry.ttf", 7)
font:setFilter("linear", "linear")

require "probability"
interface = require "interface.interface"
local inv_state = require "states.inventory"
local map_state = require "states.map"
local start_state = require "states.start"

local Link = require "interface.link"

local STATE = nil

function changeState(state)
	if not state.initialized then
		state:init()
		state.initialized = true
	end
	STATE = state
end

function love.load()
    lg.setFont(font)
	changeState(start_state)

	interface:clear("global")
	interface:add("global", Link("Map", 610, 20, function() changeState(map_state) end))
	interface:add("global", Link("Inventory", 550, 20, function() changeState(inv_state) end))
	interface:add("global", Link("Character", 485, 20, function() changeState(start_state) end))
end

function love.update(dt)
	STATE:update(dt)
end

function love.draw()
    STATE:draw()
	interface:update("global")
end

function love.textinput(text)
	STATE:textinput(text)
end

function love.mousepressed(x, y, b)
	STATE:mousepressed(x, y, b)
	interface:mousepressed(x, y, b, "global")
end

function love.mousereleased(x, y, b)
	STATE:mousereleased(x, y, b)
end

function love.keypressed(key)
	STATE:keypressed(key)
	
	--[[ TODO: Remove this and add close button to menu ]]
	if key == "escape" then
		love.event.quit()
	end
end

function love.keyreleased(key)
	STATE:keyreleased(key)
end
