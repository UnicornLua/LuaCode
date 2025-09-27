
--[[
-- 使用中介的方式来包装非对称协程，看起来就像是一个非对象的协程
--
--  > 非对称协程，协程之间是没有调用关系的，彼此之间是相互独立的
--]]

local core = {}

core.main = function() end
core.current = core.main

function core.create(f)
  local co = function(val)
    f(val)
    error("Coroutine ended")
  end
  return coroutine.create(co)
end

function core.transfer(co, ...)
  local parameter = table.unpack({...})
  while co do
    if core.current == core.main then
      if co == core.main then
        return
      end
      core.current = co
      local result = { coroutine.resume(co, parameter) }
      status, co = table.unpack(result, 1, 2)
      parameter = table.unpack(result, 3)
      core.current = core.main
    else
      core.current = core.main
      return coroutine.yield(co, ...)
    end
  end
end

local co1 = core.create(function()
  print(1)
  core.transfer(core.main)
  print("1 End")
end)

local co2 = core.create(function()
  print("2")
  core.transfer(co1)
  print("2 End")
end)

local co3 = core.create(function()
  print("3")
  core.transfer(co2)
  print("3 End")
end)

print("start")
core.transfer(co3)
print("end")



