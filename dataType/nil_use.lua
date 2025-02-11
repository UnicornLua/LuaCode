#!/usr/local/bin/lua

-- lua 语言中的 nil 值本身只有一个值 nil;
-- 它的另一个附加作用就是将全局变量或者表重新置为未使用

local Mab = { key1 = "val1", key2 = "val2", "val3", "val4" }

for k, v in pairs(Mab) do
	print(k .. "-" .. v)
end

Mab.key1 = nil

print("-------------------------------------------------")

for k, v in pairs(Mab) do
	print(k .. "-" .. v)
end

print("-------------------------------------------------")
-- nil 使用type 函数判断的时候返回的是 'nil' 字符串，做逻辑比较的时候需要使用字符串来比较

if type(nil) == nil then
	print("return nil")
elseif type(nil) == "nil" then
	print("return string")
end

print(math.floor(8.90))
