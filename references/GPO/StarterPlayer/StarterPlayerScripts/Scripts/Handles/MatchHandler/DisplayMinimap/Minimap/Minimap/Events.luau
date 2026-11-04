 

local v1 = {}
local u2 = {}
function v1.CreateBindableEvent(p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p3] then
        u2[p3]:Fire()
    else
        local v4 = Instance.new("BindableEvent")
        v4.Parent = script
        v4.Name = tostring(p3)
        u2[p3] = v4
        v4:Fire()
    end
end
function v1.ReturnBindableEvent(p5) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return u2[p5]
end
function v1.FireBindableEvent(p6) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2[p6]:Fire()
end
function v1.RemoveEvent(p7) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    u2[p7]:Destroy()
    u2[p7] = nil
end
return v1