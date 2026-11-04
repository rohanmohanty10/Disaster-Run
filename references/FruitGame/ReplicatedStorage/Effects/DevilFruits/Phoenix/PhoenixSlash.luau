 

local v1 = {}
game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage"):WaitForChild("Refrences"):WaitForChild("Phoenix")
require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Misc)
require(game:GetService("ReplicatedStorage").Util.ShakeCamera)
local _ = workspace.CurrentCamera
require(v2.Modules.Trail)
local u3 = require(v2.Modules.Slash)
require(game.ReplicatedStorage.Util.Tween)
require(v2.Effects.Flare)
function v1.start(_, p4, p5) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    u3.new(p4, p5):Emit()
end
return v1