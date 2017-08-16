local item = {}
item.__index = item
setmetatable(item, {
	__call = function (cls, ...)
		return cls.new(...)
	end
})
function item.new(name, desc, type, mods, options)
	local self = setmetatable({}, item)
	self.name = name
	self.description = desc or name .. "'s description"
	self.type = type or "Generic"
	self.value = math.random(10, 250)
	self.remove = false
	self.options = {
		{name="Inspect", func=function() print(self.description) end}
	}
	self.mods = mods or {}
	if options then
		for i,v in ipairs(options) do
			table.insert(self.options, v)
		end
	end
	
	if self.type == "Food" then
		table.insert(self.options, {name="Consume", func=function() self.remove = true end})
	end
	if self.type == "Armour" then
		table.insert(self.options, {name="Equip", func=function() --[[TODO: Equip]] end})
	end
	if self.type == "Boots" then
		table.insert(self.options, {name="Equip", func=function() --[[TODO: Equip]] end})
	end
	if self.type == "Helmet" then
		table.insert(self.options, {name="Equip", func=function() --[[TODO: Equip]] end})
	end
	if self.type == "Sword" then
		table.insert(self.options, {name="Equip", func=function() --[[TODO: Equip]] end})
	end
	if self.type == "Shield" then
		table.insert(self.options, {name="Equip", func=function() --[[TODO: Equip]] end})
	end
	
	return self
end

--[[
Applies modifiers to the name and returns a rich text table.

Modifier example:
{
	{"pre", "Slow", {100,100,100}},
	{"pre", "Legendary", {155,90,90}},
	{"post", "Fury", {155,155,90}},
	{"post", "Freezing", {90,90,155}}
}
]]
function item:getRichName()
	local str = {{255,255,255},self.name}
	local posts = 0
	for i,v in ipairs(self.mods) do
		if v[1] == "pre" then
			table.insert(str, 1, " " .. v[2] .. " ")
			table.insert(str, 1, v[3])
		elseif v[1] == "post" then
			if posts > 0 then
				table.insert(str, {100,100,100})
				table.insert(str, " and ")
			else
				table.insert(str, {255,255,255})
				table.insert(str, " of ")
			end
			table.insert(str, v[3])
			table.insert(str, v[2])
			posts = posts + 1
		end
	end
	print(tostring(str))
	return str
end

function item:getNormalName()
	local rich = self:getRichName()
	local str = ""
	for i=2,#rich,2 do
		str = str .. rich[i]
	end
	return str
end

return item
