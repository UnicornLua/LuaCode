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
array = {"lua","Tutorial"}

for i = 0,2 do
    print(array[i])
end


-- 除了使用正数作为数组的下标，还可以使用负数作为数组的下标
arr = {}

for i = -2, 2 do
    arr[i] = i *2
end

print('---------------------------------------')
--
for i = -2,2 do
    print(arr[i])
end

print('---------------------------------------')
--[[
-->  二维数组  <--
{
    {1,2,3},
    {2,4,6},
    {3,6,9}
}
--]]

local ar = {}
for i = 1,3 do
    ar[i] = {}
    for j = 1,3 do
        ar[i][j] = i * j
    end
end
--
--访问这个数组
--
for i = 1,3 do
    for j = 1,3 do
        print(ar[i][j])
    end
end
