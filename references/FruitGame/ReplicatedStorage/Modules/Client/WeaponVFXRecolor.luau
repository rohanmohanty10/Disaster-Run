 

local u1 = require(game:GetService("ReplicatedStorage").Modules.Shared.TailorTransport)
local u2 = game:GetService("Players")
local u3 = game:GetService("ReplicatedStorage")
local u4 = require(u3.Modules.Shared.TailorColorHelper)
local u5 = {}
local function u17(p6) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
        [3] = u1
    --]]
    local v7 = u3:FindFirstChild("CustomSkillColors")
    if v7 then
        local v8 = v7:FindFirstChild(p6.Name)
        if v8 then
            local v9 = {}
            local v10 = {}
            for _, v11 in v8:GetChildren() do
                if v11:IsA("StringValue") and v11.Value ~= "" then
                    local v12 = u1.decode(v11.Value)
                    if v12 then
                        for v13, v14 in v12 do
                            v9[v13] = v14
                            local v15, v16 = pcall(Color3.fromHex, v14)
                            if v15 then
                                v10[v13] = v16
                            end
                        end
                    end
                end
            end
            if next(v9) then
                u5[p6] = {
                    ["colors"] = v9,
                    ["parsed"] = v10
                }
            else
                u5[p6] = nil
            end
        else
            u5[p6] = nil
            return
        end
    else
        u5[p6] = nil
        return
    end
end
local function u22(p18) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u17
    --]]
    local u19 = u2:FindFirstChild(p18.Name)
    if u19 then
        for _, v20 in p18:GetChildren() do
            if v20:IsA("StringValue") then
                v20.Changed:Connect(function() --[[ Line: 54 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u19
                    --]]
                    u17(u19)
                end)
            end
        end
        p18.ChildAdded:Connect(function(p21) --[[ Line: 59 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u19
            --]]
            if p21:IsA("StringValue") then
                u17(u19)
                p21.Changed:Connect(function() --[[ Line: 62 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u19
                    --]]
                    u17(u19)
                end)
            end
        end)
        p18.ChildRemoved:Connect(function() --[[ Line: 67 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u19
            --]]
            u17(u19)
        end)
        u17(u19)
    end
end
local function u25() --[[ Line: 74 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u22
    --]]
    local v23 = u3:FindFirstChild("CustomSkillColors")
    if v23 then
        for _, v24 in v23:GetChildren() do
            u22(v24)
        end
        v23.ChildAdded:Connect(u22)
    end
end
if u3:FindFirstChild("CustomSkillColors") then
    u25()
else
    u3.ChildAdded:Connect(function(p26) --[[ Line: 89 ]]
        --[[
        Upvalues:
            [1] = u25
        --]]
        if p26.Name == "CustomSkillColors" then
            u25()
        end
    end)
end
u2.PlayerRemoving:Connect(function(p27) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    u5[p27] = nil
end)
return {
    ["getWeaponColors"] = function(p28) --[[ Name: getWeaponColors, Line 103 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u5
        --]]
        if p28 then
            local v29 = u2:GetPlayerFromCharacter(p28)
            if v29 then
                local v30 = u5[v29]
                if v30 then
                    return v30.colors
                else
                    return nil
                end
            else
                return nil
            end
        else
            return nil
        end
    end,
    ["getColor"] = function(p31, p32) --[[ Name: getColor, Line 111 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u5
        --]]
        if p31 and p32 then
            local v33 = u2:GetPlayerFromCharacter(p31)
            if v33 then
                local v34 = u5[v33]
                if v34 then
                    return v34.parsed[p32]
                else
                    return nil
                end
            else
                return nil
            end
        else
            return nil
        end
    end,
    ["apply"] = function(p35, p36, p37) --[[ Name: apply, Line 120 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u5
            [3] = u4
        --]]
        if p36 then
            local v38 = u2:GetPlayerFromCharacter(p36)
            if v38 then
                local v39 = u5[v38]
                if v39 then
                    local v40 = v39.colors
                    local v41 = v39.parsed
                    local v42
                    if p37 then
                        local v43 = p37:GetDescendants()
                        table.insert(v43, p37)
                        v42 = {}
                        for _, v44 in v43 do
                            local v45 = v44:GetAttribute("UniqueID")
                            if v45 then
                                v42[v44.Name .. ":" .. v44.ClassName] = v45
                            end
                        end
                    else
                        v42 = nil
                    end
                    local v46 = p35:GetDescendants()
                    table.insert(v46, p35)
                    for v47 = 1, #v46 do
                        local v48 = v46[v47]
                        local v49
                        if v42 then
                            v49 = v42[v48.Name .. ":" .. v48.ClassName]
                        else
                            v49 = v48:GetAttribute("UniqueID")
                        end
                        if v49 then
                            if v48:IsA("Highlight") then
                                local v50 = v49 .. "_fill"
                                local v51 = v49 .. "_outline"
                                local v52 = v41[v50]
                                if v52 then
                                    u4.setHighlightColor(v48, "FillColor", v52)
                                end
                                local v53 = v41[v51]
                                if v53 then
                                    u4.setHighlightColor(v48, "OutlineColor", v53)
                                end
                                if not v52 then
                                    local v54 = v41[v49]
                                    if v54 then
                                        u4.setHighlightColor(v48, "FillColor", v54)
                                    end
                                end
                            elseif v48:IsA("SurfaceAppearance") then
                                local v55 = v49 .. "_tint"
                                local v56 = v49 .. "_emissive"
                                local v57 = v41[v55]
                                if v57 then
                                    u4.setSurfaceAppearanceColor(v48, "Color", v57)
                                end
                                local v58 = v41[v56]
                                if v58 then
                                    u4.setSurfaceAppearanceColor(v48, "EmissiveTint", v58)
                                end
                                if not v57 then
                                    local v59 = v41[v49]
                                    if v59 then
                                        u4.setSurfaceAppearanceColor(v48, "Color", v59)
                                    end
                                end
                            elseif v40[v49] then
                                local v60 = v41[v49]
                                if v60 then
                                    u4.setColor(v48, v60)
                                    if v48:IsA("Beam") and (v48.Parent and v48.Parent:IsA("Folder")) then
                                        for _, v61 in v48.Parent:GetChildren() do
                                            if v61 ~= v48 and (v61:IsA("Beam") and not v61:GetAttribute("UniqueID")) then
                                                u4.setColor(v61, v60)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else
                return
            end
        else
            return
        end
    end
}