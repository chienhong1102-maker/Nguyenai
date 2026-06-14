repeat task.wait() until game:IsLoaded()

task.wait(10) -- đợi thêm 10 giây cho game hiện GUI

local Vim = game:GetService("VirtualInputManager")

while task.wait(1) do
pcall(function()
Vim:SendMouseButtonEvent(500,300,0,true,game,0)
Vim:SendMouseButtonEvent(500,300,0,false,game,0)
end)
end
