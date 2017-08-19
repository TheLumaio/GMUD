
local interface = {
	tables = {}
}

function interface:add(t, item)
	if self.tables[t] == nil then
		self.tables[t] = {}
	end
	table.insert(self.tables[t], item)
	return #self.tables[t]
end

function interface:get(t, id)
	if self.tables[t] ~= nil then
		return self.tables[t][id]
	end
end

function interface:clear(...)
	local args = {...}
	for _,t in ipairs(args) do
		if self.tables[t] ~= nil then
			self.tables[t] = {}
		end
	end
end

function interface:update(...)
	local args = {...}
	for _,t in ipairs(args) do
		if self.tables[t] ~= nil then
			for _,item in ipairs(self.tables[t]) do
				item:update(love.timer.getDelta())
				item:draw()
			end
		end
	end
end

function interface:mousepressed(x, y, b, ...)
	local args = {...}
	for _,t in ipairs(args) do
		if self.tables[t] ~= nil then
			for _,item in ipairs(self.tables[t]) do
				if item.mousepressed then
					item:mousepressed(x, y, b)
				end
			end
		end
	end
end

function interface:keypressed(k, ...)
	local args = {...}
	for _,t in ipairs(args) do
		if self.tables[t] ~= nil then
			for _,item in ipairs(self.tables[t]) do
				if item.keypressed then
					item:keypressed(k)
				end
			end
		end
	end
end

function interface:textinput(e, ...)
	local args = {...}
	for _,t in ipairs(args) do
		if self.tables[t] ~= nil then
			for _,item in ipairs(self.tables[t]) do
				if item.textinput then
					item:textinput(e)
				end
			end
		end
	end
end

return interface
