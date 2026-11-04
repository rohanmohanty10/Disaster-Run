 

local v1 = {}
local function u6(p2, p3) --[[ Line: 3 ]]
    local v4 = script[p3]:GetDescendants()
    for v5 = 1, #v4 do
        if v4[v5].Name == p2.Name then
            _G.tween(p2, {
                1,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = v4[v5].Color
            })
        end
    end
end
local u7 = nil
function v1.start(_, p8, p9, p10) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u6
    --]]
    if p9 == nil then
        local v11 = workspace.Effects["Spirit Essence"]:GetDescendants()
        for v12 = 1, #v11 do
            if v11[v12]:IsA("BasePart") or v11[v12]:IsA("PointLight") then
                u6(v11[v12], p8)
            end
        end
    else
        if u7 then
            pcall(function() --[[ Line: 15 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                u7:Stop()
            end)
            u7 = nil
        end
        u7 = _G.tween(workspace.Effects["Spirit Essence"].Handle, {
            p9,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = p10
        }, nil, true)
    end
end
return v1