#!/usr/local/bin/lua
--[[
--
-- Lua 中的迭代器: 迭代器（iterator）是一种对象，它能够用来遍历标准模板库容器中的部分或全部元素
-- 每个迭代器对象代表迭代器中的确定地址。
-- lua 中的迭代器是一种支持指针类型的结构，它可以遍历集合的每一个元素。
--
-- pairs 与 ipairs  之间的区别
--
--
--  > 区别一：适用范围的不同
--     * pairs 即可遍历数组形式的表，也可以遍历键值对
--     * ipairs 只能遍历数组形式的表
--  > 区别二：遍历行为的不同
--     * pairs 遍历的时候，当碰到 nil 会跳过，继续向后遍历，直到遍历完所有的非 nil 的元素
--       在迭代混合形式的表的时候，内部是通过 hash 的形式来存储的，表现为：迭代的时候会先迭代数组元素，然后是键值对
--     * ipairs 遍历的时候，当从某个索引开始遍历，碰到 nil 的时候会结束遍历
--
--
--]]

----------------- 泛型 for 迭代器 -------------------------
--泛型for 在自己内部保存迭代函数，实际上它保存三个值：迭代函数，状态常量，控制变量。
--提供了集合的 （key/value） 对，语法格式如下：
--下面的代码中： k,v 为变量列表，pairs(tab) 为表达式列表

local tab = { "apple", "pear", "strawberry", "watermello" }

for k, v in pairs(tab) do
	print(k, v)
end

----------------- for 执行过程----------------------------
--1. 初始化变量，计算in 后面表达式的值，表达式应该返回泛型for 需要的三个值：
--   迭代函数，状态常量，控制表变量
--   与多值赋值的语法一样，如果返回多余变量，多余的将被舍弃。返回个数不足会使用 nil 填充
--
--2. 将状态常量与控制变量调用作为参数调用迭代函数（对于for结构来说，状态常量没有用处，仅仅
--   在初始化的时候获取它的值并传递给迭代函数）
--
--3. 将迭代函数返回的值赋值给变量列表。
--
--4. 如果返回的第一个值是 nil, 循环结束，否则继续执行循环体。
--
--5. 回到 2 再次执行迭代函数。

----------------------------------------------------------
--
-- lua 中我们常常使用函数来描述迭代器，每次调用该函数就返回集合的下一个元素，lua 中迭代器主要有
--
-- 1. 无状态的迭代器，
-- 2. 有状态的迭代器

--<< 1. 无状态的迭代器，是指不保留任何状态的迭代器，因此在循环中我们可以利用无状态迭代器
--     避免创建闭包花费额外的资源。
-- 每一次迭代，迭代函数都是用两个变量(状态常量，控制变量) 的值作为参数被调用，一个无状态的迭代器
-- 利用这两个值可以获取下一个元素。
-- 这种无状态的迭代器的典型例子就是ipairs,它遍历数组的每一个元素，元素的索引需要是数值，
-- 以下是一个函数实现迭代器的例子。

local function square(iteratorMaxCount, currentNumber)
	if currentNumber < iteratorMaxCount then
		currentNumber = currentNumber + 1
		return currentNumber, currentNumber * currentNumber
	end
end

for i, n in square, 3, 0 do
	print(i, n)
end

print("--------------------------------------------------")

-- 迭代的状态包括被遍历的表（循环过程中不会改变的状态常量）和当前的索引下标（控制变量）
-- ipairs 和 迭代函数都很简单，我们在Lua 中可以这样实现.

local function iter(a, i)
	i = i + 1
	local v = a[i]
	if v then
		return i, v
	end
end

function ipairs(a)
	return iter, a, 0
end

---<< 2. 多状态的迭代器，多数情况下，迭代器需要保存多个状态信息而不是简单的状态常量和控制变量
--最简单的方式就是使用闭包的方式来实现。还有一种实现方式就是将所有的的信息都封装到table内，将
--table 作为迭代器的状态常量，因为这种情况下可以将所有的信息存放在 table 内，所以迭代函数通常
--不需要第二个参数。
------------------------------------------------------------------------------
--以下实例，elementIterator 内部使用了闭包函数，实现计算集合大小并输出各个元素
local array = { "Google", "Runboo" }

local function elementIterator(collection)
	local index = 0
	local count = #collection
	-- 闭包函数
	return function()
		index = index + 1
		if index <= count then
			-- 返回迭代器的当前元素
			return collection[index]
		end
	end
end

for elemnt in elementIterator(array) do
	print(elemnt)
end
