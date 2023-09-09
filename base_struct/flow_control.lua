#!/usr/local/bin/lua

--[[
--
-- 流程控制：条件为真时执行指定代码, 可以由多个分支(elseif)，
-- 和默认分支(else)
-- ------------------------------------------------------------------
-- if bool_express then
--    code_block
-- elseif bool_express then
--    code_block
-- else
--    code_block
-- end
-- ------------------------------------------------------------------
--
--]]

if 2 < 3 then
	print("2 < 3")
elseif 2 == 3 then
	print("2=3")
else
	print("2 > 3")
end
