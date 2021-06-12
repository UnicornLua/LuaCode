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

mytable = {}                          -- 普通表
mymetatable = {}                      -- 元表
setmetatable(mytable,mymetatable)     -- 把 mymetatable 设为 mytable 的元表

getmetatable(mytable)                 -- 这回返回mymetatable 
--------------------------------------------------------------------------------------------
-- __index 元方法 这是 metatable 最常用的健，
