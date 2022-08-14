#!/usr/local/bin/lua
--[[
--
-- Lua 中的错误一般是分为
-- > 语法错误，程序编译期会出错，这样的异常是可以通过修改语法语句，修正错误，
-- > 另外一种是运行时的错误，运行时错误编译期时不会出现错误的，程序运行过程中
--   出现的异常，错误。没有做适当的处理导致程序异常或终止。
--------------------------------------------------------------------------
-- lua 中错误的处理
--  * assert(v [,message]) 此函数会针对第一个表达式进行判定，当表达式为True时，不做任何处理
--    当表达式为 false 的时候，第二个参数作为错误信息被抛出
--  
--  * error (message [,level]) 直接抛出错误，终止当前正在执行的程序，并指定错误信息（message)
--    同时可以指定错误的级别，打印不同的错误提示信息。这个位置信息添加到错误信息头部。
--     1、level = 1 [default] 默认级别，提示信息为：调用error 位置(文件 + 行号)
--     2、level = 2 提示信息为：指出哪个调用 error 的函数的函数
--     3、level = 0 提示信息为：不添加错误的位置细信息
--
--  * pcall(f [,arg{...}])
--  
--     使用该函数包装需要执行的代码，pcall 接收一个函数，并接收这个函数需要的参数，并执行
--     返回执行的结果，true / false, errorinfo
--
--  * xpcall(f ,msgh [,arg{...}])
--   
--     这个函数与上一个函数的不同在于，pcall 函数可以捕获函数执行的任何错误，但是我们希望
--     获得更多的调试信息，而不是发生错误的位置，但是 pcall 返回时已经销毁了堆栈信息。
--     xpcall 这个函数可以接收第二个参数（一个错误处理函数，当发生错误时，lua会在调用栈展开
--     前调用错误处理函数，于是就可以在这个函数中使用debug库来获取额外信息了）
--
--  * debug 库提供了两个通用的错误处理函数
--    
--     debug.debug: 提供一个 lua 提示符，让用户来检查错误的原因
--     debug.traceback: 根据调用栈来构建一个扩展的错误消息
-- 
--]]

local function hello(str)
  print(str)
  --error("error...")
end

if pcall(hello, "hello") then
  -- 没有错误
  print("没有错误!!")
else
  -- 一些错误
  print("发现错误!!")
end

-------------------------------------------------------------------------------------
local msg, errorinfo = pcall(
  function(i)
    print(i)
    error("error..", 2)
  end,
  "pcall")

print(msg, errorinfo)
-------------------------------------------------------------------------------------
local xmsg = xpcall(
  function(i)
    print(i)
    error("error..")
  end,
  function(err)
    print("--> " .. err)
    print(debug.traceback())
  end,
  "xpcall")
print(xmsg)

-------------------------------------------------------------------------------------
local function myfunction(n)
  n = n / nil
  return n
end

local function myerrorhandle(err)
  print("ERROR:", err)
end

local status = xpcall(myfunction, myerrorhandle)
print(status)
