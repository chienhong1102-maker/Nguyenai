repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

task.wait(10)

local Vim = game:GetService("VirtualInputManager")

while not Player.Character do
pcall(function()
Vim:SendMouseButtonEvent(500,300,0,true,game,0)
Vim:SendMouseButtonEvent(500,300,0,false,game,0)
end)
task.wait(1)
end

print("Character loaded, stopping clicks")
