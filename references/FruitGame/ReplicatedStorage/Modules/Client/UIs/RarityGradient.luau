 

local v1 = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ToolDesc")
local u2 = require(v1)
local u3 = ColorSequence.new(Color3.new(0, 0, 0))
local u4 = table.create(8)
local u5 = nil
local u6 = {}
local u7 = {}
local u8 = 0
local u9 = {}
local v10 = script:WaitForChild("Gradients")
local u11 = {
    ["Common"] = v10:WaitForChild("Common"),
    ["Uncommon"] = v10:WaitForChild("Uncommon"),
    ["Rare"] = v10:WaitForChild("Rare"),
    ["Epic"] = v10:WaitForChild("Epic"),
    ["Legendary"] = v10:WaitForChild("Legendary"),
    ["Mythical"] = v10:WaitForChild("Mythical"),
    ["Collectable"] = v10:WaitForChild("Collectable")
}
local u63 = {
    ["BindGui"] = function(u12, p13) --[[ Name: BindGui, Line 40 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u8
            [3] = u63
        --]]
        local v14 = u9[u12]
        if v14 == nil then
            u8 = u8 + 1
            local u15 = {
                ["Gui"] = u12,
                ["Id"] = ("%*_%*"):format(u12.Name, u8),
                ["Gradients"] = {},
                ["Connections"] = {}
            }
            local function v17() --[[ Line: 55 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u63
                    [3] = u12
                --]]
                for v16, _ in u15.Gradients do
                    u63.SetGradientActive(v16, u12.Enabled)
                end
            end
            local v18 = u15.Connections
            local v19 = u12:GetPropertyChangedSignal("Enabled")
            table.insert(v18, v19:Connect(v17))
            local v20 = u15.Connections
            local v21 = u12.Destroying
            local function v23() --[[ Line: 62 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u63
                    [3] = u9
                    [4] = u12
                --]]
                for v22, _ in u15.Gradients do
                    u63.UnbindRainbowGradient(v22)
                end
                u9[u12] = nil
            end
            table.insert(v20, v21:Connect(v23))
            v14 = u15
            for v24, _ in u15.Gradients do
                u63.SetGradientActive(v24, u12.Enabled)
            end
            u9[u12] = v14
        end
        v14.Gradients[p13] = true
    end,
    ["BindRainbowGradient"] = function(u25, p26, p27) --[[ Name: BindRainbowGradient, Line 78 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u7
            [3] = u2
            [4] = u63
        --]]
        if not (u6[u25] or u7[u25]) then
            local v28 = u25.Parent
            local v29 = v28:IsA("TextBox") or v28:IsA("TextLabel")
            local v30
            if v29 then
                v30 = v28.Text or nil
            else
                v30 = nil
            end
            local v31 = v30 and u2[v30] and (u2[v30].Rare or "") or ""
            local v32 = (not p27 or p27.Visible ~= false) and true or false
            if p26 and p26.Enabled == false then
                v32 = false
            end
            if v29 and v28.Visible == false then
                v32 = false
            end
            local v33 = {
                ["Active"] = v32,
                ["Text"] = v30,
                ["Rarity"] = v31,
                ["Frame"] = p27,
                ["Gui"] = p26
            }
            if v32 then
                u6[u25] = v33
            else
                u7[u25] = v33
            end
            v28.Destroying:Once(function() --[[ Line: 116 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u25
                --]]
                u63.UnbindRainbowGradient(u25)
            end)
            if p26 and p26.Parent then
                u63.BindGui(p26, u25)
            end
        end
    end,
    ["SetRainbowGradientsFrame"] = function(p34, p35) --[[ Name: SetRainbowGradientsFrame, Line 129 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u7
            [3] = u63
        --]]
        for _, v36 in { u6, u7 } do
            for v37, v38 in v36 do
                if v38.Frame == p34 then
                    u63.SetGradientActive(v37, p35)
                end
            end
        end
    end,
    ["SetRainbowGradientsGui"] = function(p39, p40) --[[ Name: SetRainbowGradientsGui, Line 139 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u7
            [3] = u63
        --]]
        for _, v41 in { u6, u7 } do
            for v42, v43 in v41 do
                if v43.Gui == p39 and (not v43.Frame or v43.Frame.Visible ~= false) then
                    u63.SetGradientActive(v42, p40)
                end
            end
        end
    end,
    ["UnbindRainbowGradient"] = function(p44) --[[ Name: UnbindRainbowGradient, Line 155 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u7
            [3] = u9
        --]]
        local v45 = u6[p44] or u7[p44]
        local v46 = v45 and v45.Gui and u9[v45.Gui]
        if v46 then
            v46.Gradients[p44] = nil
        end
        u6[p44] = nil
        u7[p44] = nil
    end,
    ["SetGradientActive"] = function(p47, p48) --[[ Name: SetGradientActive, Line 172 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u7
        --]]
        local v49 = u6[p47] or u7[p47]
        if v49 == nil then
            return
        else
            v49.Active = p48
            if p48 then
                u6[p47] = v49
                u7[p47] = nil
            else
                u7[p47] = v49
                u6[p47] = nil
            end
        end
    end,
    ["UpdateActiveGradients"] = function() --[[ Name: UpdateActiveGradients, Line 189 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u63
            [3] = u2
            [4] = u3
        --]]
        for v50, v51 in u6 do
            if v51.Gui and v51.Gui.Parent == nil then
                u63.UnbindRainbowGradient(v50)
            else
                local v52 = v50.Parent
                if v52 == nil or v52.Parent == nil then
                    u63.UnbindRainbowGradient(v50)
                else
                    local v53 = (v52:IsA("TextBox") or v52:IsA("TextLabel")) and v52.Text or nil
                    if v53 and v53 ~= v51.Text then
                        if u2[v53] == nil then
                            u63.UnbindRainbowGradient(v50)
                        else
                            if u2[v53].Rare == v51.Rarity then
                                v51.Text = v53
                                goto l15
                            end
                            u63.UnbindRainbowGradient(v50)
                        end
                    else
                        ::l15::
                        if v51.Frame and not v51.Frame.Visible then
                            v51.Active = false
                        end
                        if v51.Gui and not v51.Gui.Enabled then
                            v51.Active = false
                        end
                        if v51.Active == false then
                            u63.SetGradientActive(v50, false)
                        else
                            v50.Color = u3
                        end
                    end
                end
            end
        end
    end,
    ["ApplyRarityGradient"] = function(p54, p55, p56, p57) --[[ Name: ApplyRarityGradient, Line 242 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u11
            [3] = u63
        --]]
        local v58 = u2[p54]
        if v58 == nil then
            return
        else
            local v59 = u11[v58.Rare]
            if v59 ~= nil then
                p55.Enabled = true
                p55.Color = v59.Color
                if v58.Rare == "Legendary" or v58.Chroma ~= nil then
                    u63.BindRainbowGradient(p55, p56, p57)
                end
            end
        end
    end,
    ["GetRainbowGradientColor"] = function() --[[ Name: GetRainbowGradientColor, Line 262 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        return u3
    end,
    ["StartRainbowGradient"] = function() --[[ Name: StartRainbowGradient, Line 266 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u3
            [4] = u63
        --]]
        if u5 then
            warn("[RarityGradient]: RainbowGradient already running!")
        else
            u5 = task.spawn(function() --[[ Line: 272 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u3
                    [3] = u63
                --]]
                while true do
                    task.wait(0.02)
                    local v60 = os.clock() % 1 / 1
                    table.clear(u4)
                    for v61 = 1, 8 do
                        local v62 = v60 - (v61 - 1) / 7
                        if v62 < 0 then
                            v62 = v62 + 1
                        end
                        u4[v61] = ColorSequenceKeypoint.new((v61 - 1) / 7, Color3.fromHSV(v62, 1, 1))
                    end
                    u3 = ColorSequence.new(u4)
                    u63.UpdateActiveGradients()
                end
            end)
        end
    end,
    ["StopRainbowGradient"] = function() --[[ Name: StopRainbowGradient, Line 294 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        if u5 == nil then
            warn("[RarityGradient]: There is no rainbow gradient running")
        else
            task.cancel(u5)
            u5 = nil
        end
    end,
    ["Initialize"] = function() --[[ Name: Initialize, Line 305 ]]
        --[[
        Upvalues:
            [1] = u63
        --]]
        u63.StartRainbowGradient()
    end
}
return u63