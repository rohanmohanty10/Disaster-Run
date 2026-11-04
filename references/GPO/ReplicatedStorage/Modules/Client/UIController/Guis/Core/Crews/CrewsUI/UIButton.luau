 

local v1 = game:GetService("ReplicatedStorage").Modules.Client
local u2 = require(v1:WaitForChild("UIUtils"))
local u3 = {}
u3.__index = u3
function u3.new(u4, u5) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v6 = u3
    local u7 = setmetatable({}, v6)
    u7.CrewsUI = u4
    u7.Button = u5
    local function v8() --[[ Line: 18 ]] end
    local function v9() --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
        --]]
        if u7.Button ~= u4:GetSelectedButton() then
        end
    end
    u5.MouseEnter:Connect(v8)
    u5.MouseLeave:Connect(v9)
    u5.SelectionGained:Connect(v8)
    u5.SelectionLost:Connect(v9)
    u5.MouseButton1Click:Connect(function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u5
            [3] = u7
        --]]
        u2.ButtonEffect()
        if u5.BackgroundTransparency == 0 then
            u7:Pressed()
        end
    end)
    return u7
end
function u3.EnableButton(p10) --[[ Line: 46 ]]
    p10.Button.BackgroundTransparency = 0
    p10.Button.Text.TextTransparency = 0
end
function u3.DisableButton(p11) --[[ Line: 51 ]]
    p11.Button.BackgroundTransparency = 0.8
    p11.Button.Text.TextTransparency = 0.8
end
function u3.Pressed(p12) --[[ Line: 56 ]]
    local v13 = p12.CrewsUI:GetSelectedButton()
    if v13 and v13 ~= p12.Button or (not v13 or v13 ~= p12.Button) then
        p12.CrewsUI:OpenFrame(p12.Button.Name)
        p12.CrewsUI:SelectButton(p12.Button)
    end
end
return u3