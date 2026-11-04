 

local u1 = script.Parent
local v2 = u1:WaitForChild("RootPart").Lower_Torso.Upper_Torso.Left_Shoulder.Left_UpperArm.Left_LowerArm.Left_Paw.SnackMesh
local function v8(p3, u4) --[[ Line: 5 ]]
    local u5 = p3:GetDescendants()
    for u6 = 1, #u5 do
        if u5[u6]:IsA("BasePart") then
            u5[u6].CanCollide = false
            u5[u6].CanQuery = false
            u5[u6].CanTouch = false
            u5[u6].CollisionGroup = "noclip"
            u5[u6].Velocity = Vector3.new()
            u5[u6].Massless = true
            local u7 = u5[u6].Transparency
            if u5[u6].Transparency ~= 1 then
                u4:GetPropertyChangedSignal("Transparency"):Connect(function() --[[ Line: 17 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u5
                        [3] = u6
                        [4] = u7
                    --]]
                    if u4.Transparency == 0 == false then
                        u5[u6].Transparency = 1
                    else
                        u5[u6].Transparency = u7
                    end
                end)
            end
        elseif u5[u6]:IsA("Sound") then
            u5[u6]:Destroy()
        end
    end
end
repeat
    task.wait()
until script.Parent:GetAttribute("Fruit") ~= nil and (_G.customWeld ~= nil and _G.PlayEffect ~= nil)
script.Parent:WaitForChild("AnimationController"):LoadAnimation(script:WaitForChild("Animation")):Play()
local v9 = script.Parent:GetAttribute("Fruit")
local v10 = game.ReplicatedStorage.Tools:FindFirstChild(v9)
if v10 then
    local u11 = v10:Clone()
    u11:ScaleTo(u11:GetScale() * 0.5)
    v8(u11, script.Parent.BunnySkin)
    Instance.new("Attachment", u11.PrimaryPart).Position = Vector3.new(0, 0, 0)
    u11.PrimaryPart.Anchored = true
    u11:SetPrimaryPartCFrame(script.Parent.RootPart.CFrame)
    u11.Parent = workspace.Effects
    _G.bindableExcu(function() --[[ Line: 57 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u11
        --]]
        u1.Destroying:Once(function() --[[ Line: 58 ]]
            --[[
            Upvalues:
                [1] = u11
            --]]
            u11:Destroy()
        end)
    end)
    _G.PlayEffect("CustomWeld", nil, u11.PrimaryPart, v2, CFrame.new(), u11)
end