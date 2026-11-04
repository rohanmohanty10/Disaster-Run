 

local v1 = {}
game:GetService("Debris")
game:GetService("TweenService")
game:GetService("RunService")
script:WaitForChild("Models")
script:WaitForChild("SFX")
local u2 = script:WaitForChild("VFX")
script:WaitForChild("Other")
local u3 = workspace:WaitForChild("Effects")
local u4 = require(script.Parent:WaitForChild("SharedDiamondUtils"))
Charges = {}
Random.new()
local u16 = {
    ["Start"] = function(u5) --[[ Line: 29 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u3
        --]]
        local v6 = u5:FindFirstChild("BusoMelee") ~= nil
        local v7, v8 = u4.DiamondFunctions.DiamondMorph(u5, nil, "RadiantDefenseDiamondRig")
        pcall(function() --[[ Line: 34 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5.Boosts.currentDiamondMorph:Destroy()
        end)
        local v9
        if v6 == false then
            v9 = u2.Shine:Clone()
        else
            v9 = u2.ShineHaki:Clone()
        end
        v9.CFrame = u5.HumanoidRootPart.CFrame
        u4.SharedFunctions.EmitAllParticles(v9)
        local v10 = Instance.new("Weld")
        v10.Part0 = u5.HumanoidRootPart
        v10.Part1 = v9
        v10.Parent = v9
        v9.Parent = u3
        task.delay(2, v9.Destroy, v9)
        local v11 = {}
        repeat
            task.wait()
        until u5:GetAttribute("DiamondDefense") == nil or u5:IsDescendantOf(workspace) == false
        for _, v12 in v11 do
            u4.DiamondFunctions.DiamondDebris(2, v12, NumberRange.new(0.75, 1.5), NumberRange.new(0.25, 0.5), 25, 25, u3, nil, v6)
            v12:Destroy()
        end
        if v8 then
            v8()
        end
        for _, v13 in v7:GetChildren() do
            u4.DiamondFunctions.BreakDiamond(v13, v6)
            for _, v14 in v13:GetChildren() do
                if v14:IsA("Decal") then
                    v14:Destroy()
                end
            end
            u4.DiamondFunctions.DiamondDebris(1, v13, NumberRange.new(0.75, 1.5), NumberRange.new(0.35, 0.75), 25, 25, u3, v11, v6)
        end
        v7.Name = "RadiantDefenseRigDestroying"
        task.wait(5)
        for _, v15 in v11 do
            if v15 then
                v15:Destroy()
            end
        end
        _G.destroy(v7, 4)
    end
}
function v1.start(_, p17, p18, ...) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u16
    --]]
    if not Charges[p17] then
        Charges[p17] = {}
    end
    if u16[p18] then
        u16[p18](p17, ...)
    end
end
return v1