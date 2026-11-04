 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = require(script.Parent.BodyTransparency)
function v1.start(_, p4) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    Random.new()
    local v5 = p4:GetPivot()
    local v6 = Instance.new("AlignPosition")
    local v7 = p4.PrimaryPart.RootRigAttachment
    v6.Mode = 0
    v6.Attachment0 = v7
    v6.Position = (v5 * CFrame.new(0, 15, 0)).Position
    v6.Parent = p4
    v6.MaxVelocity = 60
    task.wait(0.5)
    _G.PlaySound(p4.PrimaryPart, script.Explosion2Grip)
    local v8 = script.Warn:Clone()
    v8.CFrame = p4:GetPivot()
    v8.Parent = workspace.Effects
    _G.customEmit(v8)
    task.wait(0.35)
    u3:start(p4)
    local v9 = script.DirtyFireworksExplosion:Clone()
    v9.CFrame = p4:GetPivot()
    v9.Parent = workspace.Effects
    _G.customEmit(v9)
    u2:Create(v9.Attachment.Light, TweenInfo.new(0.8), {
        ["Brightness"] = 0
    }):Play()
    _G.destroy(v9, 2.5)
    _G.destroy(v8, 2.5)
    _G.destroy(v6, 0.5)
end
return v1