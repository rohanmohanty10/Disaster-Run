 

local u1 = game:GetService("CollectionService")
local u2 = game:GetService("RunService")
local u3 = require(script.Settings)
local v4 = require(script.VectorMap)
local u5 = {
    ["WindDirection"] = Vector3.new(0.5, 0, 0.5),
    ["WindSpeed"] = 20,
    ["WindPower"] = 0.5
}
local u6 = Instance.new("BindableEvent")
local u7 = Instance.new("BindableEvent")
local u8 = Instance.new("BindableEvent")
local u9 = Instance.new("BindableEvent")
local u10 = Instance.new("BindableEvent")
return {
    ["RenderDistance"] = 130,
    ["MaxRefreshRate"] = 0.03333333333333333,
    ["SharedSettings"] = u3.new(script),
    ["ObjectMetadata"] = {},
    ["VectorMap"] = v4.new(),
    ["Handled"] = 0,
    ["Active"] = 0,
    ["_partList"] = table.create(500),
    ["_cframeList"] = table.create(500),
    ["ObjectShakeAdded"] = u6.Event,
    ["ObjectShakeRemoved"] = u7.Event,
    ["ObjectShakeUpdated"] = u8.Event,
    ["Paused"] = u9.Event,
    ["Resumed"] = u10.Event,
    ["Connect"] = function(u11, p12, p13) --[[ Name: Connect, Line 62 ]]
        local u14 = u11[p12]
        local v15 = typeof(u14) == "function"
        local v16 = "Unknown function: " .. p12
        assert(v15, v16)
        return p13:Connect(function(...) --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u11
            --]]
            return u14(u11, ...)
        end)
    end,
    ["AddObjectShake"] = function(p17, p18, p19) --[[ Name: AddObjectShake, Line 71 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u6
        --]]
        if typeof(p18) == "Instance" then
            if p18:IsA("BasePart") or p18:IsA("Bone") then
                local v20 = p17.ObjectMetadata
                if not v20[p18] then
                    p17.Handled = p17.Handled + 1
                    local v21 = {}
                    local v22 = p17.VectorMap
                    local v23
                    if p18:IsA("Bone") then
                        v23 = p18.WorldPosition
                    else
                        v23 = p18.Position
                    end
                    v21.ChunkKey = v22:AddObject(v23, p18)
                    v21.Settings = u3.new(p18)
                    v21.Seed = math.random(5000) * 0.32
                    local v24
                    if p18:IsA("Bone") then
                        v24 = p18.WorldCFrame
                    else
                        v24 = p18.CFrame
                    end
                    v21.Origin = v24
                    v21.LastUpdate = os.clock()
                    v20[p18] = v21
                    if p19 then
                        p17:UpdateObjectSettings(p18, p19)
                    end
                    u6:Fire(p18)
                end
            else
                return
            end
        else
            return
        end
    end,
    ["RemoveObjectShake"] = function(p25, p26) --[[ Name: RemoveObjectShake, Line 107 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        if typeof(p26) == "Instance" then
            local v27 = p25.ObjectMetadata
            local v28 = v27[p26]
            if v28 then
                p25.Handled = p25.Handled - 1
                v27[p26] = nil
                v28.Settings:Destroy()
                p25.VectorMap:RemoveObject(v28.ChunkKey, p26)
                if p26:IsA("BasePart") then
                    p26.CFrame = v28.Origin
                elseif p26:IsA("Bone") then
                    p26.WorldCFrame = v28.Origin
                end
            end
            u7:Fire(p26)
        end
    end,
    ["Update"] = function(p29, p30) --[[ Name: Update, Line 131 ]]
        debug.profilebegin("WindShake")
        local u31 = 0
        debug.profilebegin("Update")
        local u32 = os.clock()
        local u33 = p30 * 3
        local v34 = p30 * 5
        local u35 = math.min(1, v34)
        local u36 = 0
        local u37 = p29._partList
        local u38 = p29._cframeList
        table.clear(u37)
        table.clear(u38)
        local u39 = p29.ObjectMetadata
        local v40 = workspace.CurrentCamera
        local u41 = v40.CFrame.Position
        local u42 = p29.RenderDistance
        local u43 = p29.MaxRefreshRate
        local v44 = p29.SharedSettings
        local u45 = v44.WindPower
        local u46 = v44.WindSpeed
        local u47 = v44.WindDirection
        p29.VectorMap:ForEachObjectInView(v40, u42, function(p48, p49) --[[ Line: 161 ]]
            --[[
            Upvalues:
                [1] = u39
                [2] = u41
                [3] = u42
                [4] = u33
                [5] = u43
                [6] = u32
                [7] = u31
                [8] = u47
                [9] = u45
                [10] = u46
                [11] = u35
                [12] = u36
                [13] = u37
                [14] = u38
            --]]
            local v50 = u39[p49]
            local v51 = v50.LastUpdate or 0
            local v52 = p48 == "Bone"
            local v53
            if v52 then
                v53 = p49.WorldCFrame
            else
                v53 = p49.CFrame
            end
            local v54 = (u41 - v53.Position).Magnitude / u42
            local v55 = v54 * v54
            local v56 = 1 / math.random(60, 120)
            if u33 * v55 + u43 >= u32 - v51 + v56 then
                return
            else
                v50.LastUpdate = u32
                u31 = u31 + 1
                local v57 = v50.Settings
                local v58 = v57.WindDirection or u47
                if v58.Magnitude < 0.00001 then
                    return
                else
                    local v59 = (v57.WindPower or u45) * 0.2
                    if v59 < 0.00001 then
                        return
                    else
                        local v60 = u32 * ((v57.WindSpeed or u46) * 0.08)
                        if v60 < 0.00001 then
                            return
                        else
                            local v61 = v50.Seed
                            local v62 = (math.noise(v60, 0, v61) + 0.4) * v59
                            local v63 = u35 + v55
                            local v64 = math.clamp(v63, 0.1, 0.5)
                            local v65 = v59 / 3
                            local v66 = v50.Origin * (v57.PivotOffset or CFrame.identity)
                            local v67 = v66:VectorToObjectSpace(v58)
                            if v52 then
                                p49.Transform = p49.Transform:Lerp(CFrame.fromAxisAngle(v67:Cross(Vector3.new(0, 1, 0)), -v62) * CFrame.Angles(math.noise(v61, 0, v60) * v65, math.noise(v61, v60, 0) * v65, math.noise(v60, v61, 0) * v65) + v67 * v62 * v59, v64)
                            else
                                u36 = u36 + 1
                                u37[u36] = p49
                                u38[u36] = v53:Lerp(v66 * CFrame.fromAxisAngle(v67:Cross(Vector3.new(0, 1, 0)), -v62) * CFrame.Angles(math.noise(v61, 0, v60) * v65, math.noise(v61, v60, 0) * v65, math.noise(v60, v61, 0) * v65) * (v57.PivotOffsetInverse or CFrame.identity) + v58 * v62 * (v59 * 2), v64)
                            end
                        end
                    end
                end
            end
        end)
        p29.Active = u31
        debug.profileend()
        workspace:BulkMoveTo(u37, u38, Enum.BulkMoveMode.FireCFrameChanged)
        debug.profileend()
    end,
    ["Pause"] = function(p68) --[[ Name: Pause, Line 247 ]]
        --[[
        Upvalues:
            [1] = u9
        --]]
        if p68.UpdateConnection then
            p68.UpdateConnection:Disconnect()
            p68.UpdateConnection = nil
        end
        p68.Active = 0
        p68.Running = false
        u9:Fire()
    end,
    ["Resume"] = function(p69) --[[ Name: Resume, Line 259 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u10
        --]]
        if not p69.Running then
            p69.Running = true
            p69.UpdateConnection = p69:Connect("Update", u2.Heartbeat)
            u10:Fire()
        end
    end,
    ["Init"] = function(u70, p71) --[[ Name: Init, Line 272 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u1
        --]]
        if not u70.Initialized then
            local v72 = script:GetAttribute("WindPower")
            local v73 = script:GetAttribute("WindSpeed")
            local v74 = script:GetAttribute("WindDirection")
            if typeof(v72) ~= "number" then
                script:SetAttribute("WindPower", u5.WindPower)
            end
            if typeof(v73) ~= "number" then
                script:SetAttribute("WindSpeed", u5.WindSpeed)
            end
            if typeof(v74) ~= "Vector3" then
                script:SetAttribute("WindDirection", u5.WindDirection)
            end
            u70:Cleanup()
            u70.Initialized = true
            u70.AddedConnection = u70:Connect("AddObjectShake", (u1:GetInstanceAddedSignal("WindShake")))
            u70.RemovedConnection = u70:Connect("RemoveObjectShake", (u1:GetInstanceRemovedSignal("WindShake")))
            for _, v75 in u1:GetTagged("WindShake") do
                u70:AddObjectShake(v75)
            end
            if p71 and p71.MatchWorkspaceWind then
                u70:MatchWorkspaceWind()
                u70.WorkspaceWindConnection = workspace:GetPropertyChangedSignal("GlobalWind"):Connect(function() --[[ Line: 312 ]]
                    --[[
                    Upvalues:
                        [1] = u70
                    --]]
                    u70:MatchWorkspaceWind()
                end)
            end
            u70:Resume()
        end
    end,
    ["Cleanup"] = function(p76) --[[ Name: Cleanup, Line 321 ]]
        if p76.Initialized then
            p76:Pause()
            if p76.AddedConnection then
                p76.AddedConnection:Disconnect()
                p76.AddedConnection = nil
            end
            if p76.RemovedConnection then
                p76.RemovedConnection:Disconnect()
                p76.RemovedConnection = nil
            end
            if p76.WorkspaceWindConnection then
                p76.WorkspaceWindConnection:Disconnect()
                p76.WorkspaceWindConnection = nil
            end
            table.clear(p76.ObjectMetadata)
            p76.VectorMap:ClearAll()
            p76.Handled = 0
            p76.Active = 0
            p76.Initialized = false
        end
    end,
    ["UpdateObjectSettings"] = function(p77, p78, p79) --[[ Name: UpdateObjectSettings, Line 351 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        if typeof(p78) == "Instance" then
            if typeof(p79) == "table" then
                if p77.ObjectMetadata[p78] or p78 == script then
                    for v80, v81 in p79 do
                        p78:SetAttribute(v80, v81)
                    end
                    u8:Fire(p78)
                end
            else
                return
            end
        else
            return
        end
    end,
    ["UpdateAllObjectSettings"] = function(p82, p83) --[[ Name: UpdateAllObjectSettings, Line 371 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        if typeof(p83) == "table" then
            for v84, _ in p82.ObjectMetadata do
                for v85, v86 in p83 do
                    v84:SetAttribute(v85, v86)
                end
                u8:Fire(v84)
            end
        end
    end,
    ["SetDefaultSettings"] = function(p87, p88) --[[ Name: SetDefaultSettings, Line 384 ]]
        p87:UpdateObjectSettings(script, p88)
    end,
    ["MatchWorkspaceWind"] = function(p89) --[[ Name: MatchWorkspaceWind, Line 388 ]]
        local v90 = workspace.GlobalWind
        local v91 = v90.Unit
        local v92 = v90.Magnitude
        local v93, v94
        if v92 > 0 then
            v93 = v92 <= 1 and 0.3 or math.log10(v92) + 0.2
            if v92 < 100 then
                v94 = v92 * 1.2 + 5
            else
                v94 = 125
            end
        else
            v94 = 0
            v93 = 0
        end
        p89:SetDefaultSettings({
            ["WindDirection"] = v91,
            ["WindSpeed"] = v94,
            ["WindPower"] = v93
        })
    end
}