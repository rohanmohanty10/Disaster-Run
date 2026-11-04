 

local u1 = game:GetService("TweenService")
game:GetService("ReplicatedStorage")
local v2 = {}
local u3 = workspace.Effects
local function u17(p4) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    local v5 = script.Spiral:Clone()
    v5.CFrame = p4.CFrame * CFrame.new(0, 3, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
    v5.Parent = u3
    _G.destroy(v5, 0.5)
    local v6 = TweenInfo.new(0.5, Enum.EasingStyle.Exponential)
    u1:Create(v5.Texture, v6, {
        ["Transparency"] = 1
    }):Play()
    u1:Create(v5.Mesh, v6, {
        ["Scale"] = Vector3.new(0.5, 0.75, 0.75)
    }):Play()
    local v7 = u1
    local v8 = {
        ["Position"] = v5.Position + Vector3.new(0, -4, 0)
    }
    local v9 = v5.Orientation
    local v10 = v5.Orientation.Y + -500
    v8.Orientation = v9 + Vector3.new(0, v10, 0)
    v7:Create(v5, v6, v8):Play()
    local v11 = script.Spiral2:Clone()
    v11.CFrame = p4.CFrame * CFrame.new(0, 3, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
    v11.Parent = u3
    _G.destroy(v11, 0.6)
    local v12 = TweenInfo.new(0.6, Enum.EasingStyle.Exponential)
    u1:Create(v11.Texture, v12, {
        ["Transparency"] = 1
    }):Play()
    u1:Create(v11.Mesh, v12, {
        ["Scale"] = Vector3.new(0.1, 1.1, 1)
    }):Play()
    local v13 = u1
    local v14 = {
        ["Position"] = v11.Position + Vector3.new(0, -4, 0)
    }
    local v15 = v11.Orientation
    local v16 = v11.Orientation.Y + 750
    v14.Orientation = v15 + Vector3.new(0, v16, 0)
    v13:Create(v11, v12, v14):Play()
end
function v2.start(_, p18) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u17
    --]]
    if _G.checkRenderDistance(p18.PrimaryPart.Position) ~= false then
        local v19 = p18:WaitForChild("HumanoidRootPart")
        local v20 = script.Paw:Clone()
        v20.CFrame = v19.CFrame * CFrame.new(0, 3, 0)
        v20.Parent = u3
        _G.customEmit(v20.Impact)
        task.wait(0.35)
        _G.customEmit(v20.ToEmit)
        _G.customEmit(v20.Smoke)
        u17(v19)
        _G.tween(v20, { 0.65, "MozillaCurve", "Out" }, {
            ["Size"] = Vector3.new(30, 30, 22.5),
            ["Transparency"] = 1
        })
        _G.destroy(v20, 1)
    end
end
return v2