local item = {}
item.__index = item
setmetatable(item, {
	__call = function (cls, ...)
		return cls.new(...)
	end
})
function item.new(name, desc)
	local self = setmetatable({}, item)
	self.name = name
	self.description = desc or name .. "'s description"
	self.value = math.random(10, 250)
	self.remove = false
	self.options = {
		{name="Consume", func=function() self.remove = true end},
		{name="Inspect", func=function() print(self.description) end}
	}
	return self
end

return item
