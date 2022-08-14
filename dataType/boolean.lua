#!/usr/local/bin/lua


print('-------------------------------------------------')
if not nil then
  print("nil is false")
end

if 0 then
  print('0 is true')
end

if 2 then
  print('all number is true')
end

print("lua 中将 nil 和 false 认为是false, 其余都是true")
