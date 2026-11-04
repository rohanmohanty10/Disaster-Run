 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local u3 = v1.reservedCode
local v4 = game.Players.LocalPlayer
local v5 = v1.CompassGuider
local u6 = workspace.CurrentCamera
local _ = script.Objects
local v7 = require(v1.Modules.Shared.Signals.GoodSignal)
local v8 = require(script.CardinalDirections)
local u9 = {
    ["Default"] = require(script.Objects.Default),
    ["Flag"] = require(script.Objects.Flag)
}
local u12 = {
    ["Coordinates"] = {},
    ["InactiveCoordinates"] = {},
    ["Cardinals"] = {},
    ["PlayerLookAngle"] = nil,
    ["Smoothness"] = 10,
    ["CompassUI"] = script.Parent,
    ["ItemAddedCheck"] = v7.new(),
    ["ItemRemovedCheck"] = v7.new(),
    ["CheckItemAdded"] = function(p10) --[[ Name: CheckItemAdded, Line 34 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        if p10:IsA("Tool") then
            u12.ItemAddedCheck:Fire(p10)
        end
    end,
    ["CheckItemRemoved"] = function(p11) --[[ Name: CheckItemRemoved, Line 39 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        if p11:IsA("Tool") then
            u12.ItemRemovedCheck:Fire(p11)
        end
    end
}
local u13 = 0
for _, v14 in pairs(v4.Backpack:GetChildren()) do
    task.spawn(u12.CheckItemAdded, v14)
end
v4.Backpack.ChildAdded:Connect(u12.CheckItemAdded)
v4.Backpack.ChildRemoved:Connect(u12.CheckItemRemoved)
v4.Character.ChildAdded:Connect(u12.CheckItemAdded)
function u12.RestrictAngle(p15) --[[ Line: 52 ]]
    if p15 < -3.141592653589793 then
        return p15 + 6.283185307179586
    elseif p15 > 3.141592653589793 then
        return p15 - 6.283185307179586
    else
        return p15
    end
end
local function u17(u16) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u9
    --]]
    if u12.Coordinates[u16] then
        u12.Coordinates[u16]:Destroy()
    end
    u12.Coordinates[u16] = u9[u16:GetAttribute("Type") or "Default"].new({
        ["Handler"] = u12,
        ["Guider"] = u16,
        ["Parent"] = script.Parent.Guiders
    })
    u12.Coordinates[u16]:CheckItems()
    u12.Coordinates[u16]:AutoOptimize()
    u16.Destroying:Connect(function() --[[ Line: 76 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u16
        --]]
        if u12.Coordinates[u16] then
            u12.Coordinates[u16]:Destroy()
        end
        u12.Coordinates[u16] = nil
    end)
end
for _, v18 in pairs(v5:GetChildren()) do
    if v18:IsA("Vector3Value") then
        u17(v18)
    end
end
v5.ChildAdded:Connect(function(p19) --[[ Line: 91 ]]
    --[[
    Upvalues:
        [1] = u17
    --]]
    u17(p19)
end)
v8:SetUp(u12)
local u20 = 0
local function v36(p21) --[[ Line: 100 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u6
        [3] = u13
        [4] = u20
    --]]
    if p21 > 0 then
        u12.PlayerLookAngle = u6.CFrame.LookVector
        local v22 = u12
        local v23 = u12.PlayerLookAngle.Z
        local v24 = u12.PlayerLookAngle.X
        v22.PlayerLookAngle = math.atan2(v23, v24)
        local v25 = u12.RestrictAngle(u12.PlayerLookAngle - u13)
        u12.PlayerLookAngle = u12.RestrictAngle(u13 + v25 * p21 * u12.Smoothness)
        u13 = u12.PlayerLookAngle
        local v26 = false
        u20 = u20 + p21
        if u20 >= 0.06666666666666667 then
            v26 = true
            u20 = 0
        end
        local v27 = u6.CFrame
        local v28 = (1 / 0)
        local v29 = nil
        for _, v30 in pairs(u12.Coordinates) do
            v30:Update(v27, v26)
            if v30.IsVisible then
                local v31 = v30.Angle
                local v32 = math.abs(v31)
                if v32 < v28 and v30.Guider:GetAttribute("isEnabled") then
                    local v33 = v30.Angle
                    if math.abs(v33) < 0.25 then
                        v29 = v30
                        v28 = v32
                    end
                end
            end
        end
        if v29 then
            v29:SetInView(true)
        end
        for _, v34 in pairs(u12.Coordinates) do
            if v29 ~= v34 then
                v34:SetInView(false)
            end
        end
        for _, v35 in pairs(u12.Cardinals) do
            v35:Update(v27, v26)
        end
    end
end
local u37 = v2.RenderStepped:Connect(v36)
u3:GetAttributeChangedSignal("battleRoyale"):Connect(function() --[[ Line: 165 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u37
    --]]
    if u3:GetAttribute("battleRoyale") and u3.Value then
        print("Compass Destroyed")
        if u37 then
            u37:Disconnect()
            u37 = nil
        end
        script.Parent:Destroy()
    end
end)
if _G.isCustomHUB == true then
    print("Compass Destroyed")
    if u37 then
        u37:Disconnect()
        u37 = nil
    end
    script.Parent:Destroy()
end
print("Compass loaded")