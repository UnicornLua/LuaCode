#!/usr/local/bin/lua
--[[
--
--thread : Lua 中最主要的线程是协同程序（Coroutine）,它与（thread) 差不多，拥有自己的
--独立的栈，局部变量和指令指针，可以跟协同程序共享全局变量和其他大部分东西。
--
--线程跟协程的区别：线程可以同时多个运行，而协程任意时刻只能运行一个，并且处于运行状态的
--协程只有被挂起（suspend）才会暂停
--
----------------------------------------------------------------------------------------
--  1. coroutine.create() 创建一个 corountine, 参数是一个函数，当和 resume() 配合使用的时候就会唤醒函数调用
--
--  2. coroutine.resume() 重启一个 coroutine, 与 create() 配合使用
--
--  3. coroutine.yield()  挂起 coroutine, 将 coroutine 设置为挂起状态，这个函数与 resume() 配合使用的时候可以
--                        实现很多高级的效果
--  4. coroutine.status() 查看 coroutine 的状态，coroutine 的状态有三种 `dead`, `suspended`, `running` 
--
--  5. coroutine.wrap()   创建一个 coroutine, 返回一个函数, 一但你调用这个函数，就进入 coroutine，和 create 类似
--
--  6. coroutine.running() 返回正在跑的 coroutine, 一个 coroutine 就是一个线程，当使用 running 的时候，就是
--                         返回一个 coroutine 的线程号。
--
--]]


local function sum(num1, num2)
  print(coroutine.running())
  print(num1 + num2)
end

-- 1.使用一个函数参数创建一个协程
local co = coroutine.create(sum)

-- 启动一个协程程序, 使用 resume 进行唤醒
coroutine.resume(co, 2, 3)

-- 2.创建协程的第二种方式，这种方式创建的协程，可以直接传递参数启动
local cw = coroutine.wrap(sum)
cw(10, 20)



-- 协程中配 resume 与 yield 配合使用
print("-----------------------------------------------------")
so = coroutine.create(function()
  for i = 1, 10 do
    print(i)
    if i == 4 then
      print(coroutine.status(so))
      print(coroutine.running())
    end
    coroutine.yield()
  end
end);

coroutine.resume(so)
coroutine.resume(so)
coroutine.resume(so)
coroutine.resume(so)
coroutine.resume(so)

-- 再次查看 so 的状态
print(coroutine.status(so))
print(coroutine.running())
print("-----------------------------------------------------")



-- 测试协程执行过程中参数的传递
local function foo(a)
  print("foo 函数输入: " .. a)
  return coroutine.yield(a * 2)
end

local cot = coroutine.create(function(a, b)
  print(("第一次协程执行输出: %d-%d"):format(a, b))
  local r = foo(a + 1)

  print("第二次协程接收参数：" .. r)
  local s, z = coroutine.yield(a + b, a - b)

  print("第三次协程接收参数： ", s, z)
  return b, "end"
end)

print("main", coroutine.resume(cot, 1, 10))
print("main", coroutine.resume(cot, "r"))
print("main", coroutine.resume(cot, "x", "y"))
