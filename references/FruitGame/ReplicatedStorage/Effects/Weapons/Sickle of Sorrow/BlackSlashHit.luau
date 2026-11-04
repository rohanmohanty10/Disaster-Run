 

local v1 = {}
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v3 = RaycastParams.new()
v3.FilterType = Enum.RaycastFilterType.Include
v3.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local v4 = OverlapParams.new()
v4.FilterType = Enum.RaycastFilterType.Include
v4.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function v1.start(_, p5, p6, p7) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v8 = script.SlashExplosionModel:Clone()
    u2.apply(v8, p6)
    if p7 then
        v8:ScaleTo(p7)
    end
    v8.PrimaryPart.CFrame = p5
    v8.Parent = workspace.Effects
    _G.customEmit(v8)
    _G.destroy(v8, 5)
    if p7 == nil then
        _G.PlaySound(v8.PrimaryPart, script.boom)
    else
        _G.PlaySound(v8.PrimaryPart, script.boomCharged)
    end
end
return v1