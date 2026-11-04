 

local v1 = {}
local u2 = workspace.Effects
local _ = game["Run Service"]
game:GetService("TweenService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = require(v3.Modules.Client.WeaponVFXRecolor)
local u5 = script
function v1.start(_, u6, u7, p8) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u5
    --]]
    local u9 = game.Players.LocalPlayer.Character
    local u10 = script.SlamModel:Clone()
    u10:PivotTo(u6)
    if p8 ~= nil then
        local v11 = u10:GetChildren()
        for v12 = 1, #v11 do
            if v11[v12].Name == "Haki" then
                v11[v12].Transparency = 0
                v11[v12].Color = p8
            end
        end
    end
    u4.apply(u10, u9)
    u10.Parent = u2
    local v13 = u10.AnimationController.Animator:LoadAnimation(u5.Animation)
    v13:Play(0)
    _G.PlaySound(u6, script["Audio/MochiV2M2Whoosh"])
    for u14 = 1, 2 do
        task.delay(0.1, function() --[[ Line: 32 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u4
                [3] = u9
                [4] = u14
                [5] = u10
            --]]
            local u15 = u5:WaitForChild("DoughShotVFX"):Clone()
            u4.apply(u15, u9)
            u15.CFrame = (u14 == 1 and u10:FindFirstChild("Left_Base", true).WorldCFrame or u10:FindFirstChild("Right_Base", true).WorldCFrame) * CFrame.Angles(-1.5707963267948966, 0, 0)
            u15.Parent = workspace.Effects
            _G.customEmit(u15)
            task.delay(2, function() --[[ Line: 39 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                u15:Destroy()
            end)
        end)
    end
    v13.Stopped:Once(function() --[[ Line: 47 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u9
            [4] = u10
        --]]
        print("animation edned")
        for v16 = 1, 2 do
            local u17 = u5:WaitForChild("DoughDeleteVFX"):Clone()
            u4.apply(u17, u9)
            u17.CFrame = (v16 == 1 and u10:FindFirstChild("Left_Base", true).WorldCFrame or u10:FindFirstChild("Right_Base", true).WorldCFrame) * CFrame.Angles(-1.5707963267948966, 0, 0)
            u17.Parent = workspace.Effects
            _G.customEmit(u17)
            task.delay(2, function() --[[ Line: 58 ]]
                --[[
                Upvalues:
                    [1] = u17
                --]]
                u17:Destroy()
            end)
        end
        for _, v18 in ipairs(u10:GetDescendants()) do
            if v18:IsA("BasePart") then
                v18.Transparency = 1
            elseif v18:IsA("Decal") or v18:IsA("Texture") then
                v18.Transparency = 1
            end
        end
    end)
    task.delay(0.6, function() --[[ Line: 74 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u5
            [3] = u4
            [4] = u9
            [5] = u2
            [6] = u10
            [7] = u6
        --]]
        if u7 ~= nil then
            local v19 = u5.M2ImpactScaled:Clone()
            u4.apply(v19, u9)
            v19.CFrame = u7.CFrame
            v19.Parent = u2
            _G.customEmit(v19)
            _G.destroy(u10, 3)
            local v20 = u7.Position + u7.Normal * 0.01
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 20,
                ["Position"] = v20,
                ["DistanceRandomness"] = Vector2.new(0.5, 1),
                ["Duration"] = 3,
                ["TweenDuration"] = 1,
                ["Radius"] = 10.5,
                ["Direction"] = -u7.Normal * 15
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 6,
                ["RandomVelocityMagnitude"] = Vector2.new(-35, 35),
                ["Position"] = v20,
                ["Direction"] = Vector3.new(0, 55, 0),
                ["RaycastDirection"] = -u7.Normal * 15,
                ["Size"] = Vector3.new(0.7, 0.7, 0.7),
                ["TrailEnabled"] = true
            })
            _G.PlaySound(v19.CFrame, script["Audio/MochiV2M2GroundSmash"], {
                ["RandomPitch"] = true
            })
            _G.PlayEffect("MochiImpactDroplet", nil, CFrame.new(v20), 6, 1.5, 25, 0.4, 0.7, CFrame.new(v20, u6.Position).UpVector * 25 + Vector3.new(0, 15, 0), u9)
        end
    end)
end
return v1