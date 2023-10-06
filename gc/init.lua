#!/usr/local/bin/lua

--[[
-- 
-- Lua 采用了自动内存管理，这意味着你不用操心新建的对象需要的内存如何被分配出来
-- 也不用考虑在对象不再被使用的时候怎样来释放他们所占用的内存。
-- -------------------------------------------------------------------------------
--
-- Lua 运行了一个 垃圾收集器 来收集所有的 死对象(即在 lua 程序中不可能再被访问到的对象)
-- 来完成自动内存管理的工作。 lua 中所有用到的内存. 如： 
--  > 字符串，
--  > 表，
--  > 用户数据，
--  > 函数，
--  > 线程，
--  > 内部结构
-- 等, 都符合内存自动管理
----------------------------------------------------------------------------------
--  collectgarbage(opt [, param])
--  opt : 
--      > "count"         -- 返回以 kb 为单位的 lua 占用的内存空间的大小
--      > "collect"       -- 手动进行一次垃圾回收
--      > "restart"       -- 重启垃圾回收器，回到自动垃圾回收
--      > "stop"          -- 停止垃圾回收器，直到下一次重启垃圾回收器，需要手动调用回收方法才会回收
--      > "step"          -- 单步运行垃圾回收，步长由 param 参数控制
--      > "setstepmul"    -- 返回步进倍率的前一个值
--      > "setpause"      -- 设置收集器的间歇率
--      > 
--
--]]

-- 1. 手动调用 collectgarbage 来收集垃圾

print(collectgarbage("count"))

-- 声明一个表之后查看内存占用情况
local _ = { "apple", "banana", "pear", "peach", "strawbbery" }

-- 返回占用的内存，以 k字节为单位返回，lua 占用的总内存数
print(collectgarbage("count"))

-- 进行一次完整的垃圾收集
collectgarbage("collect")

print(collectgarbage("count"))

-- 重启垃圾回收器

collectgarbage("restart")
print(collectgarbage("count"))

-- 调用这个函数之后，直到再次调用重启 restart 之前，需要手动调用垃圾回收才会进行回收
collectgarbage("stop")

--
