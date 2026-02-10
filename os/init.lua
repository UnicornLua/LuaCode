
--  lua 中没有 sleep, 借助操作系统函数
local function sleep(seconds)
  os.execute("sleep " .. tonumber(seconds))
end


local function mut(a)
  print("first: ".. a)
  a = coroutine.yield()
  print("second: ".. a)
  a = coroutine.yield()
  print("third: " .. a)
end

local cmut = coroutine.create(mut)

local a = 0
local status = true
local result
local function read()
  repeat
    status, result = coroutine.resume(cmut, a)
    a = a + 1
    sleep(1)
    print("a: " .. a)
    print(result)
  until not status
end

read()

