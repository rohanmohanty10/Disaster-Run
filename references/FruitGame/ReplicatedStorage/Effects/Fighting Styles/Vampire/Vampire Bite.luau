 

local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local _ = v1.LocalPlayer
local u3 = require(v2.Modules.Client.WeaponVFXRecolor)
local u4 = workspace.Effects
function Flipbook(p5, u6, u7, u8)
    local u9 = p5:FindFirstChildOfClass("SpecialMesh")
    if u9 and u6 then
        task.spawn(function() --[[ Line: 51 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u9
                [3] = u7
                [4] = u8
            --]]
            for v10 = 1, #u6 do
                u9.TextureId = u6[v10]
                task.wait(1 / u7)
            end
            if u8 == true then
                u9.Parent:Destroy()
            end
        end)
    end
end
local function u21(p11, p12, p13) --[[ Line: 65 ]]
    local function v19(u14, p15, p16) --[[ Line: 66 ]]
        for _, v17 in ipairs(u14:GetDescendants()) do
            if v17:IsA("ParticleEmitter") or v17:IsA("Trail") then
                v17.Enabled = p15
            end
        end
        if p16 then
            task.delay(p16, function() --[[ Line: 74 ]]
                --[[
                Upvalues:
                    [1] = u14
                --]]
                for _, v18 in ipairs(u14:GetDescendants()) do
                    if v18:IsA("ParticleEmitter") or v18:IsA("Trail") then
                        v18.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p11) == "table" then
        for _, v20 in p11 do
            v19(v20, p12, p13)
        end
    else
        v19(p11, p12, p13)
    end
end
return {
    ["start"] = function(_, p22, p23) --[[ Name: start, Line 98 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u21
        --]]
        if _G.checkRenderDistance(p22.PrimaryPart.Position) ~= false then
            local v24 = p22.HumanoidRootPart
            local _ = p23.HumanoidRootPart
            p22:FindFirstChild("Humanoid")
            p23:FindFirstChild("Humanoid")
            local v25 = script["Grab Emit"]:Clone()
            u3.apply(v25, p22)
            v25.CFrame = v24.CFrame * CFrame.new(0, 0, -2)
            v25.Parent = u4
            _G.customEmit(v25)
            _G.destroy(v25, 0.3)
            if (workspace.CurrentCamera.CFrame.Position - p22.PrimaryPart.Position).Magnitude <= 75 then
                _G.camShake:ShakeOnce(3, 10, 0.1, 0.3)
            end
            task.wait(0.5)
            local u26 = script["Vampire Bite"]:Clone()
            u3.apply(u26, p22)
            u26.CFrame = v24.CFrame * CFrame.new(0, 1, -2) * CFrame.Angles(0, 0, 0.5235987755982988)
            u26.Parent = u4
            _G.customEmit(u26.Emit)
            _G.destroy(u26, 1.3)
            u21(u26.Enable, true, 0.8)
            if (workspace.CurrentCamera.CFrame.Position - p22.PrimaryPart.Position).Magnitude <= 75 then
                _G.camShake:ShakeOnce(5, 13, 0.4, 1)
            end
            u26.Plus.Enabled = true
            task.delay(0.8, function() --[[ Line: 131 ]]
                --[[
                Upvalues:
                    [1] = u26
                --]]
                u26.Plus.Enabled = false
                _G.customEmit(u26.ExitEmit)
            end)
            task.wait(1.45)
            local v27 = script["Throw Emit"]:Clone()
            u3.apply(v27, p22)
            v27.CFrame = p22.RightHand.CFrame
            v27.Parent = u4
            _G.customEmit(v27)
            _G.destroy(v27, 0.5)
        end
    end
}