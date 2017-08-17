lg = love.graphics
lm = love.mouse

math.randomseed(os.time())

lg.setDefaultFilter("linear", "linear")
lg.setLineStyle("rough")
lg.setLineWidth(1)
local font = lg.newFont("data/cherry.ttf", 7)
font:setFilter("linear", "linear")

require "probability"
interface = require "interface"
local inv_state = require "inventory"
local map_state = require "map"

local state = map_state

function love.load()
    lg.setFont(font)
	state:init()
end

function love.update(dt)
	state:update(dt)
end

function love.draw()
    state:draw()
end

function love.mousepressed(x, y, b)
	state:mousepressed(x, y, b)
end

function love.mousereleased(x, y, b)
	state:mousereleased(x, y, b)
end

function love.keypressed(key)
	state:keypressed(key)
end

function love.keyreleased(key)
	state:keyreleased(key)
end
