 

local v1 = game:GetService("ReplicatedStorage")
local v2 = v1.Events.ZiplineVFX
local u3 = {}
local u4 = v1.Modules["GPO Zipline"].Zipline.Assets
local u5 = require(v1.Modules.Utils.Cleaner)
v2.OnClientEvent:Connect(function(p6, p7, p8) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
        [3] = u4
    --]]
    if p7 then
        if u3[p6] then
            return
        elseif p6.PrimaryPart ~= nil then
            local v9 = u5.new()
            local v10 = u4.VFX:Clone()
            v10.Anchored = false
            if p8 < 0 then
                local v11 = u4.ZiplineHandle:Clone()
                v11.PrimaryPart.Anchored = false
                v11.Top.Rail.Anchored = false
                local v12 = Instance.new("Weld")
                v12.C0 = CFrame.Angles(3.141592653589793, 0, 0)
                v12.Part0 = v11.PrimaryPart
                v12.Part1 = p6.RightHand
                v12.Parent = v11
                v10.CFrame = v11.Top.Rail.CFrame
                local v13 = Instance.new("Weld")
                v13.Part0 = v10
                v13.Part1 = v11.Top.Rail
                v13.Parent = v11
                v11.Parent = p6
                v9:AddTask(v11)
            else
                local v14 = p6.PrimaryPart
                if not v14 then
                    return
                end
                local v15 = p6.Humanoid.HipHeight + v14.Size.Y * 0.5
                v10.CFrame = p6.HumanoidRootPart.CFrame * CFrame.new(0, -v15, 0)
                local v16 = Instance.new("WeldConstraint")
                v16.Part0 = v10
                v16.Part1 = v14
                v16.Parent = v10
            end
            v10.Parent = p6
            v9:AddTask(v10)
            u3[p6] = v9
        end
    else
        if u3[p6] then
            u3[p6]:Destroy()
            u3[p6] = nil
        end
        return
    end
end)