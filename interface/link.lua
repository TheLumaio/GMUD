local Link = {}
Link.__index = Link
setmetatable(Link, {
    __call = function (cls, ...)
        return cls.new(...)
    end
})
function Link.new(string, x, y, func)
    local self = setmetatable({}, Link)
    self.string = string
	self.rawstr = ""
    self.x = x
    self.y = y
	self.func = func or function() end
	self.inside = false
	self.width = 0
	if type(string) == "table" then
		for i=2,#string,2 do
			self.rawstr = self.rawstr .. string[i]
		end
	else
		self.rawstr = self.string
	end
    return self
end

function Link:update(dt)
    local mx, my = lm.getPosition()
    local font = lg.getFont()
    local w,h = font:getWidth(self.rawstr), font:getHeight(self.rawstr)
    
    if mx > self.x and mx < self.x + w and my > self.y and my < self.y + h then
        if not self.inside then
	        lm.setCursor(lm.getSystemCursor("hand"))
			self.inside = true
		end
    else
		if self.inside then
        	lm.setCursor(lm.getSystemCursor("arrow"))
			self.inside = false
		end
    end
    
end

function Link:draw()
    local font = lg.getFont()
    local w,h = font:getWidth(self.rawstr), font:getHeight(self.rawstr)
    lg.line(self.x, self.y+h, self.x+w, self.y+h)
    
    lg.print(self.string, self.x, self.y)   
end

function Link:mousepressed(x, y, b)
	if self.inside then
		self.func()
	end
end

return Link
