#!/usr/local/bin/lua
--[[
--
-- 函数是对语句和表达式进行抽象的主要方法；完成某些特定的功能和计算.
-- lua 提供了许多的内建函数，你可以恒方便的在程序中调用他们。
--
-- 主要用途：
--
-- 1、完成指定的任务，这种情况下函数作为调用语句使用；
-- 2、计算并返回值，这种情况下函数作为赋值语句的表达式使用
--
--]]


-- 1、函数定义
--
-- optional_function_scope function function_name( argument1, argument2, argument3..., argumentn)
--    function_body
--    return result_params_comma_separated
-- end
------------------------------------------------------------------------------------------
-- optional_function_scope                : 函数作用范围，默认是全局的，局部需要使用local 关键字
-- function                               : 关键字
-- function_name                          : 函数名称
-- (...）                                 : 函数的参数，可以是 0-ｎ个
-- function_body                          : 函数体，实际执行的过程
-- return                                 : 关键字
-- result_params_comma_separated          : 返回值（可以不返回），返回读个值得时候逗号隔开
-- end                                    : 函数结束符
-- ---------------------------------------------------------------------------------------
-- 函数传递基本的类型的时候是值传递，
-- 传递的是 table 类型的时候传递的是引用
--

local function print_some(str)
  print("==> " .. str .. " <==")
end

local function add(num1, num2, printer)
  local result = num1 + num2
  printer(result)
end

add(10, 7, print_some)


-----------------------------------------------------------------------------------------
-- 函数返回多个值
--
-- string.find(str,pattern) 返回匹配的起始和结束的下标
--
print("-----------------")
local s, e = string.find('www.runoob.com', 'runoob')
print(("result: %d - %d"):format(s, e))

-----------------------------------------------------------------------------------------
-- 可变参数
-- 函数的参数列表使用 ...
-- 固定参数和可变参数一起使用的时候，固定参数放在可变参数的前面

function add(...)
  local start = 0
  for _, v in ipairs { ... } do -- {...} 表示一个由所有变量组成的数组
    start = start + v
  end
  return start
end

print(add(1, 2, 3, 4, 5, 6, 7, 8, 9))


-- 可变参数可以使用变量进行接收

local function average(...)
  local result = 0
  local arg = { ... } -- arg 为一个表，局部变量
  for _, v in ipairs(arg) do
    result = result + v
  end
  -- print("总共传入 ".. #arg .. " 个数")
  -- 可以使用select("#",...) 获取参数的长度
  print("总共传入 " .. select("#", ...) .. " 个数")
  return result / select("#", ...)
end

print("平均值为: " .. average(1, 2, 3, 4, 5, 6, 7, 8, 9))
----------------------------------------------------------------------------------------
--select(selector, ...) 的使用, 传入一个选择器(固定的实参)和一个可变长参数
--通常使用可变长参数的时候，需要使用到 {...} 就可以了，但是可变长参数可能包含一些nil
--select("#",...) 返回的是可变长参数的长度
--select(n,...) 返回的是 n 开始到结束位置的所有参数列表

local function f(...)
  local a = select(3, ...)
  print(a) -- a 获取的是参数列表中最左侧的第一个，其余被忽略
  print(select(3, ...)) -- 打印 3和之后的所有的参数列表
end

f(0, 1, 2, 3, 4, 5)
---------------------------------------------------------------------------------------
--
-- 实例
--
do
  local function foo(...)
    for i = 1, select("#", ...) do -- 获取参数总数
      local arg = select(i, ...) -- 获取参数列表中从 i 开始的第一个
      print("arg: ", arg)
    end
  end

  foo(1, 2, 3, 5)
end


-- 函数返回值的接收，

local function init()
  return 1, 'lua'
end

-- 当返回多个值的函数在使用的时候，如果其所在的位置不在末尾，只能接收到返回值的第一位
-- 后续返回值都会被丢弃 (无论是被打印，还是被赋值到其他的变量的时候)
print(init(), 9)
print(9, init())

-- x = init() y = 9  z = nil
local x, y, z = init(), 9
print(x, y, z)

-- o = 9 , p,q = init()
local o, p, q = 9, init()
print(o, p, q)
