#! /usr/local/bin/lua

--[[
--
-- lua 中我们可以通过 key 来访问到 table 中 value 值，但是没有办法对两个表
-- 进行操作，因此 lua 中提供了原表（MetaTable) ,允许我们改变 table 的行为
-- 每个行为关联了对应的元方法。
--
-- ** 我们可以定义两个原表之间的操作,例如定义两个表的相加的操作，会先检查两个表中的一个之中
--    有元素，之后检查是否有一个叫 `__add` 的字段，若找到，则调用对应的值。
-- ** `__add` 等即时字段，其对应的值，往往是一个函数或者是table, 就是元方法
-- 
-- 1、有两个很重要的函数来处理元表。
--   
--   * setmetatable(table,metatable) -- 对指定的(table)设置元表（metatable）,如果
--              元表(metatable)中存在__metatable键值。setmsetmetatable 会失败
--   * getmetatable(table) 返回对象的元表（metatable)
--
--]]

local metatable = {} -- 元表

print(metatable)

--------------------------------------------------------------------------------------------
-- __index        元方法，当访问一个表中不存在的key 的时候会调用
-- __add      `+` 运算会调用
-- __sub      `-` 运算会调用
-- __tostring `转换为字符`
-- __lt       `<`
-- __gt       `>`
-- __mul      `*`
-- __mod      `/`
-- __unm      `取反`
-- __call     `函数调用`  可以让表当作一个函数被调用
-- __concat   `..`
-- __eq       `==`
-- ....
--
metatable.__add = function(t1, t2)
  local temp = {}
  for _, v in pairs(t1) do
    table.insert(temp, v)
  end
  for _, v in pairs(t2) do
    table.insert(temp, v)
  end
  return temp
end


metatable.__tostring = function(t)
  local s = "{"
  for i, v in pairs(t) do
    if (i > 1) then
      s = s .. ","
    end
    s = s .. v
  end
  s = s .. "}"
  return s
end


-- 当设置了这个原表之后，当表被当作函数调用的时候会自动执行这个 `__call` 函数
metatable.__call = function(_, ...)
  -- 输出所有调用的参数
  for _, v in pairs { ... } do
    print(v)
  end
end


-- 当我们在适用表的时候，当调用了一个不存在的索引的时候，会查找原表的 `__index` 并进行调用
-- `__index` 既可以是一个函数
-- `__index` 也是一个表
metatable.__index = function(_, key)
  return "It's a " .. key
end



local tab1 = { 1, 4, 8 }
local tab2 = { 2 }

setmetatable(tab1, metatable) -- 把 mymetatable 设为 mytable 的元表
print(getmetatable(tab1)) -- 这回返回mymetatable


-- 这样的行为需要自定义原表行为来操作，语言内部没有指定两个表之间的操作
-- 我们在原表中定义了__add  行为，这里的 `+` 才能在底层调用 __add 来完成对应的操作
-- 这里会依次查找 tab1 有没有原表，原表有没有 `__add`, tab2 有没有原表，原表有没有 `__add`
local t3 = tab1 + tab2

for k, v in pairs(t3) do
  print(("%s = %s"):format(k, v))
end

-- 改变了默认的打印内存地址的行为，内部调用了原表的 __tostring
print(tab1)

-- 将 tab1 当作一个函数进行调用，测试是否调用了 `__call` 函数
tab1(4, 5, 6)

-- 测试访问一个不存在的 key 的时候是否会自动调用 `__index`
print(tab1.unicorn)
