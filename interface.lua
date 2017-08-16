
local interface = {
	tables = {}
}

function interface:add(t, item)
	if self.tables[t] == nil then
		self.tables[t] = {}
	end
	table.insert(self.tables[t], item)
end

function interface:clear(t)
	if self.tables[t] ~= nil then
		self.tables[t] = {}
	end
end

function interface:update(t)
	if self.tables[t] ~= nil then
		for _,item in ipairs(self.tables[t]) do
			item:update(love.timer.getDelta())
			item:draw()
		end
	end
end

function interface:mousepressed(t, x, y, b)
	if self.tables[t] ~= nil then
		for _,item in ipairs(self.tables[t]) do
			item:mousepressed(x, y, b)
		end
	end
end

return interface
