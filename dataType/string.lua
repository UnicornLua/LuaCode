#!/usr/local/bin/lua

-- [[
--
--  string 类型的数据，声明的时候使用 ’‘  或 ""  包裹
--  无论是单引号还是双引号，转义`\s`符号都是可以使用的，
--
--  使用   [[  ]]  包裹一个文本块, 文本块中的所有字符都是
--  原本的含义。所有的转义字符都不可用
--
-- ]]

local name = "alex"
local gender = "maria"

local html = [[
<html>
    <head>
        <title>this is test string block demo!!</title>
    </hrad>
    <body>
        <div>
            <h3>this is test string block demo!!</h3>
        </div>
    </body>
</html>
]]

print(name)
print(gender)
print(html)

print("----------------------------------------------------")

-- 数字字符串会进行数学运算

print("2" + "6") -- 8.0

print("2e2" * 5) -- 1000.0

print("2 + 6")

-- 字符串之间的拼接运算使用的是 ..

print("2" .. "6") -- 26
print("error:" .. "2009")

print("----------------------------------------------------")

-- 使用 # 或取字符串的长度

print(#name)
print(#gender)
print(#html)
print(#"hello world")

--[[
-------------------------------------------------------------------------------------
-- String api for operate
--
-- 1、特殊字符需要使用转译字符来表示  '\'
--
-- 2、string.upupper(str), string.lower(str)
--
-- 3、string.gsub(str, parttern, replace, [,n])
--
--      * 将字符串中符合模式的串替换为新串，指定替换的匹配次数，默认全部替换
--
-- 4、string.find(str, substr, [init,[end] ])
--
--      * 从指定的起始结束位置找到匹配的内容，返回匹配位置的起始结束下标,没有返回nil
--
-- 5、string.reverse(str)             -- 字符串倒序
--
-- 6、string.format(template,...)     -- 格式化输出
--
-- 7、string.len(str)                 -- 字符串长度
--
-- 8、string.char(...), string.byte(str,i)  -- 字符与编码之间的相互转换
--
-- 9、string.rep(str,times)           -- 将字符重复指定的次数
--
-- 10、string.gmatch(str,pattern)     -- 根据模式全局匹配符合的字符串
--
--      * 返回迭代函数，每一次调用这个函数，返回一个在字符串str 中找到符合模式
--      的字串，如果参数 pattern 描述的字符串没有找到，迭代函数返回 nil
--
-- 11、string.match(str,pattern,init) -- 从指定位置匹配内容
--
--      * 返回源字符串中第一个符合条件的配对，参数 init 可选，指定起始位置，
--      默认为 1，没有匹配返回 nil
--
-- 12、string.sub(s,init,end)          -- 截取字符串,end 默认为 -1  最后一个字符
--
--]]

-- 2
print(string.upper("hello"))
print(string.lower("hello"))
-- 3
print(string.gsub("tomorrow", "o", "e"))
print(string.gsub("tomorrow", "o", "e", 2))
-- 4
print(string.find("hi young man,hi young man", "oun", 5))
-- 5
print(string.reverse("lua"))
-- 6
print(string.format("values length: %d", #"values"))
-- 7
print(string.len("anonymous"))
-- 8
print(string.char(98, 99, 100)) -- 三个编码对应的字符
print(string.byte("abcd", 2)) -- 第二个字符对应的编码
print(string.byte("abc", 1, 3)) -- 转换 1~3 位
print(string.byte("abcd")) -- 默认转换第一个
print(string.byte("abcd", -2)) -- 转换倒数第二个
print(string.char(255))
print(string.char(0))
-- 9
print(string.rep("o-^-o\n", 10))
-- 10
for word in string.gmatch("Hello lua user", "%a+") do
	print(word)
end
-- 11
print(string.match("I have 2 question for you", "%d+ %a+"))
print(string.match("I have 2 question for you", "(%d+) (%a+)"))

-- 12
print(string.sub("long long ago", 6, 8)) -- 6-8 号子串
print(string.sub("long long ago", -3)) -- 最后第三个子串
print(string.sub("long long ago", -100)) -- 最后100字符子串（超出索引，直接原样输出）
