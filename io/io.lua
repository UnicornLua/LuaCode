#!/usr/local/bin/lua
--[[
--
-- Lua 中 I/O 库用于读取和处理文件，分为简单模式(和 C 一样)，完全模式。
--  * 简单模式（simple model）拥有一个当前输入文件和当前输出文件，并提供针对这些文件
--    相关的操作。
--  * 完全模式（complete model) 使用外部的文件句柄来实现，它以一种面对对象的形式。将
--    所有的文件操作定义为文件句柄的方法。
---------------------------------------------------------------------------------------
-- 
-- 简单模式在做一些简单的文件操作的时候比较合适的，但在进行一些高级的文件操作的时候，
-- 简单模式就显得有点力不从心。例如同时读取多个文件，使用完全模式就比较合适。
-- 
--]]

--    file = io.open(filename [, mode])
--    mode 的形式有
--    r  （r+） 文件读取，文件必须存在，否则会报错。
--    w   (w+)  文件写入，文件有内容直接被清空，文件不存在会创建新文件
--    a   (a+)  文件追加，文件内容在末尾追加
--    b         二进制模式打开文件，是二进制文件的时候可以加上 `b`
--    +         表示文件可读可写
---------------------------------------------------------------------------------------

-- 只读方式打开文件
local file = assert(io.open("io/file/test.txt", "r"))

-- 设置默认的输入文件
io.input(file)

-- 输入文件第一行
print(io.read())

-- 关闭打开的文件
io.close(file)

-- 以附加的方式打开只读文件
file = assert(io.open("io/file/test.txt", "a"))

--设置默认输出文件为test.lua
io.output(file)
io.write("-- test.lua 文件末尾注释")

-- 关闭打开的文件
io.close(file)

----------------------------------------------
-- 完全模式 (以面向对象的方式来操作文件)
----------------------------------------------
local pfile = io.open("io/file/text.log", "r")

if pfile ~= nil then
	print(pfile:read())
	print(pfile:read())
	pfile:close()
end

local wfile = io.open("io/file/text.log", "a")
if wfile ~= nil then
	wfile:write("test total mode append content to file")
	wfile:close()
end
