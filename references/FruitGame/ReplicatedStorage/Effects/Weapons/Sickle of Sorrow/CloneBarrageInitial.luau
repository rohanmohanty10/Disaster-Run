 

local v1 = {}
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local _ = workspace.CurrentCamera
local v3 = RaycastParams.new()
v3.FilterType = Enum.RaycastFilterType.Include
v3.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local v4 = OverlapParams.new()
v4.FilterType = Enum.RaycastFilterType.Include
v4.FilterDescendantsInstances = { workspace }
function v1.start(_, p5) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    task.wait(0.3)
    local v6 = p5.PrimaryPart.CFrame
    local v7 = script.Slash:Clone()
    u2.apply(v7, p5)
    v7.CFrame = v6
    v7.Parent = workspace.Effects
    _G.destroy(v7, 1.5)
    _G.customEmit(v7)
end
return v1