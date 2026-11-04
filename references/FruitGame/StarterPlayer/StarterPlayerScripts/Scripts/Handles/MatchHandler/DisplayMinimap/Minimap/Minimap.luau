 

local v1 = {}
local v2 = game:GetService("RunService")
local v3 = require(script:WaitForChild("InternalMethods"))
local u4 = require(script:WaitForChild("Events"))
local u5 = setmetatable({}, {
    ["__index"] = v3
})
local u6 = script:WaitForChild("Configuration")
local u7 = {}
local _ = v2.Heartbeat
local _ = game.Workspace.CurrentCamera
local u8 = math
local u9 = UDim2
local u10 = u8.clamp
local u11 = u9.new
function u5.ImportMap(p12, p13, p14) --[[ Line: 48 ]]
    local v15 = p12:CreateMap(p13, p14)
    v15.Parent = p12.Frame
    if p12.Map then
        p12:RemoveMapConnection(p12.Map)
        p12.Map:Destroy()
    end
    p12.Map = v15
    p12:CreateMapConnections(v15)
    p12:CalculateRatios(v15)
end
function u5.ImportMainBlip(p16, p17, p18, p19) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u4
    --]]
    if p16.MainBlip then
        p16.MainBlip:Destroy()
        p16.MainBlip = nil
        p16.MainPart = nil
    end
    if p19 then
        p16.UsingOrientation = true
    end
    p17.Parent = p16.Map
    p17.AnchorPoint = Vector2.new(0.5, 0.5)
    p17.Position = u9.fromScale(0.5, 0.5)
    p17.ZIndex = 20
    p16.MainBlip = p17
    p16.MainPart = p18
    u4.CreateBindableEvent(p16.MainPartChanged)
    u4.CreateBindableEvent(p16.MainBlipChanged)
end
function u5.ImportBlip(u20, p21, u22, p23, p24) --[[ Line: 75 ]]
    if u22 ~= nil then
        u22.Destroying:Connect(function() --[[ Line: 80 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u22
            --]]
            u20:RemoveBlip(u22)
        end)
        return u20:AddBlip(p21, u22, p23, p24)
    end
    warn("MINIMAP", "Blip must have a part!")
end
function u5.UpdateMainBlipPart(u25, u26) --[[ Line: 86 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    coroutine.wrap(function() --[[ Line: 87 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u26
            [3] = u4
        --]]
        u25.MainPart = nil
        u25.MainPart = u26
        u4.ReturnBindableEvent(u25.MainPartChanged):Fire()
    end)()
end
function u5.UpdateMainBlip(u27, u28) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u4
    --]]
    coroutine.wrap(function() --[[ Line: 95 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u28
            [3] = u9
            [4] = u4
        --]]
        u27.MainBlip:Destroy()
        local v29 = u27
        local v30 = u28
        v30.Parent = u27.Map
        v30.AnchorPoint = Vector2.new(0.5, 0.5)
        v30.Position = u9.fromScale(0.5, 0.5)
        v30.ZIndex = 20
        v29.MainBlip = v30
        u4.ReturnBindableEvent(u27.MainBlipChanged):Fire()
    end)()
