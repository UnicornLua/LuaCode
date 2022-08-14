#!/usr/local/bin/lua

--[[
--
-- Lua 语言实现面向对象的方式 ： 借助数据结构 table
--
--  `:` 的含义
--      > 表中使用 这个符号来定义方法的时候，会自动注入一个 self 的参数，表示 table 本身
--      > 使用这个符号来调用方法的时候，会默认在调用的时候添加一个 self 的实参，并且是放在第一位 
--      
--
--]]

local dog = require("oop.dog")

local alex = dog:new()

alex:work()
alex:eat(" buck")
