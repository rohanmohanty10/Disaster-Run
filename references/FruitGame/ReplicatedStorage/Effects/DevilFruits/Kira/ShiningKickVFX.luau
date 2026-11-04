 

local v1 = {}
game:GetService("Debris")
local u2 = game:GetService("TweenService")
game:GetService("RunService")
script:WaitForChild("Models")
script:WaitForChild("SFX")
script:WaitForChild("VFX")
script:WaitForChild("Other")
local u3 = workspace:WaitForChild("Effects")
local u4 = require(script.Parent:WaitForChild("SharedDiamondUtils"))
Charges = {}
Random.new()
local u19 = {
    ["Start"] = function(p5) --[[ Line: 29 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        local v6 = p5:FindFirstChild("BusoMelee") ~= nil
        local _, v7 = u4.DiamondFunctions.DiamondMorph(p5, {
            ["RightUpperLeg"] = v6,
            ["RightLowerLeg"] = v6,
            ["RightFoot"] = v6
        }, "ShiningKickDiamondRig")
        repeat
            task.wait()
        until p5:GetAttribute("ShiningKickHold") == nil
        task.wait(0.35)
        if v7 then
            v7()
        end
    end,
    ["End"] = function(u8) --[[ Line: 49 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u4
        --]]
        local v9 = u8:FindFirstChild("BusoMelee") ~= nil
        local v10 = u8.Boosts.currentDiamondMorph.Value
        local v11
        if v9 == true then
            v11 = script.VFX.Haki
        else
            v11 = script.VFX
        end
        pcall(function() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            u8.Boosts.currentDiamondMorph:Destroy()
        end)
        local u12 = v11.DiamondSwing:Clone()
        u12.Attachment.Star:Emit(1)
        u12.CFrame = u8.HumanoidRootPart.CFrame * CFrame.Angles(0, -1.5707963267948966, 0.08726646259971647) * CFrame.Angles(-0.2617993877991494, 0, 0)
        u2:Create(u12, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["CFrame"] = u12.CFrame * CFrame.Angles(0, 3.12413936106985, 0)
        }):Play()
        u2:Create(u12.Mesh, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ["Scale"] = Vector3.new(-8.5, -1.5, -8.5)
        }):Play()
        u2:Create(u12, TweenInfo.new(0.1, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
            ["Transparency"] = 1
        }):Play()
        u12.Parent = u3
        task.delay(0.1, function() --[[ Line: 73 ]]
            --[[
            Upvalues:
                [1] = u12
            --]]
            for _, v13 in u12.ParticlesHolder:GetChildren() do
                if v13:IsA("ParticleEmitter") then
                    v13.Enabled = false
                end
            end
            task.wait(1.5)
            u12:Destroy()
        end)
        local v14 = v11.WindRingMesh:Clone()
        v14.Transparency = 0.25
        local v15 = u8.HumanoidRootPart.CFrame
        local v16 = CFrame.Angles
        local v17 = Random.new():NextNumber(-180, 180)
        v14.CFrame = v15 * v16(0, math.rad(v17), 0)
        v14.Mesh.Scale = Vector3.new(0, -1, 0)
        v14.Mesh.VertexColor = Vector3.new(2, 2, 2)
        u2:Create(v14.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(-10, -5, -10)
        }):Play()
        u2:Create(v14, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ["CFrame"] = v14.CFrame * CFrame.new(0, 2, 0) * CFrame.Angles(0, 3.12413936106985, 0)
        }):Play()
        u2:Create(v14, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {
            ["Transparency"] = 1
        }):Play()
        v14.Parent = u3
        task.delay(0.2, v14.Destroy, v14)
        task.wait(0.35)
        for _, v18 in v10:GetChildren() do
            u4.DiamondFunctions.BreakDiamond(v18, v9)
        end
        v10.Name = "ShiningKickRigDestroying"
        task.wait(2)
        v10:Destroy()
    end
}
function v1.start(_, p20, p21, ...) --[[ Line: 105 ]]
    --[[
    Upvalues:
        [1] = u19
    --]]
    if not Charges[p20] then
        Charges[p20] = {}
    end
    if u19[p21] then
        u19[p21](p20, ...)
    end
end
return v1