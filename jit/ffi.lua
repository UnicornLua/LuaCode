#!/usr/local/bin/lua

--[[
--
-- ffi 是 luajit 中最有价值的一个库，它极大的简化了在 lua 的代码中调用 c 接口的工作，
-- 不需要编写繁琐的 lua/c 绑定函数，只要在 lua 代码中嵌入函数或数据结构的声明，无需
-- 额外的代码即可直接访问，非常方便，而且执行效率比传统的方式更高。
-- -------------------------------------------------------------------------------
-- ffi 不仅可以调用 系统函数和 openResty 内部的函数，还可以加载 `.so` 形式的动态库
-- 调用动态库里的函数，从而轻松的扩展 lua 的功能。
--
--
--       noun    |    Explanation 
-----------------------------------------------------------------------------------
--    >  cdecl   |   A definition of an abstract C type (actually, is a lua string)
--    >  ctype   |   C type object
--    >  cdata   |   C data object
--    >  ct      |   C type format, is a template object, may be cdecl, cdata, ctype
--    >  cb      |   callback object
--    >  VLA     |   An array of variable length
--    >  VLS     |   An structure of variable length
--
--]]



-- 1. FFi.API


local ffi = require("ffi")

-- this is a function to load library of c code
-- which could search `libmath.so` (in Unix) or `math.dll` (in windows) in system dynanic library
ffi.load("math", true)


ffi.cdef [[

  int add(int x, int y);  /* This is a declare of c function */

]]


-- repare a file to generate libmath.so file and put into system library
-- [[
-----------------------------------------------------------------------
-- # file name  math.c
-- # file content
--
-- int add(int x, int y) {
--    return x + y;
-- }
-----------------------------------------------------------------------
--  then compiler a shared library
--
--  >$ gcc -g -c -o libmath.so  -fpic -shared math.c
--  >$ mv libmath.so /usr/lib64/
--
-- ]]


-- 在此就可调用 已经写好的 C 语言写好的动态库文件
local result = ffi.C.add(10, 20)
print(result)
