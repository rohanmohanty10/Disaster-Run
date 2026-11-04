 

local v1 = {}
local u2 = {
    [Enum.Material.Glass] = "rbxassetid://142082167",
    [Enum.Material.Brick] = "rbxassetid://142082166",
    [Enum.Material.Sand] = "rbxassetid://1436385526",
    [Enum.Material.Metal] = "rbxassetid://133758612",
    [Enum.Material.DiamondPlate] = "rbxassetid://133758612",
    [Enum.Material.Wood] = "rbxassetid://133758630",
    [Enum.Material.WoodPlanks] = "rbxassetid://133758630",
    [Enum.Material.Grass] = "rbxassetid://133758545",
    [Enum.Material.Ice] = "rbxassetid://133758600",
    [Enum.Material.Plastic] = "rbxassetid://267454199",
    [Enum.Material.SmoothPlastic] = "rbxassetid://267454199",
    [Enum.Material.Brick] = "http://www.roblox.com/asset/?id=168786259",
    [Enum.Material.Granite] = "http://www.roblox.com/asset/?id=168786259",
    [Enum.Material.Fabric] = "http://www.roblox.com/asset/?id=151760062",
    [Enum.Material.Marble] = "http://www.roblox.com/asset/?id=134464111",
    [Enum.Material.Pebble] = "http://www.roblox.com/asset/?id=180239547",
    [Enum.Material.Concrete] = "rbxassetid://481215525",
    [Enum.Material.CorrodedMetal] = "rbxassetid://133758612"
}
local function u5(p3) --[[ Line: 4 ]]
    local v4 = nil
    if p3.Parent and p3.Parent:FindFirstChild("Humanoid") then
        return p3.Parent:FindFirstChild("Humanoid")
    elseif p3.Parent.Parent and p3.Parent.Parent:FindFirstChild("Humanoid") then
        return p3.Parent.Parent:FindFirstChild("Humanoid")
    elseif p3.Parent.Parent.Parent and p3.Parent.Parent.Parent:FindFirstChild("Humanoid") then
        return p3.Parent.Parent.Parent:FindFirstChild("Humanoid")
    else
        return v4
    end
end
local u6 = {
    [Enum.Material.Metal] = true,
    [Enum.Material.CorrodedMetal] = true
}
function v1.impact(p7, p8, p9, p10, p11) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u2
    --]]
    if p8 then
        p7.CFrame = CFrame.new(p9, p9 + p10)
        local v12 = u5(p8)
        p7.Anchored = false
        p7.Material = Enum.Material.Neon
        _G.tween(p7, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            true,
            0
        }, {
            ["Color"] = BrickColor.new("Neon orange").Color
        })
        p7.Trail.Enabled = false
        if p11.remote and p11.ply == game.Players.LocalPlayer then
            p11.remote:FireServer(p9, p8, p11.delta)
        end
        if v12 == nil then
            if _G.checkRenderDistance(p7.Position) then
                if u6[p8.Material] == nil then
                    p7.ParticleEmitter.Color = ColorSequence.new(p8.Color)
                    p7.ParticleEmitter:Emit(2)
                    p7.ParticleEmitter2.Color = p7.ParticleEmitter.Color
                    p7.ParticleEmitter2:Emit(2)
                    p7.ParticleEmitter3.Color = p7.ParticleEmitter.Color
                    p7.ParticleEmitter3:Emit(2)
                else
                    p7.Spark:Emit(3)
                end
                p7.Attachment2.shock:Emit(1)
            end
            p7.Parent.Parent = workspace.Effects
            if u2[p8.Material] then
                local v13 = Instance.new("Sound", p7)
                v13.Volume = 0.75
                v13.SoundId = u2[p8.Material]
                v13.MaxDistance = 75
                v13.EmitterSize = 15
                v13:Play()
            end
            local v14 = script.Part:Clone()
            v14.Parent = workspace.Effects
            local v15 = math.random(200, 400) / 1000
            v14.Mesh.Scale = Vector3.new(v15, 0, v15)
            local v16 = CFrame.new(p9, p9 + p10)
            local v17 = CFrame.Angles
            local v18 = math.random(-360, 360)
            v14.CFrame = v16 * v17(1.5707963267948966, math.rad(v18), 0)
            if p8:IsDescendantOf(workspace.Env) == false then
                v14.Anchored = false
                local v19 = Instance.new("WeldConstraint", v14)
                v19.Part0 = p8
                v19.Part1 = v14
            end
            _G.destroy(v14, 3)
        else
            local v20 = script["Bullet_Flesh_" .. math.random(1, 6)]:Clone()
            v20.Parent = p7
            v20:Play()
            p7.Blood:Emit(15)
        end
    end
    _G.destroy(p7.Parent, 1)
    _G.destroy(p7, 1)
end
function v1.splash(p21, p22) --[[ Line: 86 ]]
    _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
        ["obj"] = p21,
        ["Strength"] = 25,
        ["Size"] = 7,
        ["cf"] = p22,
        ["PSize"] = NumberSequence.new(2, 0)
    })
end
function v1.Fire(_, p23, _) --[[ Line: 91 ]]
    p23.Hole.Attachment.Spark:Emit(5)
    p23.Hole.Attachment.Spark3:Emit(10)
    p23.Hole.Attachment.Smoke:Emit(15)
    local v24 = script.PointLight:Clone()
    v24.Parent = p23.Hole
    _G.tween(v24, {
        0.1,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        true,
        0
    }, {
        ["Range"] = 8,
        ["Brightness"] = 1
    })
    _G.destroy(v24, 0.2)
end
function v1.whiz(p25) --[[ Line: 102 ]]
    if p25 == nil then
        return true
    end
    local v26 = Instance.new("Attachment", workspace.Terrain)
    v26.WorldCFrame = p25.CFrame
    local v27 = script["bullet_whoosh_0" .. math.random(1, 5)]:Clone()
    v27.Parent = v26
    v27:Play()
    _G.destroy(v27, 1)
end
return v1