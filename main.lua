lg = love.graphics
lm = love.mouse

lg.setDefaultFilter("linear", "linear")
local font = lg.newFont("data/cherry.ttf", 7)
font:setFilter("linear", "linear")

local Text = require "text"

local ui = {}

function love.load()
    lg.setFont(font)
    
    table.insert(ui, Text("This is a simple label", 100, 100))
    table.insert(ui, Text("This is a link label", 100, 125, true))
end

function love.update(dt)
    for i,v in ipairs(ui) do
        v:update(dt)
    end
end

function love.draw()
    for i,v in ipairs(ui) do
        v:draw()
    end
end
