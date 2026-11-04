 

local v1 = game:GetService("Players")
local u2 = game:GetService("TweenService")
local u3 = game:GetService("ReplicatedStorage")
local u4 = game:GetService("HttpService")
local v5 = u3:WaitForChild("Modules")
local v6 = v5:WaitForChild("Shared")
v6:WaitForChild("AnimationPacks")
local v7 = v5.Client
local u8 = require(v7:WaitForChild("UIUtils"))
local v9 = v6.Promises
local u10 = require(v9:WaitForChild("PromiseChild"))
local v11 = v6.Marketplace
require(v11.MarketplaceUtils)
local u12 = v1.LocalPlayer
local u13 = u3.Events:WaitForChild("Emotes")
local v14 = script.Parent
local u15 = v14:WaitForChild("Wheel")
local v16 = u15:WaitForChild("Selection")
local u17 = v14:WaitForChild("Inventory")
local u18 = u17:WaitForChild("List")
local u19 = u17:WaitForChild("SearchBox")
local u20 = require(v6.EmoteUtils)
local v21 = require(v5.Trove)
local u22 = {
    ["Pack1"] = {
        ["LayoutOrder"] = 1,
        ["Color"] = Color3.fromRGB(255, 206, 84)
    },
    ["Pack2"] = {
        ["LayoutOrder"] = 2,
        ["Color"] = Color3.fromRGB(79, 193, 233)
    },
    ["Pack3"] = {
        ["LayoutOrder"] = 3,
        ["Color"] = Color3.fromRGB(237, 85, 101)
    },
    ["Pack4"] = {
        ["LayoutOrder"] = 4,
        ["Color"] = Color3.fromRGB(252, 110, 81)
    },
    ["Pack5"] = {
        ["LayoutOrder"] = 5,
        ["Color"] = Color3.fromRGB(172, 146, 236)
    },
    ["Pack6"] = {
        ["LayoutOrder"] = 6,
        ["Color"] = Color3.fromRGB(160, 212, 104)
    }
}
local u23 = nil
local u24 = nil
local u25 = false
local v26 = false
local u27 = v21.new()
local function u32(p28, u29) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u15
        [3] = u17
        [4] = u27
    --]]
    u25 = true
    u15.Selection.Inventory.TextLabel.Text = "Select a Emote"
    if p28 then
        u15.Selection.Inventory.TextLabel.Text = p28
    end
    u17.Visible = true
    u27:Connect(game:GetService("UserInputService").InputBegan, function(p30, p31) --[[ Line: 67 ]]
        --[[
        Upvalues:
            [1] = u29
            [2] = u25
            [3] = u15
            [4] = u17
            [5] = u27
        --]]
        if not p31 then
            if p30.UserInputType == Enum.UserInputType.MouseButton1 or p30.UserInputType == Enum.UserInputType.Touch then
                if u29 then
                    u29()
                end
                u25 = false
                u15.Selection.Inventory.TextLabel.Text = "Edit Emotes"
                u17.Visible = false
                u27:Destroy()
            end
        end
    end)
end
local u33 = {}
local function u47(u34, p35) --[[ Line: 81 ]]
    --[[
    Upvalues:
        [1] = u33
        [2] = u18
        [3] = u17
        [4] = u22
        [5] = u8
        [6] = u23
        [7] = u24
        [8] = u32
    --]]
    if u33[u34.Name] == nil then
        u33[u34.Name] = u34
        local u36 = script.Template:Clone()
        u36.Name = u34.Name
        u36.Parent = u18
        local u37 = u36.Background
        local v38 = u37.Middle
        local v39 = u36.Button
        local u40 = u36.ViewportFrame
        local v41 = u40.WorldModel.Dummy
        local v42 = v41:WaitForChild("Humanoid")
        local v43 = Instance.new("Camera")
        v43.FieldOfView = 50
        v43.Parent = u40
        u40.CurrentCamera = v43
        v43.CFrame = v41.HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 6.5)
        u36.Item.Text = u34.Name
        local u44 = v42:LoadAnimation(u34)
        u44.Looped = true
        u40.Parent = nil
        u17:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 113 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u44
                [3] = u40
                [4] = u36
            --]]
            if u17.Visible then
                u44:Play()
                u40.Parent = u36
            else
                u44:Stop()
                u40.Parent = nil
            end
        end)
        local v45 = u22[p35]
        if v45 then
            v38.ImageColor3 = v45.Color
            u36.LayoutOrder = v45.LayoutOrder
        else
            u36.LayoutOrder = 1000
        end
        v39.MouseButton1Click:Connect(function() --[[ Line: 131 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u37
                [3] = u23
                [4] = u24
                [5] = u36
                [6] = u34
                [7] = u32
            --]]
            u8.ButtonEffect()
            local function v46() --[[ Line: 135 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u23
                    [3] = u24
                --]]
                u37.BackgroundColor3 = script.Template.Background.BackgroundColor3
                u23 = nil
                u24 = nil
            end
            if u23 == nil then
                u23 = u36
                u37.BackgroundColor3 = Color3.fromRGB(90, 142, 233)
                u24 = u34
            elseif u23 == u36 then
                u37.BackgroundColor3 = script.Template.Background.BackgroundColor3
                u23 = nil
                u24 = nil
            else
                u23.Background.BackgroundColor3 = script.Template.Background.BackgroundColor3
                u37.BackgroundColor3 = Color3.fromRGB(90, 142, 233)
                u24 = u34
                u23 = u36
            end
            u32("Select Slot", v46)
            print(u34)
        end)
    end
