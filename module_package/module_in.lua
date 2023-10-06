#!/usr/local/bin/lua

--[[
----------------------------------------------------------------------------------------------
 模块结构就是一个表，因此可以像操作table里面的元素那样来操作模块里面的常量和函数

 Lua 中提供了一个 reqiure() 函数来加载模块，导入一个模块，只要使用函数加载就可以了

 require("<modulename>")  or require '<modulename>'

 执行require 之后会返回一个由模块常量或者函数组成的table,并且会定义一个包含该table
 的全局变量
----------------------------------------------------------------------------------------------

lua 中模块加载顺序：
  -- lua 语言模块加载规则
  -- lua 语言的模块搜索目录存在全局变量 package.path 内,这个全局变量的初始化根据设定的`LUA-PATH`

    环境变量的值来初始化，找到之后会使用 package.loadfile() 加载找到的文件。
  -- 上述位置找不到对应的 lua 模块，会加载C语言程序库。
  -- lua 语言加载 C 语言程序库目录存在于全局变量 package.cpath 内, 这个全局变量的初始化是根据
    设定的`LUA_CPATH` 环境变量。搜索的策略是与 lua 文件一致。但是程序加载的是 .so / .dll 文件
    找到之后会使用 package.loadlib() 函数来加载

  -- 一般编程语言与 C 语言交互，调用 C 语言 的函数库最简单的方式就是使用动态连接库的方式，
  -- lua 在 loadlib() 的函数内部提供了所有的动态连接功能，这个函数有两个参数
    （库的绝对路径, 初始化函数）典型的调用例子是:

   local path = "/usr/local/lib/libluasocket.so"
   local f = loadlib(path,"luaopen_socket")

  * 这个loadlib 函数打开指定的函数库并链接到lua,然而它并不打开库（在编程上体现为：斌没有执行
    初始化函数），反之他返回初始化函数作为 Lua 的一个函数，这样我们就可以直接在 lua 中调用
  * 如果加载动态库或者查找初始化函数出错，loadlib 将返回 nil 和错误信息，
-------------------------------------------------------------------------------------
  一般实际使用的时候，我们期望二进制的发布库包含一个stub 文件，安装二进制库的时候可以安装
  在任意合适的目录，使用的时候只需要修改 stub  文件中对应的二进制库的实际位置，然后将stub
  文件所在的位置加载到·LUA_PATH· 中，require 函数可直接加载到。

--]]

local module = require("module_package.module_out")

module.say()

-- print(package.path)

local code = require("module_package.code")
code.setup()
code.init()
code.config()
