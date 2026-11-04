 

local v1 = script.Parent:WaitForChild("Blade")
v1.Transparency = 1
local v2 = script.Parent.AnimationController:LoadAnimation(game.ReplicatedStorage.Modules.SwordHandle.Swords["Vera\'s Whip"].Idle)
v2:Play(0)
v2.Priority = Enum.AnimationPriority.Core
task.wait(0.1)
v1.Transparency = 0