end
local u48 = nil
local u49 = {}
local function u66() --[[ Line: 178 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u3
        [3] = u12
        [4] = u48
        [5] = u4
        [6] = u33
        [7] = u49
        [8] = u47
        [9] = u20
        [10] = u66
    --]]
    u10(u3, "Stats" .. u12.Name):Then(function(p50) --[[ Line: 179 ]]
        --[[
        Upvalues:
            [1] = u48
            [2] = u4
            [3] = u33
            [4] = u49
            [5] = u47
            [6] = u20
        --]]
        u48 = p50
        local v51 = u48:WaitForChild("Emotes")
        local u52 = v51:WaitForChild("Equipped")
        local u53 = v51:WaitForChild("Owned")
        local function v59() --[[ Line: 186 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u52
                [3] = u33
                [4] = u49
            --]]
            local v54 = u4:JSONDecode(u52.Value)
            for v55, v56 in pairs(v54) do
                local v57 = u33[v56]
                local v58 = u49[v55]
                if v57 and v58 then
                    v58.AnimationObject.Value = v57
                end
            end
            print("decoded", v54)
        end
        local function v64() --[[ Line: 201 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u53
                [3] = u33
                [4] = u47
                [5] = u20
            --]]
            local v60 = u4:JSONDecode(u53.Value)
            for v61, v62 in pairs(v60) do
                if u33[v61] == nil then
                    local v63 = Instance.new("Animation")
                    v63.Name = v61
                    v63.AnimationId = v62
                    u47(v63, u20:GetAnimationData(v61).Pack or "")
                end
            end
        end
        v64()
        u53:GetPropertyChangedSignal("Value"):Connect(v64)
        v59()
    end):Catch(function(p65) --[[ Line: 222 ]]
        --[[
        Upvalues:
            [1] = u66
        --]]
        warn(p65)
        task.wait(1)
        u66()
    end)
end
local u67 = u48
local u68 = u25
local u69 = v26
local u70 = u24
local u71 = u23
for u72 = 1, 6 do
    local u73 = v16:WaitForChild("" .. u72)
    if u73 then
        local v74 = u73:WaitForChild("Button")
        local u75 = u73:WaitForChild("ViewportFrame")
        local u76 = u73:WaitForChild("CurrentAnimation")
        u75.WorldModel.Dummy:Destroy()
        local v77 = script.Template.ViewportFrame.WorldModel.Dummy:Clone()
        v77.Parent = u75.WorldModel
        local u78 = v77:WaitForChild("Humanoid")
        local v79 = Instance.new("Camera")
        v79.FieldOfView = 50
        v79.Parent = u75
        u75.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        u75.CurrentCamera = v79
        v79.CFrame = v77.HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 7.5)
        local u80 = nil
        local function v82() --[[ Line: 283 ]]
            --[[
            Upvalues:
                [1] = u80
                [2] = u76
                [3] = u78
                [4] = u73
            --]]
            if u80 then
                u80:Stop()
                u80 = nil
            end
            local v81 = u76.Value
            if v81 == nil or not v81:IsA("Animation") then
                u73.emoteName.Text = "None"
            else
                u80 = u78:LoadAnimation(v81)
                u80.Looped = true
                u80:Play()
                u73.emoteName.Text = u76.Value.Name
            end
        end
        u76:GetPropertyChangedSignal("Value"):Connect(v82)
        v82()
        v74.MouseButton1Click:Connect(function() --[[ Line: 304 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u68
                [3] = u71
                [4] = u13
                [5] = u72
                [6] = u70
                [7] = u49
                [8] = u73
                [9] = u32
                [10] = u17
                [11] = u15
                [12] = u27
                [13] = u69
                [14] = u76
                [15] = u12
                [16] = u20
            --]]
            u8.ButtonEffect()
            if u68 == true then
                if u71 ~= nil then
                    u13:FireServer({
                        ["Method"] = "UpdateEmoteSlot",
                        ["Slot"] = "" .. u72,
                        ["AnimName"] = u70.Name
                    })
                    u49[u73.Name].AnimationObject.Value = u70
                    u70 = nil
                    u71.Background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    u71 = nil
                    u32()
                end
            else
                u17.Visible = false
                for _, v83 in pairs(u49) do
                    v83.Close()
                end
                u15.Visible = false
                u68 = false
                u15.Selection.Inventory.TextLabel.Text = "Edit Emotes"
                u17.Visible = false
                u27:Destroy()
                u69 = false
                if u76.Value ~= nil then
                    local _ = u12.Character
                    u20:PlayEmote(u76.Value.Name)
                end
            end
        end)
        local v84 = {
            ["AnimationObject"] = u76
        }
        u75.Parent = nil
        function v84.Open() --[[ Line: 337 ]]
            --[[
            Upvalues:
                [1] = u75
                [2] = u73
                [3] = u2
            --]]
            u75.Parent = u73
            u73.Size = UDim2.new(0, 0, 0, 0)
            u2:Create(u73, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.new(0.3, 0, 0.3, 0)
            }):Play()
        end
        function v84.Close() --[[ Line: 350 ]]
            --[[
            Upvalues:
                [1] = u75
                [2] = u2
                [3] = u73
            --]]
            u75.Parent = nil
            u2:Create(u73, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.new(0, 0, 0, 0)
            }):Play()
        end
        function v84.InstantClose() --[[ Line: 361 ]]
            --[[
            Upvalues:
                [1] = u73
            --]]
            u73.Size = UDim2.new(0, 0, 0, 0)
        end
        u49[u73.Name] = v84
    end
