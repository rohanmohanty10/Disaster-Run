 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = game:GetService("Players")
local u3 = game:GetService("TweenService")
require(v1.Modules.CraterHandler)
require(v1.Modules.ParticleTween)
local u4 = require(v1.Modules.Client.WeaponVFXRecolor)
local _ = v2.LocalPlayer
local u5 = workspace.Effects
function Flipbook(p6, u7, u8, u9)
    local u10 = p6:FindFirstChildOfClass("SpecialMesh")
    if u10 and u7 then
        task.spawn(function() --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u10
                [3] = u8
                [4] = u9
            --]]
            for v11 = 1, #u7 do
                u10.TextureId = u7[v11]
                task.wait(1 / u8)
            end
            if u9 == true then
                u10.Parent:Destroy()
            end
        end)
    end
end
local function u22(p12, p13, p14) --[[ Line: 36 ]]
    local function v20(u15, p16, p17) --[[ Line: 37 ]]
        for _, v18 in ipairs(u15:GetDescendants()) do
            if v18:IsA("ParticleEmitter") or v18:IsA("Trail") then
                v18.Enabled = p16
            end
        end
        if p17 then
            task.delay(p17, function() --[[ Line: 45 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                for _, v19 in ipairs(u15:GetDescendants()) do
                    if v19:IsA("ParticleEmitter") or v19:IsA("Trail") then
                        v19.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p12) == "table" then
        for _, v21 in p12 do
            v20(v21, p13, p14)
        end
    else
        v20(p12, p13, p14)
    end
end
local function u29(p23, p24, p25) --[[ Line: 74 ]]
    local v26 = p23.CFrame
    local v27 = Random.new():NextNumber(p24, p25)
    local v28 = Instance.new("Model")
    v28.Parent = p23.Parent
    p23.Parent = v28
    v28:ScaleTo(v27)
    p23.Parent = v28.Parent
    p23.CFrame = v26
    v28:Destroy()
end
local v30 = RaycastParams.new()
v30.FilterType = Enum.RaycastFilterType.Include
v30.FilterDescendantsInstances = { workspace.Ships, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p31, u32, p33) --[[ Name: start, Line 99 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u22
            [4] = u3
            [5] = u29
        --]]
        if p31 == "Start" then
            u32:FindFirstChild("HumanoidRootPart")
            local v34 = u32:FindFirstChild("RightHand")
            local v35 = script.SpawnEffect:Clone()
            u4.apply(v35, u32)
            v35.CFrame = v34.CFrame
            v35.Parent = u5
            _G.customEmit(v35)
            _G.destroy(v35, 2)
            local v36 = script.HoldEffect:Clone()
            u4.apply(v36, u32)
            v36.CFrame = v34.CFrame
            v36.Parent = u5
            u22(v36, true)
            local v37 = Instance.new("WeldConstraint")
            v37.Part0 = v36
            v37.Part1 = v34
            v37.Parent = v36
            local v38 = script.ShootingEffect:Clone()
            u4.apply(v38, u32)
            v38.CFrame = v34.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
            v38.Parent = u5
            u22(v38, true)
            local v39 = Instance.new("WeldConstraint")
            v39.Part0 = v38
            v39.Part1 = v34
            v39.Parent = v38
            _G.PlaySound(v34, script.LightMachineGunStart)
            local v40 = script.LightMachineGunHold:Clone()
            v40.Parent = u32.PrimaryPart
            v40:Play()
            repeat
                task.wait()
            until u32:GetAttribute("PikaV2JewelsHold") == nil
            _G.tween(v36.PointLight, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Brightness"] = 0
            })
            _G.destroy(v36, 0.25)
            _G.tween(v40, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.destroy(v40, 0.25)
            _G.particleEnabled(v38, false)
            _G.PlayEffect("TweenParticles", nil, v38, NumberSequence.new(0), 0.25)
            _G.destroy(v38, 0.25)
            if v39 then
                v39:Destroy()
                v38.Anchored = true
            end
            local v41 = script.SpawnEffect:Clone()
            u4.apply(v41, u32)
            v41.CFrame = v34.CFrame
            v41.Parent = u5
            _G.customEmit(v41)
            _G.destroy(v41, 2)
        elseif p31 == "Shoot" then
            local v42, u43, v44, u45, u46 = unpack(p33)
            if u32 and u32:FindFirstChild("RightHand") then
                v42 = u32.RightHand.CFrame
            end
            local u47 = script.Projectile:Clone()
            u4.apply(u47, u32)
            u47.CFrame = v42
            u22(u47, true)
            u47.Parent = u5
            _G.PlaySound(u47, script.LightMachineGunShot, {
                ["RandomPitch"] = true
            }).Parent = u47
            _G.customEmit(u47.StarAttachment)
            local u48 = u3:Create(u47, TweenInfo.new(v44, Enum.EasingStyle.Linear), {
                ["CFrame"] = u43
            })
            u48:Play()
            u48.Completed:Connect(function() --[[ Line: 171 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u47
                    [3] = u22
                    [4] = u43
                    [5] = u45
                    [6] = u46
                    [7] = u4
                    [8] = u32
                    [9] = u5
                    [10] = u29
                --]]
                u48:Destroy()
                u47.PointLight:Destroy()
                u22(u47, false)
                _G.destroy(u47, 2)
                local v49 = u43
                if u45 ~= nil then
                    local v50 = u45.Color
                    if u46 then
                        v49 = CFrame.new(u46.Pos, u46.Pos + u46.Nor) * CFrame.Angles(-1.5707963267948966, 0, 0)
                    end
                    local v51 = script.Debree:Clone()
                    u4.apply(v51, u32)
                    v51.CFrame = v49
                    _G.recolorParticles(v51["1"], v50)
                    v51.Parent = u5
                    _G.customEmit(v51)
                    _G.destroy(v51, 4)
                    local v52 = script.Explosion:Clone()
                    u4.apply(v52, u32)
                    v52.CFrame = v49
                    u29(v52, 0.8, 1.3)
                    v52.Parent = u5
                    _G.customEmit(v52)
                    _G.destroy(v52, 4)
                    _G.tween(v52.PointLight, {
                        0.25,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Range"] = 45,
                        ["Brightness"] = 0
                    })
                    _G.shakenear(v52.Position, 25, 25, 75, -1)
                    _G.PlaySound(v52, script["LightMachineGunBoom" .. math.random(1, 4)])
                end
            end)
        end
    end
}