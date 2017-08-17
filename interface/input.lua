
local utf8 = require "utf8"

local input = {}
input.__index = input
setmetatable(input, {
	__call = function(cls, ...)
		return cls.new(...)
	end
})
function input.new(default, x, y, width)
	local self = setmetatable({}, input)
	self.default = default
	self.x = x
	self.y = y
	self.text = ""
	self.selected = false
	self.inside = false
	self.width = width or 150
	
	return self
end

function input:update(dt)
	local h = lg.getFont():getHeight(self.text)
	local mx,my = lm.getPosition()
	
	if mx > self.x and mx < self.x + self.width and my > self.y and my < self.y + h then
        if not self.inside then
			lm.setCursor(lm.getSystemCursor("ibeam"))
			self.inside = true
		end
    else
		if self.inside then
        	lm.setCursor(lm.getSystemCursor("arrow"))
			self.inside = false
		end
    end
	
end

function input:draw()
	local h = lg.getFont():getHeight(self.text)
	local xoff = lg.getFont():getWidth(self.text)
	
	if self.text == "" then
		lg.setColor(100,100,100)
		lg.print(self.default, self.x, self.y)
		lg.setColor(255,255,255)
	end
	
	lg.print(self.text, self.x, self.y)
	
    lg.line(self.x, self.y+h+2, self.x+self.width, self.y+h+2)
	if self.selected then
		lg.line(self.x+xoff+2, self.y, self.x+xoff+2, self.y+h)
	end
end

function input:mousepressed(x, y, b)
	if self.inside then
		self.selected = true
	else
		self.selected = false
	end
end

function input:keypressed(key)
	if not self.selected then return end
	if key == "backspace" then
		local offset = utf8.offset(self.text, -1)
		if offset then
			self.text = string.sub(self.text, 1, offset-1)
		end
	end
end

function input:textinput(text)
	if not self.selected then return end
	self.text = self.text .. text
	while lg.getFont():getWidth(self.text) > self.width do
		local offset = utf8.offset(self.text, -1)
		if offset then
			self.text = string.sub(self.text, 1, offset-1)
		end
	end
end

return input
