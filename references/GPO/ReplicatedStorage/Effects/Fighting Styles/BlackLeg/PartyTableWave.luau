 

local v1 = {}
local function u17(p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12) --[[ Line: 3 ]]
    local v13 = script.Part:Clone()
    if p12 then
        v13 = script[p12]:Clone()
    end
    v13.CFrame = p2
    if p11 then
        v13.Material = p11
    end
    if p3 then
        v13.CFrame = p3
    end
    v13.BrickColor = p4
    if p6 then
        v13.Size = p6
    end
    v13.Transparency = p8 == nil and 0 or p8
    _G.destroy(v13, p7)
    local v14 = {
        p7,
        Enum.EasingStyle.Exponential,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }
    local v15 = p9 and {
        p7,
        p9,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    } or v14
    local v16 = {
        ["Size"] = p5,
        ["CFrame"] = p2,
        ["Transparency"] = 1
    }
    if p10 then
        v16.Color = p10
    end
    v13.Parent = workspace.Effects
    _G.tween(v13, v15, v16)
end
local u18 = require(game.ReplicatedStorage.Modules.FastWait)
function v1.start(_, p19, p20) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u17
    --]]
    if _G.checkRenderDistance(p19.HumanoidRootPart.Position) ~= false then
        local v21 = script.dust:Clone()
        v21.Parent = workspace.Effects
        _G.destroy(v21, 10)
        local v22 = Instance.new("Weld")
        v22.Parent = p19.HumanoidRootPart
        v22.Part0 = p19.HumanoidRootPart
        v22.Part1 = v21
        v22.C0 = CFrame.new(0, -p19.Humanoid.HipHeight - 1, 0)
        local v23 = -p19.Humanoid.HipHeight - 1
        while p20.Parent ~= nil and (p19.Humanoid.Health > 0 and p19.Parent ~= nil) do
            u18(0.05)
            local v24 = p19.HumanoidRootPart.CFrame
            local v25 = CFrame.Angles
            local v26 = math.random(-360, 360)
            local v27 = v24 * v25(0, math.rad(v26), 0)
            local _ = p19.HumanoidRootPart.CFrame * CFrame.new(0, v23, 0)
            local v28 = BrickColor.new("Really black")
            local v29 = Color3.fromRGB(0, 0, 0)
            if math.random(1, 2) == 1 then
                v29 = Color3.fromRGB(255, 255, 255)
                v28 = BrickColor.new("White")
            end
            local v30 = Ray.new(p19.HumanoidRootPart.CFrame.Position, p19.HumanoidRootPart.CFrame.upVector * -(p19.Humanoid.HipHeight * 2))
            local v31, _, _ = _G.raycastIgnoreList(v30, {
                p19,
                workspace.Effects,
                workspace.Projectiles,
                workspace.PlayerCharacters,
                workspace.Ragdolls
            })
            if v31 then
                v21.Attachment.sm2.Enabled = true
                v21.Attachment.sm2.Color = ColorSequence.new(v31.Color)
            else
                v21.Attachment.sm2.Enabled = false
            end
            u17(v27 * CFrame.new(2, math.random(-10, 10) / 10 + 2, 0), v27, v28, Vector3.new(10.5, 0, 13.5), Vector3.new(2.625, 0.01875, 3.375), math.random(15, 35) / 100, nil, Enum.EasingStyle.Back, v29, Enum.Material.Neon)
        end
        v21.Attachment.sm2.Enabled = false
        _G.destroy(v21, 1)
    end
end
return v1