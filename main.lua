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
end

function love.update(dt)
	STATE:update(dt)
end

function love.draw()
    STATE:draw()
end

function love.textinput(text)
	STATE:textinput(text)
end

function love.mousepressed(x, y, b)
	STATE:mousepressed(x, y, b)
end

function love.mousereleased(x, y, b)
	STATE:mousereleased(x, y, b)
end

function love.keypressed(key)
	STATE:keypressed(key)
end

function love.keyreleased(key)
	STATE:keyreleased(key)
end
