 

local u1 = require(script.Parent.Range)
local u40 = {
    ["Loop"] = function(p2, p3, u4, u5) --[[ Name: Loop, Line 5 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v6 = {}
        for _, v7 in pairs(p3:GetChildren()) do
            if v7.Texture then
                table.insert(v6, v7)
            end
        end
        if #v6 ~= 0 then
            table.sort(v6, function(p8, p9) --[[ Line: 16 ]]
                local v10 = p8.Name
                local v11 = tonumber(v10)
                local v12 = p9.Name
                return v11 < tonumber(v12)
            end)
            local u13 = {}
            for _, v14 in ipairs(v6) do
                local v15 = v14.Texture
                table.insert(u13, v15)
            end
            local u16 = 1 / u1.RandomValueFromRange(p2.FlipbookFramerate)
            local u17 = p2.FlipbookStartRandom and (math.random(1, #u13) or 1) or 1
            local u18 = tick()
            task.spawn(function() --[[ Line: 32 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u5
                    [3] = u4
                    [4] = u13
                    [5] = u17
                    [6] = u16
                --]]
                while tick() - u18 < u5 do
                    u4.Texture = u13[u17]
                    u17 = u17 + 1
                    if u17 > #u13 then
                        u17 = 1
                    end
                    task.wait(u16)
                end
            end)
        end
    end,
    ["OneShot"] = function(p19, p20, u21, p22) --[[ Name: OneShot, Line 46 ]]
        local v23 = {}
        for _, v24 in pairs(p20:GetChildren()) do
            if v24.Texture then
                table.insert(v23, v24)
            end
        end
        if #v23 == 0 then
            return
        else
            table.sort(v23, function(p25, p26) --[[ Line: 58 ]]
                local v27 = p25.Name
                local v28 = tonumber(v27)
                local v29 = p26.Name
                return v28 < tonumber(v29)
            end)
            local u30 = {}
            for _, v31 in ipairs(v23) do
                local v32 = v31.Texture
                table.insert(u30, v32)
            end
            if #u30 ~= 0 then
                local u33 = p22 / #u30
                local u34 = p19.FlipbookStartRandom and (math.random(1, #u30) or 1) or 1
                task.spawn(function() --[[ Line: 75 ]]
                    --[[
                    Upvalues:
                        [1] = u30
                        [2] = u34
                        [3] = u21
                        [4] = u33
                    --]]
                    for _ = 1, #u30 do
                        if u34 > #u30 then
                            break
                        end
                        u21.Texture = u30[u34]
                        u34 = u34 + 1
                        task.wait(u33)
                    end
                end)
            end
        end
    end,
    ["Flip"] = function(p35, p36, p37, p38) --[[ Name: Flip, Line 87 ]]
        --[[
        Upvalues:
            [1] = u40
        --]]
        local v39 = p35.FlipbookMode
        if v39 == Enum.ParticleFlipbookMode.Loop then
            u40.Loop(p35, p36, p37, p38)
            return
        elseif v39 == Enum.ParticleFlipbookMode.OneShot then
            u40.OneShot(p35, p36, p37, p38)
        end
    end
}
return u40