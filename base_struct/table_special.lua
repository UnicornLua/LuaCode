#!/usr/local/bin/lua

--[[
--
-- table 是 lua 中特有的功能强大的东西，他是一种可以帮助我们创建不同数据类型的数据结构
-- table 是不固定大小的，可以根据需要机型扩容，当没有引用指向它的时候内存就会被回收
--
-- lua 中也是通过 table 来解决(module),(package),(Object) 的. 例如：string.format() 
--     表示使用 format 来索引table string 
--
--]]

-- 构建，初始化一个空表
local tab = {}

-- 给表中添加元素
tab[1] = 'apple'

-- 移除引用，内存回收
-- tab = nil

-- 当我们将 table 赋值给 a, 再将 a 赋值给 b, 如果将 a 设置为 nil, 则 b 同样能访问 tab
-- 中的元素，如果没有指定的变量指向 a, lua 的垃圾回收机制会清理相应的内存。

print("tab 的类型是：" .. type(tab))

-- 让两个对象同时指向同一个table

local alterTab = tab

-- 访问修改表中元素
print(alterTab[1])
alterTab[1] = 'pear'
print(tab[1])

-- 释放变量
alterTab = nil
print(tab[1])

tab = nil
print("tab : ", tab)

------------------------------------------------------------------------
--[[  table.concat(tab,sep,start,end) ]]
------------------------------------------------------------------------


local fruits = { 'banana', 'orange', 'apple' }

--返回连接后的字符串
print('默认的连接', table.concat(fruits))

--指定连接符
print("指定连接符: ", table.concat(fruits, ', '))

-- 指定连接位置
print('指定连接位置: ', table.concat(fruits, '-', 2, 3))


print("----------------------------------------------------------------")


------------------------------------------------------------------------
--[[  table.insert(tab,pos,value) ]]
------------------------------------------------------------------------

-- 默认从末尾插入
table.insert(fruits, 'watermellon')
print(fruits[4])

-- 指定位置插入
table.insert(fruits, 2, 'blue')
print(fruits[2])

------------------------------------------------------------------------
--[[  table.remove(tab,pos) ]]
------------------------------------------------------------------------

-- 默认从最后一个元素开始移除
table.remove(fruits)
for k, v in pairs(fruits) do
  print(k, v)
end

print("----------------------------------------------------------------")

-- 指定移除的元素的索引
table.remove(fruits, 2)
for k, v in pairs(fruits) do
  print(k, v)
end

print("----------------------------------------------------------------")

------------------------------------------------------------------------
--[[  table.sort(tab)  正序排列 ]]
------------------------------------------------------------------------

table.sort(fruits)
-- 排序后

table.remove(fruits, 2)
for k, v in pairs(fruits) do
  print(k, v)
end

------------------------------------------------------------------------
--[[  table.maxn(tab) 该方法在 5.2 之后已经被移除，自定义个一个实现 ]]
------------------------------------------------------------------------

local function table_maxn(t)
  local mn = nil
  for _, v in pairs(t) do
    if mn == nil then
      mn = v
    end
    if mn < v then
      mn = v
    end
  end
  return mn
end

tab = { 1, 5, 8, 0, 3, 6, 10 }
print("tab max_value: ", table_maxn(tab))
print("tab length: ", #tab)

------------------------------------------------------------------------
--
-- 当我们获取 table 长度的时候，无论是使用 table.getn 还是 #,都会在索引中
-- 断的时候终止计数，导致无法正确获取 table 长度
--
table = {}

table[1] = 12
table[3] = 34
print("table length:", #table)

-- 自己写一个函数来计算 table 的 长度
local function table_length(t)
  local len = 0
  for _ in pairs(t) do
    len = len + 1
  end
  return len
end

print("table length: ", table_length(table))
