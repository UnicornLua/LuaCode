#!/usr/local/bin/lua

--[[
--
-- function : lua 中函数被看作是 '第一类值(First-Class Value)' 函数就可以存在变量里面
--
--]]

local function factorial(n)
	if n == 0 then
		return 1
	else
		return n * factorial(n - 1)
	end
end

print(factorial(5))
local fac = factorial
print(fac(5))

-- function 可以是匿名函数(anonymous function) 的方式通过参数传递

local function anonymousFun(tab, fun)
	for k, v in pairs(tab) do
		print(fun(k, v))
	end
end

local tab = { key1 = "val1", key2 = "val2" }
anonymousFun(tab, function(key, val) --匿名函数
	return key .. "=" .. val
end)
