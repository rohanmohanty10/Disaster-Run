 

local v1 = {}
local u2 = script.Parent.Parent.Things
function v1.start(_, p3, p4, p5, p6, p7, p8, p9, _, p10, p11, p12) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v13 = u2.Part:Clone()
    if p12 then
        v13:Destroy()
        v13 = u2[p12]:Clone()
    end
    v13.CFrame = p3
    if p11 then
        v13.Material = p11
    end
    if p4 then
        v13.CFrame = p4
    end
    if typeof(p5) == "BrickColor" then
        v13.BrickColor = p5
    else
        v13.Color = p5
    end
    if p7 then
        v13.Size = p7
    end
    v13.Transparency = p9 == nil and 0 or p9
    _G.destroy(v13, p8)
    local v14 = {
        ["Size"] = p6,
        ["CFrame"] = p3,
        ["Transparency"] = 1
    }
    if p10 then
        v14.Color = p10
    end
    v13.Parent = workspace.Effects
    _G.tween(v13, {
        p8,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, v14)
    return v13
end
return v1