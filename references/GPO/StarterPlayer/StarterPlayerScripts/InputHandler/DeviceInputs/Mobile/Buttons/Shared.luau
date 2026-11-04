 

local v1 = game:GetService("ReplicatedStorage").Modules
local u2 = require(v1.ContextActionService)
local v3 = {}
v3.__index = v3
function v3._createButton(u4, p5) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = p5.ButtonData
    local v7 = p5.Name
    local v8 = p5.Title
    local v9 = p5.Texture
    local v10 = p5.Button
    local _, _, _ = u2:GetMobileUI()
    local v11 = u2.JumpButtonSize
    local v12 = v6.SizeRatio
    local v13 = u2
    local v14 = {
        ["Button"] = v10,
        ["Name"] = v7,
        ["Title"] = v8 or v7,
        ["Texture"] = v9,
        ["Callbacks"] = {
            ["InputBegan"] = function() --[[ Name: Activated, Line 24 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                if u4.Activated then
                    u4:Activated()
                end
            end,
            ["InputEnded"] = function() --[[ Name: Deactivated, Line 29 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                if u4.Deactivated then
                    u4:Deactivated()
                end
            end
        },
        ["Position"] = UDim2.fromOffset(v6.X, v6.Y),
        ["Size"] = UDim2.fromOffset(v11.X * v12.X, v11.Y * v12.Y),
        ["SizeRatio"] = v12,
        ["AutoScaling"] = true
    }
    return v13:CreateButton(v14)
end
return v3