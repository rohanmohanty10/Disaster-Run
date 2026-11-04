 

game:GetService("RunService")
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
local _ = _G.Ess
local u1 = {}
local function u14(p2, _, _, p3, p4) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v5 = p2:GetDescendants()
    local v6 = _G.getAccessorys(p2)
    local v7 = p4 and 1 or 0
    for v8 = 1, #v6 do
        local v9 = v6[v8]
        table.insert(v5, v9)
    end
    if v7 == 1 then
        for v10 = 1, #v5 do
            if (v5[v10]:IsA("BasePart") or v5[v10]:IsA("Decal")) and v5[v10].Transparency ~= 1 then
                local v11 = v5[v10]
                if u1[v11] == nil then
                    u1[v11] = {
                        ["trans"] = v11.Transparency
                    }
                end
                TweenCreate(v11, TweenInfo.new(p3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    ["Transparency"] = v7
                })
            elseif (v5[v10]:IsA("ParticleEmitter") or v5[v10]:IsA("Beam")) and v5[v10].Enabled == true then
                u1[v5[v10]] = true
                v5[v10].Enabled = false
            elseif v5[v10]:IsA("PointLight") and v5[v10].Enabled == true then
                u1[v5[v10]] = true
                v5[v10].Enabled = false
            end
        end
    else
        for v12 = 1, #v5 do
            if (v5[v12]:IsA("BasePart") or v5[v12]:IsA("Decal")) and u1[v5[v12]] ~= nil then
                local v13 = v5[v12]
                TweenCreate(v13, TweenInfo.new(p3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    ["Transparency"] = u1[v5[v12]].trans
                })
                if v5[v12]:IsA("Decal") then
                    v13.Transparency = 0
                end
                u1[v5[v12]] = nil
            elseif (v5[v12]:IsA("ParticleEmitter") or (v5[v12]:IsA("Beam") or v5[v12]:IsA("PointLight"))) and u1[v5[v12]] ~= nil then
                v5[v12].Enabled = true
            end
        end
    end
end
return {
    ["start"] = function(_, p15, p16, p17, p18, p19) --[[ Name: start, Line 68 ]]
        --[[
        Upvalues:
            [1] = u14
        --]]
        u14(p15, p16, p17, p18, p19)
    end
}