end
u66()
v16.Inventory.Button.MouseButton1Click:Connect(function() --[[ Line: 371 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u17
        [3] = u68
        [4] = u15
        [5] = u32
    --]]
    u8.ButtonEffect()
    u17.Visible = not u17.Visible
    u68 = u17.Visible
    if u68 == false then
        u15.Selection.Inventory.TextLabel.Text = "Edit Emotes"
    else
        u32()
    end
end)
local function u88() --[[ Line: 385 ]]
    --[[
    Upvalues:
        [1] = u19
        [2] = u18
    --]]
    local v85 = u19.Text
    local v86 = string.lower(v85)
    for _, v87 in pairs(u18:GetChildren()) do
        if v87:IsA("Frame") then
            v87.Visible = string.find(string.lower(v87.Name), v86) and true or false
        end
    end
end
u19:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 396 ]]
    --[[
    Upvalues:
        [1] = u88
    --]]
    u88()
end)
script.Parent.ToggleUI.Event:Connect(function() --[[ Line: 402 ]]
    --[[
    Upvalues:
        [1] = u69
        [2] = u17
        [3] = u49
        [4] = u15
        [5] = u68
        [6] = u27
        [7] = u67
    --]]
    if u69 then
        u17.Visible = false
        for _, v89 in pairs(u49) do
            v89.Close()
        end
        u15.Visible = false
        u68 = false
        u15.Selection.Inventory.TextLabel.Text = "Edit Emotes"
        u17.Visible = false
        u27:Destroy()
    elseif u67 ~= nil then
        u15.Visible = true
        u68 = false
        u15.Selection.Inventory.TextLabel.Text = "Edit Emotes"
        u17.Visible = false
        u27:Destroy()
        for _, v90 in pairs(u49) do
            v90.Open()
        end
    end
    u69 = not u69
end)
game:GetService("UserInputService").InputBegan:Connect(function(p91, p92) --[[ Line: 414 ]]
    --[[
    Upvalues:
        [1] = u69
        [2] = u17
        [3] = u49
        [4] = u15
        [5] = u68
        [6] = u27
        [7] = u67
    --]]
    if not p92 then
        if p91.KeyCode == Enum.KeyCode.U then
            if u69 == true then
                u17.Visible = false
                for _, v93 in pairs(u49) do
                    v93.Close()
                end
                u15.Visible = false
                u68 = false
                u15.Selection.Inventory.TextLabel.Text = "Edit Emotes"
                u17.Visible = false
                u27:Destroy()
                u69 = false
                return
            end
            if u67 ~= nil then
                u15.Visible = true
                u68 = false
                u15.Selection.Inventory.TextLabel.Text = "Edit Emotes"
                u17.Visible = false
                u27:Destroy()
                for _, v94 in pairs(u49) do
                    v94.Open()
                end
            end
            u69 = true
        end
    end
end)