#!/usr/local/bin/lua

--[[
--
-- 5.1 开始，lua 加入了模块化管理机制，可以将一些公用的代码放在一个文件中，以API
-- 接口的形式在其他地方调用，有利于代码的重用和减低代码的耦合度。
---------------------------------------------------------------------------------
--
-- Lua 的模块是由变量，函数等已知元素组成的 table,因此创建一个模块很简单，就是创建
-- 一个 table,然后将需要导出的函数，常量放在其中，最后返回这个 table 就行。
--
--]]

local module = {}

-- 定义一个常量
module.constant = "ONE,TWO,ThREE,FOUR"

-- 定义一个函数

function module.hello()
	io.write("hello lua")
end

-- 这是一个私有的函数，是不能通过外部来进行调用的
local function rich()
	print("this is privacy rich!")
end

function module.say()
	-- 在当前模块的内部，共有的函数是可以进行私有函数的调用的
	rich()
end

-- 将这个 module 返回出去，这样在其他按模块中就可以引入了
return module
