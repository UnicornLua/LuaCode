
require("async")

Async.Init()


local frameCounter = 0
local ctx = CancellationTokenSource.new()

-- 将协程包装成异步任务
local task1 = Task.new(function()
  print("task1 start")
  Await(Task.Delay(1000, ctx:GetToken()))
  print("task1 end")
end, ctx:GetToken())

-- 1.使用Start 来启动任务
task1:Start()

-- 2.使用 Run 来启动任务
Task.Run(function()
  print("task2 start")
  Await(Task.Delay(2000, ctx:GetToken()))
  print("task2 end")
end, ctx:GetToken())

-- 3.多个任务并行
local t1 = Task.new(function()
  Await(Task.Delay(400, ctx:GetToken()))
  return 123
end, ctx:GetToken())

local t2 = Task.new(function()
  Await(Task.Delay(600, ctx:GetToken()))
  return 234
end, ctx:GetToken())

local t3 = Task.new(function()
  Await(Task.Delay(800, ctx:GetToken()))
  return 456
end, ctx:GetToken())

Task.Run(function()
  -- 多个任务并行获取结果，得到一个表，
  local result = Await(Task.WhenAll(ctx:GetToken(), t1, t2, t3))
  for index, value in ipairs(result) do
    print(index," = ", value)
  end
end, ctx:GetToken())

-- 4.多个任务竞态

local t4 = Task.new(function()
  Await(Task.Delay(800, ctx:GetToken()))
  return 123
end, ctx:GetToken())

local t5 = Task.new(function()
  Await(Task.Delay(1000, ctx:GetToken()))
  return 234
end, ctx:GetToken())

Task.Run(function()
  -- 返回的是首先完成的任务的索引
  local result = Await(Task.WhenAny(ctx:GetToken(), t5, t4))
  print("result", " = ", result)
end, ctx:GetToken())


--------------------------------------------------------------------

-- lua -i ./usage_async.lua 
-- 以交互的方式不停调用当前 Tick(0.2) 方法来模拟事件循环
--
function Tick(delta_time)
  Async.Update(delta_time)
  frameCounter = frameCounter + 1
  print("frameCounter: ".. frameCounter)
end