end
function u5.EnableBlip(u31, u32) --[[ Line: 102 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    coroutine.wrap(function() --[[ Line: 103 ]]
        --[[
        Upvalues:
            [1] = u31
            [2] = u32
            [3] = u4
        --]]
        local v33 = u31.Blips[u32]
        local v34 = v33.Blip
        u31.ActiveBlips[u32] = v34
        u4.ReturnBindableEvent(u31.ActiveBlips):Fire(u32, true)
        if v33.Orientation then
            u31.ActiveOrientationBlips[u32] = v33.Blip
            u4.ReturnBindableEvent(u31.ActiveOrientationBlips):Fire(u32, true)
        end
        if v34.Name == "stormCenter" and v34:findFirstChild("stormRing") == nil then
            local v35 = script.stormRing:Clone()
            v35.Parent = v34
            v35.LocalScript:SetAttribute("Resolution", script:GetAttribute("Resolution"))
            v35.LocalScript.Disabled = false
        end
        task.wait()
        v34.Visible = true
    end)()
end
function u5.DisableBlip(u36, u37) --[[ Line: 123 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    coroutine.wrap(function() --[[ Line: 124 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u37
            [3] = u4
        --]]
        local v38 = u36.Blips[u37]
        v38.Blip.Visible = false
        u36.ActiveBlips[u37] = nil
        u4.ReturnBindableEvent(u36.ActiveBlips):Fire(u37, false)
        if v38.Orientation then
            u36.ActiveOrientationBlips[u37] = nil
            u4.ReturnBindableEvent(u36.ActiveOrientationBlips):Fire(u37, true)
        end
    end)()
end
function u5.RemoveBlip(u39, u40) --[[ Line: 137 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    coroutine.wrap(function() --[[ Line: 138 ]]
        --[[
        Upvalues:
            [1] = u39
            [2] = u40
            [3] = u4
        --]]
        local v41 = u39.Blips[u40]
        if v41 ~= nil then
            v41.Blip:Destroy()
            u39.ActiveBlips[u40] = nil
            u4.ReturnBindableEvent(u39.ActiveBlips):Fire(u40, false)
            if v41.Orientation then
                u39.ActiveOrientationBlips[u40] = nil
                u4.ReturnBindableEvent(u39.ActiveOrientationBlips):Fire(u40, true)
            end
            u39.Blips[u40] = nil
        end
    end)()
end
function u5.UpdateBlipPart(p42, p43, p44) --[[ Line: 155 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v45 = p42.Blips
    local v46 = p42.ActiveBlips
    local v47 = v45[p43]
    if v47 ~= nil then
        local v48 = u4.ReturnBindableEvent(v46)
        v45[p44] = v47
        v45[p43] = nil
        v46[p44] = v47
        v46[p43] = nil
        v48:Fire(p43, false)
        v48:Fire(p44, true)
        if v47.Orientation then
            local v49 = p42.ActiveOrientationBlips
            local v50 = u4.ReturnBindableEvent(v49)
            v49[p44] = v47
            v49[p43] = nil
            v50:Fire(p43, false)
            v50:Fire(p44, true)
        end
    end
end
function u5.UpdateBlipIcon(p51, p52, _) --[[ Line: 179 ]]
    local v53 = p51.Blips
    local v54 = p51.ActiveBlips
    local _ = p51.ActiveOrientationBlips
    local _ = v53[p52]
    v54[p52] = nil
end
function u5.ChangeMap(p55, p56, p57, p58, p59) --[[ Line: 187 ]]
    p55:AddNewMap(p56, p57, p58, p59)
end
function u5.Run(u60) --[[ Line: 191 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
        [3] = u10
        [4] = u11
        [5] = u8
    --]]
    u6:WaitForChild("UsingOrientation")
    local _ = u6.UsingOrientation.Value
    local u61 = {}
    local u62 = u60.ActiveBlips
    coroutine.wrap(function() --[[ Line: 31 ]]
        --[[
        Upvalues:
            [1] = u62
            [2] = u61
        --]]
        for v63, v64 in pairs(u62) do
            u61[v63] = v64
        end
    end)()
    local u65 = u61
    local u66
    if true then
        u66 = {}
        local u67 = u60.ActiveOrientationBlips
        coroutine.wrap(function() --[[ Line: 31 ]]
            --[[
            Upvalues:
                [1] = u67
                [2] = u66
            --]]
            for v68, v69 in pairs(u67) do
                u66[v68] = v69
            end
        end)()
    else
        u66 = nil
    end
    u4.ReturnBindableEvent(u60.ActiveBlips).Event:Connect(function(p70, p71) --[[ Line: 207 ]]
        --[[
        Upvalues:
            [1] = u60
            [2] = u65
        --]]
        if p71 and u60.Blips[p70] then
            u65[p70] = u60.Blips[p70].Blip
        else
            u65[p70] = nil
        end
    end)
    u4.ReturnBindableEvent(u60.ActiveOrientationBlips).Event:Connect(function(p72, p73) --[[ Line: 215 ]]
        --[[
        Upvalues:
            [1] = u66
            [2] = u60
        --]]
        if p73 then
            u66[p72] = u60.Blips[p72].Blip
        else
            u66[p72] = nil
        end
    end)
    local u74 = u60.MapCenterPoint
    local u75 = CFrame.new(u74.X, 0, u74.Y)
    u4.ReturnBindableEvent(u60.CenterPointChanged).Event:Connect(function() --[[ Line: 225 ]]
        --[[
        Upvalues:
            [1] = u74
            [2] = u60
            [3] = u75
        --]]
        u74 = u60.MapCenterPoint
        u75 = CFrame.new(u74.X, 0, u74.Y)
    end)
    local u76 = u60.TruePixelsPerStudX
    local u77 = u60.TruePixelsPerStudY
    local u78 = u60.MaximumMapOffsetX
    local u79 = u60.MaximumMapOffsetY
    local u80 = u60.MaximumMainBlipOffsetX
    local u81 = u60.MaximumMainBlipOffsetY
    local u82 = u60.MaximumBlipOffsetX
    local u83 = u60.MaximumBlipOffsetY
    local u84 = u60.MaximumOffsetX
    local u85 = u60.MaximumOffsetY
    u4.ReturnBindableEvent(u60.RatiosChanged).Event:Connect(function() --[[ Line: 242 ]]
        --[[
        Upvalues:
            [1] = u76
            [2] = u60
            [3] = u77
            [4] = u78
            [5] = u79
            [6] = u80
            [7] = u81
            [8] = u82
            [9] = u83
            [10] = u84
            [11] = u85
        --]]
        u76 = u60.TruePixelsPerStudX
        u77 = u60.TruePixelsPerStudY
        u78 = u60.MaximumMapOffsetX
        u79 = u60.MaximumMapOffsetY
        u80 = u60.MaximumMainBlipOffsetX
        u81 = u60.MaximumMainBlipOffsetY
        u82 = u60.MaximumBlipOffsetX
        u83 = u60.MaximumBlipOffsetY
        u84 = u60.MaximumOffsetX
        u85 = u60.MaximumOffsetY
    end)
    local u86 = u60.MainPart
    local u87 = u60.MainBlip
    local u88 = u60.Map
    u4.ReturnBindableEvent(u60.MainPartChanged).Event:Connect(function() --[[ Line: 260 ]]
        --[[
        Upvalues:
            [1] = u86
            [2] = u60
        --]]
        u86 = u60.MainPart
    end)
    u4.ReturnBindableEvent(u60.MainBlipChanged).Event:Connect(function() --[[ Line: 263 ]]
        --[[
        Upvalues:
            [1] = u87
            [2] = u60
        --]]
        u87 = u60.MainBlip
    end)
    u4.ReturnBindableEvent(u60.MapChanged).Event:Connect(function() --[[ Line: 266 ]]
        --[[
        Upvalues:
            [1] = u88
            [2] = u60
        --]]
        u88 = u60.Map
    end)
    game["Run Service"].RenderStepped:Connect(function() --[[ Line: 270 ]]
        --[[
        Upvalues:
            [1] = u86
            [2] = u75
            [3] = u76
            [4] = u77
            [5] = u80
            [6] = u81
            [7] = u10
            [8] = u87
            [9] = u11
            [10] = u88
            [11] = u78
            [12] = u8
            [13] = u79
            [14] = u65
            [15] = u82
            [16] = u83
        --]]
        local v89 = u75:PointToObjectSpace(u86.Position)
        local v90 = v89.X
        local v91 = v89.Z
        local v92 = u77
        local v93 = u80
        local v94 = u81
        local v95 = u10(v90 * u76, -v93, v93)
        local v96 = u10(v91 * v92, -v94, v94)
        u87.Position = u11(0.5, v95, 0.5, v96)
        local v97 = u78
        local v98 = -u8.abs(v97)
        local v99 = u78
        local v100 = u79
        local v101 = -u8.abs(v100)
        local v102 = u79
        u88.Position = u11(0.5, u10(-v95, v98, (u8.abs(v99))), 0.5, (u10(-v96, v101, (u8.abs(v102)))))
        local _, v103, _ = workspace.CurrentCamera.CFrame:ToOrientation()
        u87.Rotation = -u8.deg(v103)
        for v104, v105 in pairs(u65) do
            local v106 = u75:PointToObjectSpace(v104.Position)
            local v107 = v106.X
            local v108 = v106.Z
            local v109 = u77
            local v110 = v107 * u76
            local v111 = v108 * v109
            local v112 = u82
            local v113 = u83
            if v105.Name == "stormCenter" then
                v112 = 100000000000
                v113 = 100000000000
            end
            v105.Position = u11(0.5, u10(v110 + u88.Position.X.Offset, -v112, v112), 0.5, (u10(v111 + u88.Position.Y.Offset, -v113, v113)))
        end
        for v114, v115 in pairs(u65) do
            if v115 ~= u87 and (v115.Name ~= "stormCenter" and (v115.Name ~= "phoLabel" and (v115.Name ~= "hotZone" and (v115.Name ~= "campfire" and (v115.Name ~= "areaLabel" and v115.Name ~= "customBlip"))))) then
                v115.Rotation = -v114.Orientation.Y
            end
        end
    end)
end
function v1.CreateMinimap(p116, p117, p118, p119, p120, p121, p122, p123, p124) --[[ Line: 301 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u7
    --]]
    local v125 = {
        ["__index"] = u5
    }
    local v126 = setmetatable({}, v125)
    v126:Initialise(p116, p117, p118, p119, p120, p121, p122, p123)
    if p124 then
        u7[p124] = v126
    end
    return v126
end
function v1.ReturnMap(p127) --[[ Line: 311 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if not u7[p127] then
        warn("Map not found, have you created a key for your map?")
        warn("Returning nil")
    end
    return u7[p127]
end
return v1