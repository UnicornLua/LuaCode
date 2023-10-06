#!/usr/local/bin/lua

--[[
-- jit 中对表进行了加强
--]]

-- 1. table.new 提供了初始化表空间大小的能力
local table_new = require("table.new")
local t = table_new(10, 0)

-- 2. table.clone  提供拷贝表的能力，这是浅拷贝，
--    这个方法实现的拷贝在速度上远超自己循环实现的拷贝
local table_clone = require("table.clone")
local t2 = table_clone(t)

for k, v in pairs(t2) do
	print(("%s - %s"):format(k, v))
end

-- 3. table.clear  提供了清空表的能力，但是保留了之前为表分配的空间
local table_clear = require("table.clear")
table_clear(t)

for k, v in pairs(t) do
	print(("%s - %s"):format(k, v))
end
