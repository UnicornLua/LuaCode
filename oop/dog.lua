#!/usr/local/bin/lua

local dog = {}

local mt = { __index = dog }

function dog:sleep()
	print("sleep.....")
end

function dog:eat(name)
	print("dog eat" .. name)
end

function dog:work()
	print("wa~~~~")
end

-- self 相当于 this, 表示当前对象
function dog:new()
	return setmetatable(self, mt)
end

return dog
