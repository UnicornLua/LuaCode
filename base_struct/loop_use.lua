#!/usr/local/bin/lua

-- [[
--
-- lua 中提供了三种的循环可以被使用
--
--]]

-- 1. while 循环
local a = 0
while (a < 10) do
  print(("hello: %s"):format("lua"))
  a = a + 1
end


-- 2. for 循环
for i = 1, 10, 2 do
  print(("NO.%d"):format(i))
end


-- 3. repeat .. util  (循环直到条件成立)
repeat
  print(("repeat %s "):format("..until"))
  a = a + 1
until (a > 20)


-- break 可以终止循环
local season = { "spring", "summer", "autumn", "winter" }
for i, v in ipairs(season) do
  if v == "autumn" then
    break
  end
  print(("%d: %s"):format(i, v))
end


-- goto 跳转到指定的标签
local x = 1
-- 定义了一个标签，程序中执行的时候，可以使用goto 关键字回到这个标签的位置继续执行
::again::
print("---- goto label ----")

if x < 3 then
  x = x + 1
  goto again
end
