#!/usr/local/bin/lua
--[[
--
-- table 的创建是 通过 ‘构造表达式’ 来完成的，最简单的构造表达式 {}，创建一个空表
-- 也可以在表里面添加一些数据直接初始化表
--
-- lua 中的表 (table) 其实是一个 ‘光联数据’（associative arrays）
-- 数组的索引可以是数字或者是字符串
--
--]]

-- 创建一个空表

local tab = {}

-- 直接初始化表
local tabinit = {'apple','pear','orager','grape'}

print("-----------------------------------------")

a = {}

a['key'] = 'value'
key = 10
a[key] = 22
a[key] = a[key] + 11
for k,v in pairs(a) do
    print(k..'-'..v)
end

-- 不同于其他语言 lua 中将表中的下标从 1 开始

for k, v in pairs(tabinit) do
    print("key",k)
end


-- table 不会固定长度大小，有新长度添加时table 会自动增长，没初始的 table 都是 nil

lentable = {}
for i=1,10,2 do
   lentable[i] = i
end
lentable['key'] = 'val'
print(lentable['key'])
print(lentable['none'])

----------------------------------------------------------
--
-- table 中根据索引取值主要提供了两种方式
--
-- tab[key]
--
-- tab.key
--
-- 本质上是一种类似 gettab_event(tab, key) 的函数调用
print(lentable[5])
print(lentable[2])
print(lentable.key)

