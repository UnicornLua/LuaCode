#!/usr/local/bin/lua

--[[
--
-- 研究一下对象的继承的实现
--
--]]

-- Meta class
local Shape = { area = 0 }

function Shape:new(o, side)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	side = side or 0
	self.area = side * side
	return o
end

-- 基础类的方法
function Shape:printArea()
	print("area is: " .. self.area)
end

local shap = Shape:new(nil, 10)
shap:printArea()

-- 继承是一个对象直接使用另一个对象的属性和方法, 可用于扩展基础类的属性与方法
-----------------------------------------------------------------------------

local Square = Shape:new()

-- Derived class method new
function Square:new(o, side)
	o = o or Shape:new(o, side)
	setmetatable(o, self)
	self.__index = self
	return o
end

function Square:printArea()
	print("this is a override method:" .. self.area)
end

local square = Square:new(nil, 5)
square:printArea()
