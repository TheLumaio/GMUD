local Label = {}
Label.__index = Label
setmetatable(Label, {
    __call = function (cls, ...)
        return cls.new(...)
    end
})
function Label.new(string, x, y)
    local self = setmetatable({}, Label)
    self.string = string
	self.rawstr = ""
    self.x = x
    self.y = y
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

function Label:update(dt)
    local mx, my = lm.getPosition()
    local font = lg.getFont()
    local w,h = font:getWidth(self.rawstr), font:getHeight(self.rawstr)
    
    if mx > self.x and mx < self.x + w and my > self.y and my < self.y + h then
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

function Label:draw()
    local font = lg.getFont()
    local w,h = font:getWidth(self.rawstr), font:getHeight(self.rawstr)
    lg.print(self.string, self.x, self.y)   
end

return Label
