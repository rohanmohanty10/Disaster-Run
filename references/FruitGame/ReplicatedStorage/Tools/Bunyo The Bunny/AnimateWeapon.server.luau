 

local u1 = script.Parent
local u2 = u1:WaitForChild("RootPart"):FindFirstChild("WeaponHoldAttachment", true)
repeat
    task.wait()
until _G.customWeld ~= nil and _G.PlayEffect ~= nil
script.Parent:WaitForChild("AnimationController"):LoadAnimation(script:WaitForChild("Animation")):Play()
local u3 = nil
local u4 = {}
local function u9(p5) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
        [3] = u2
        [4] = u4
    --]]
    if u3 then
        u3:Destroy()
    end
    local u6 = game.ReplicatedStorage.Tools:FindFirstChild(p5):Clone()
    u6:ScaleTo(u6:GetScale() * 0.3)
    Instance.new("Attachment", u6.PrimaryPart).Position = Vector3.new(0, 0, 0)
    u6.PrimaryPart.Anchored = true
    u6:SetPrimaryPartCFrame(script.Parent.RootPart.CFrame)
    u6.Parent = workspace.Effects
    _G.bindableExcu(function() --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u6
        --]]
        u1.Destroying:Once(function() --[[ Line: 54 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            u6:Destroy()
        end)
    end)
    _G.PlayEffect("CustomWeld", nil, u6.PrimaryPart, u2, CFrame.new(), u6)
    table.clear(u4)
    local v7 = u6:GetDescendants()
    for v8 = 1, #v7 do
        if v7[v8]:IsA("BasePart") and v7[v8].Transparency ~= 1 then
            u4[v7[v8]] = v7[v8].Transparency
        end
    end
    u3 = u6
end
task.spawn(function() --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
    --]]
    u1:WaitForChild("Eyebrows"):GetPropertyChangedSignal("Transparency"):Connect(function() --[[ Line: 72 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u4
        --]]
        if u1.Eyebrows.Transparency == 1 then
            for v10, _ in pairs(u4) do
                v10.Transparency = 1
            end
        else
            for v11, v12 in pairs(u4) do
                v11.Transparency = v12
            end
        end
    end)
end)
local u13 = game.ReplicatedStorage:WaitForChild("Stats" .. u1.Parent.Name)
if u13 then
    local function u17() --[[ Line: 88 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u9
        --]]
        local v14 = require(game.ReplicatedStorage.Modules.ToolDesc)
        local v15 = nil
        for _, v16 in game:GetService("HttpService"):JSONDecode(u13.Inventory.Equiped.Value) do
            if v14 and (v14[v16] and v14[v16].Type == "Katana") then
                v15 = v16
                break
            end
        end
        if v15 then
            u9(v15)
        end
    end
    local v18 = u17()
    if v18 then
        u9(v18)
    end
    local v19 = u13.Customization.Height.Value
    local _ = v19 / 10
    local v20 = script.Parent:FindFirstChild("Lower_Torso", true)
    function GetOffset(p21)
        return p21 <= 10 and 0.215 or 0.215 * ((p21 - 10) * 0.05)
    end
    if v20 then
        local v22 = -GetOffset(v19)
        v20.Position = Vector3.new(0.007, v22, -0.52)
    end
    u13.Inventory.Equiped.Changed:Connect(function() --[[ Line: 129 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u9
        --]]
        local v23 = u17()
        if v23 then
            u9(v23)
        end
    end)
    while true do
        task.wait(math.random(8, 12))
        if not u1.PrimaryPart then
            break
        end
        _G.PlaySound(u1.PrimaryPart, script["BunnyPetVoice" .. math.random(1, 4)]).Parent = u1.PrimaryPart
    end
end