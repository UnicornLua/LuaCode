
local function producer()
  for i = 0, 3 do
    print("send" .. i)
    coroutine.yield(i)
  end
  print("End Producer")
end

local function consumer(value)
  repeat
    print("receiver: " .. value)
    value = coroutine.yield()
    
  until not value
  print("End consumer")
end

local producerCoroutine = coroutine.create(producer)
local consumerCoroutine = coroutine.create(consumer)

repeat
  local status, product = coroutine.resume(producerCoroutine)
  coroutine.resume(consumerCoroutine,product)
until not status

