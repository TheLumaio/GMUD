lg = love.graphics
lm = love.mouse

lg.setDefaultFilter("linear", "linear")
lg.setLineStyle("rough")
lg.setLineWidth(1)
local font = lg.newFont("data/cherry.ttf", 7)
font:setFilter("linear", "linear")

local inv_state = require "inventory"

function love.load()
    lg.setFont(font)
	inv_state:init()
end

function love.update(dt)
	inv_state:update(dt)
end

function love.draw()
    inv_state:draw()
end

function love.mousepressed(x, y, b)
	inv_state:mousepressed(x, y, b)
end

function love.mousereleased(x, y, b)
	inv_state:mousereleased(x, y, b)
end

function love.keypressed(key)
	inv_state:keypressed(key)
end

function love.keyreleased(key)
	inv_state:keyreleased(key)
end
