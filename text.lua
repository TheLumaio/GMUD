local Text = {}
Text.__index = Text
setmetatable(Text, {
    __call = function (cls, ...)
        return cls.new(...)
    end
})
function Text.new(string, x, y, button, func)
    local self = setmetatable({}, Text)
    self.string = string
    self.x = x
    self.y = y
    self.button = button
	self.func = func or function() end
	self.inside = false
    return self
end

function Text:update(dt)
    local mx, my = lm.getPosition()
    local font = lg.getFont()
    local w,h = font:getWidth(self.string), font:getHeight(self.string)
    
    if mx > self.x and mx < self.x + w and my > self.y and my < self.y + h then
        if not self.inside then
	        if self.button then
	            lm.setCursor(lm.getSystemCursor("hand"))
	        else
	            lm.setCursor(lm.getSystemCursor("ibeam"))
	        end
			self.inside = true
		end
    else
		if self.inside then
        	lm.setCursor(lm.getSystemCursor("arrow"))
			self.inside = false
		end
    end
    
end

function Text:draw()
    local font = lg.getFont()
    local w,h = font:getWidth(self.string), font:getHeight(self.string)
    if self.button then
        lg.line(self.x, self.y+h, self.x+w, self.y+h)
    end
    
    lg.print(self.string, self.x, self.y)    
end

function Text:mousepressed(x, y, b)
	if self.inside then
		self.func()
	end
end

return Text
