-- 使用 print
--
local function use_print(str)
  print("print some thing" .. str)
end

-- 转换为字符串
--
local function use_tostring(num)
  print(tostring(num))
end

-- 判断数据的类型
--
local function use_type(str)
  print(type(str))
end

-- tonumber() 字符串转换为数字
--
local function use_tonumber(x)
  -- 字符串转换为数字
  print(tonumber(x))
end


use_print("hello")
use_tostring(10)
use_type("bingo")
use_tonumber("20")
