#!/usr/local/bin/lua

--[[
--
-- Lua 数组：
--  1、一维数组
--
--
--
--
--]]

-- 数组使用索引进行访问，没有值返回的是 nil ,数字下标从 1 开始
local array = { "lua", "Tutorial" }

-- 可以在任意位置插入一个数据
table.insert(array, 1, "Ubuntu")

for i = 1, 2 do
	print(array[i])
end

-- 除了使用正数作为数组的下标，还可以使用负数作为数组的下标
local arr = {}

for i = -2, 3 do
	arr[i] = i * 2
end

print("---------------------------------------")
--
for i = -2, 2 do
	print(arr[i])
end

print("---------------------------------------")

-- 获取数组的长度
-- print(table.maxn(arr))  -- 这个函数在高版本中已经被删除了
-- #arr 获取到的长度不包含负数的索引，其获取的不是真正的长度，是正向最大的索引值
print(("length: %d"):format(#arr))
table.insert(arr, 4, 20)
print(("length: %d"):format(#arr))

--[[
-->  二维数组  <--
{
    {1,2,3},
    {2,4,6},
    {3,6,9}
}
--]]

local ar = {}
for i = 1, 3 do
	ar[i] = {}
	for j = 1, 3 do
		ar[i][j] = i * j
	end
end
--
--访问这个数组
--
for i = 1, 3 do
	for j = 1, 3 do
		print(ar[i][j])
	end
end
