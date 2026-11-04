 

local u1 = game:GetService("CollectionService")
local u2 = require("../obj/ObjectCache")
require("../types")
local u3 = require("../mod/utility")
local u4 = require("../mod/common/flipbook")
return {
    ["init"] = function(p5) --[[ Name: init, Line 11 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u4
            [4] = u1
        --]]
        local v6 = Instance.new("Decal")
        local v7 = Instance.new("Part")
        v7.Name = "DO_NOT_REMOVE_ForgeTextureCache"
        v7.Transparency = 1
        v7.Size = Vector3.new(0, 0, 0)
        v7.Archivable = false
        v7.Anchored = true
        v7.CanCollide = false
        v7.CanQuery = false
        v7.Locked = true
        v7.Parent = workspace.Terrain
        u3.protectParent(p5, v7)
        local u9 = u2.new(v6, v7, {
            ["size"] = 360,
            ["on_free"] = function(p8) --[[ Name: on_free, Line 29 ]]
                p8.value.Texture = ""
            end
        })
        local u10 = {}
        local function u24(p11, u12, p13) --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u9
                [3] = u10
            --]]
            local v14 = {}
            local u15 = {}
            table.insert(v14, u15)
            local function v19() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u15
                    [3] = u9
                    [4] = u12
                --]]
                u3.cleanupScope(u15)
                u12(function(u16) --[[ Name: add, Line 49 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u15
                    --]]
                    if u16 ~= "" then
                        u9:get(u16).Texture = u16
                        local v17 = u15
                        local function v18() --[[ Line: 57 ]]
                            --[[
                            Upvalues:
                                [1] = u9
                                [2] = u16
                            --]]
                            u9:free(u16)
                        end
                        table.insert(v17, v18)
                    end
                end)
            end
            u3.cleanupScope(u15)
            u12(function(u20) --[[ Name: add, Line 49 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u15
                --]]
                if u20 ~= "" then
                    u9:get(u20).Texture = u20
                    local v21 = u15
                    local function v22() --[[ Line: 57 ]]
                        --[[
                        Upvalues:
                            [1] = u9
                            [2] = u20
                        --]]
                        u9:free(u20)
                    end
                    table.insert(v21, v22)
                end
            end)
            if u3.PLUGIN_CONTEXT and p13 then
                for _, v23 in p13((u3.reboundfn(1, v19))) do
                    table.insert(v14, v23)
                end
            end
            u10[p11] = v14
        end
        local function v45(u25) --[[ Line: 78 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u24
                [3] = u4
            --]]
            if u25:IsDescendantOf(workspace.Terrain) then
                return
            elseif u3.isMeshVFX(u25) then
                local u26 = u25:FindFirstChild("Start")
                if u26 and u26:IsA("BasePart") then
                    u24(u25, function(p27) --[[ Line: 90 ]]
                        --[[
                        Upvalues:
                            [1] = u3
                            [2] = u25
                            [3] = u26
                            [4] = u4
                        --]]
                        local v28, v29 = u3.getMeshDecals(u25, u26)
                        for _, v31 in v28 do
                            if typeof(v31) ~= "string" then
                                local v31 = v31.Texture or v31
                            end
                            p27(v31)
                        end
                        for _, v32 in v29 do
                            local v33 = u4.getTexturePrefix(u25)
                            for _, v34 in v32 do
                                p27((("%*%*"):format(v33, v34)))
                            end
                        end
                    end, function(p35) --[[ Line: 104 ]]
                        --[[
                        Upvalues:
                            [1] = u26
                        --]]
                        return { u26.DescendantAdded:Connect(p35), u26.DescendantRemoving:Connect(p35) }
                    end)
                end
            elseif u25:IsA("Beam") then
                u24(u25, function(p36) --[[ Line: 111 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                        [2] = u4
                    --]]
                    p36(u25.Texture)
                    local v37 = u4.getFlipbookData(u25)
                    if v37 then
                        local v38 = u4.getTexturePrefix(u25)
                        for _, v39 in v37 do
                            p36((("%*%*"):format(v38, v39)))
                        end
                    end
                end, function(p40) --[[ Line: 123 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                    --]]
                    return { u25:GetPropertyChangedSignal("Texture"):Connect(p40), u25.AttributeChanged:Connect(p40) }
                end)
            else
                u24(u25, function(p41) --[[ Line: 130 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                    --]]
                    local v42 = u25
                    if v42:IsA("ParticleEmitter") then
                        p41(v42.Texture)
                    end
                    for _, v43 in u25:GetDescendants() do
                        if v43:IsA("ParticleEmitter") then
                            p41(v43.Texture)
                        end
                    end
                end, function(p44) --[[ Line: 142 ]]
                    --[[
                    Upvalues:
                        [1] = u25
                    --]]
                    return { u25.DescendantAdded:Connect(p44), u25.DescendantRemoving:Connect(p44) }
                end)
            end
        end
        for _, v46 in u1:GetTagged(u3.TEXTURE_LOAD_TAG) do
            v45(v46)
        end
        u1:GetInstanceAddedSignal(u3.TEXTURE_LOAD_TAG):Connect(v45)
        u1:GetInstanceRemovedSignal(u3.TEXTURE_LOAD_TAG):Connect(function(p47) --[[ Line: 156 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u3
            --]]
            local v48 = u10[p47]
            if v48 then
                u3.cleanupScope(v48)
                u10[p47] = nil
            end
        end)
        local function v50() --[[ Line: 165 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u10
                [3] = u3
            --]]
            u9:destroy()
            for _, v49 in u10 do
                u3.cleanupScope(v49)
            end
        end
        table.insert(p5, v50)
    end
}