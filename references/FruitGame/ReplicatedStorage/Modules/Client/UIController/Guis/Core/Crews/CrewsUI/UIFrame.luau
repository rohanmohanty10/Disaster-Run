 

local u1 = {}
u1.__index = u1
function u1.new(p2, p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = script:FindFirstChild(p3.Name)
    if not v4 then
        warn("Missing UIModule for", p3.Name)
    end
    local v5 = v4 and require(v4) or {}
    local v6 = u1
    local v7 = setmetatable(v5, v6)
    v7.CrewsUI = p2
    v7.Frame = p3
    if v7.Setup then
        v7:Setup(p2.UIController)
    end
    return v7
end
function u1.SetVisible(p8, p9) --[[ Line: 23 ]]
    if p9 == nil then
        p9 = not p8.Frame.Visible or p9
    end
    p8.Frame.Visible = p9
end
return u1