 

local u1 = require(script.Bezier)
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local v3 = {}
local function u9(p4, p5) --[[ Line: 6 ]]
    local v6 = { p4 }
    for _, v7 in p4:GetDescendants() do
        table.insert(v6, v7)
    end
    for _, v8 in v6 do
        if (v8:IsA("ParticleEmitter") or (v8:IsA("BasePart") or (v8:IsA("PointLight") or (v8:IsA("Trail") or (v8:IsA("Highlight") or v8:IsA("Decal")))))) and v8:GetAttribute("recolorable") then
            if v8:IsA("Trail") or v8:IsA("ParticleEmitter") then
                v8.Color = ColorSequence.new(p5)
            elseif v8:IsA("Highlight") then
                v8.FillColor = p5
                v8.OutlineColor = Color3.new(1, 1, 1)
            elseif v8:IsA("Decal") then
                v8.Color3 = p5
            else
                v8.Color = p5
            end
        end
    end
    table.clear(v6)
end
function v3.start(_, p10, p11, p12) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u2
        [3] = u1
    --]]
    if _G.checkRenderDistance(p10.PrimaryPart.Position) == false then
        return
    elseif p11.PrimaryPart ~= nil then
        p11:SetPrimaryPartCFrame(p10.PrimaryPart.CFrame * CFrame.new(0, 0, -2) * CFrame.Angles(0, 3.141592653589793, 0))
        task.wait(0.1)
        task.wait(0.51)
        local v13 = p10.PrimaryPart.CFrame
        local v14 = script.throw:Clone()
        u9(v14, p12)
        u2.apply(v14, p10)
        v14.CFrame = v13 * CFrame.new(1, 0, -3.5)
        v14.Parent = workspace.Effects
        _G.customEmit(v14)
        _G.destroy(v14, 4)
        local v15 = Instance.new("Highlight")
        v15.OutlineTransparency = 1
        v15.DepthMode = Enum.HighlightDepthMode.Occluded
        v15.FillTransparency = 1
        v15.OutlineColor = p12
        v15.FillColor = p12
        u9(v15, p12)
        v15:SetAttribute("UniqueID", "f2b3c4d5-e6f7-4a89-0123-000000000002")
        u2.apply(v15, p10)
        v15.Parent = p10
        _G.tween(v15, {
            0.5,
            "EntranceExpressive",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["OutlineTransparency"] = 0,
            ["FillTransparency"] = 0.8
        })
        _G.destroy(v15, 1)
        local v16 = {
            "RightHand",
            "LeftHand",
            "RightUpperHand",
            "LeftUpperHand"
        }
        for _, v17 in p10:GetChildren() do
            if table.find(v16, v17.Name) then
                local u18 = script.aura:Clone()
                u9(u18, p12)
                u2.apply(u18, p10)
                u18.Parent = v17
                task.delay(1, function() --[[ Line: 78 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    u18.Enabled = false
                    _G.destroy(u18, 3)
                end)
            end
        end
        _G.PlaySound(p10.PrimaryPart, script.CyborgGrabChargeShoot)
        task.wait(1.05)
        local v19 = script.fire:Clone()
        u9(v19, p12)
        u2.apply(v19, p10)
        v19.CFrame = v13 * CFrame.new(0, 0, -2)
        v19.Parent = workspace.Effects
        _G.tween(v19.PointLight, {
            0.4,
            "Quad",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0
        })
        _G.customEmit(v19)
        _G.destroy(v19, 6)
        local v20 = script.Projectile:Clone()
        u9(v20, p12)
        u2.apply(v20, p10)
        v20.CFrame = v13 * CFrame.new(0, 0, -2)
        v20.Parent = workspace.Effects
        _G.destroy(v20, 30)
        local v21 = p11.PrimaryPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
        local v22 = v20.CFrame
        local v23 = v21.Position
        local v24 = (v22.Position - v23).Magnitude
        local v25 = Random.new()
        local v26 = p11.PrimaryPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
        local v27 = v20.CFrame
        local v28 = v26.Position
        local v29 = v25:NextNumber(-0.23809523809523808, 0.12195121951219513)
        local v30 = v25:NextNumber(1 / v24, 0.2173913043478261)
        local v31 = -v25:NextNumber(0.25, 1)
        local v32 = Vector3.new(v29, v30, v31) * v24
        local v33 = v27.Position + v27.LookVector * v24 / 12 + v32
        u1.new(v27.Position, v33, v28)
        local v34 = v24 / 200
        _G.tween(v20, {
            v34,
            "EntranceExpressive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = v26
        })
        task.wait(v34)
        v20.Transparency = 1
        local v35 = script.explosion:Clone()
        u9(v35, p12)
        u2.apply(v35, p10)
        v35.CFrame = p11.PrimaryPart.CFrame
        v35.Parent = workspace.Effects
        _G.customEmit(v35)
        _G.PlaySound(v35, script.CyborgGrabBoom)
        _G.destroy(v35, 8)
        for _, v36 in ipairs(v20:GetDescendants()) do
            if v36:IsA("ParticleEmitter") then
                v36.Enabled = false
            end
        end
        _G.destroy(v20, 4)
    end
end
return v3