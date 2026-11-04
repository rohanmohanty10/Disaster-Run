 

local v1 = game:GetService("Players")
local u2 = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local u3 = game:GetService("HttpService")
local v4 = script.ZoneController
local u5 = v4.Tracker
local u6 = v4.CollectiveWorldModel
local v7 = require(script.Enum)
local u8 = require(script.Janitor)
local u9 = require(script.Parent.Signal)
local u10 = require(v4)
local v11 = require(script.ZonePlusReference)
local u12 = v7.enums
local u13 = u2.Heartbeat
local u14 = u2:IsClient()
if u14 then
    u14 = v1.LocalPlayer
end
local v15 = v11.getObject()
local v16 = u2:IsClient() and "Client" or "Server"
local v17
if v15 then
    v17 = v15:FindFirstChild(v16)
else
    v17 = v15
end
if v17 then
    return require(v15.Value)
end
v11.addToReplicatedStorage()
local u18 = {}
u18.__index = u18
u18.enum = u12
function u18.new(p19) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u12
        [3] = u8
        [4] = u3
        [5] = u10
        [6] = u9
        [7] = u14
    --]]
    local v20 = u18
    local u21 = setmetatable({}, v20)
    local v22 = typeof(p19)
    if v22 ~= "table" and v22 ~= "Instance" then
        error("The zone container must be a model, folder, basepart or table!")
    end
    u21.accuracy = u12.Accuracy.High
    u21.autoUpdate = true
    u21.respectUpdateQueue = true
    local v23 = u8.new()
    u21.janitor = v23
    u21._updateConnections = v23:add(u8.new(), "destroy")
    u21.container = p19
    u21.zoneParts = {}
    u21.overlapParams = {}
    u21.region = nil
    u21.volume = nil
    u21.boundMin = nil
    u21.boundMax = nil
    u21.recommendedMaxParts = nil
    u21.zoneId = u3:GenerateGUID()
    u21.activeTriggers = {}
    u21.occupants = {}
    u21.trackingTouchedTriggers = {}
    u21.enterDetection = u12.Detection.Centre
    u21.exitDetection = u12.Detection.Centre
    u21._currentEnterDetection = nil
    u21._currentExitDetection = nil
    u21.totalPartVolume = 0
    u21.allZonePartsAreBlocks = true
    u21.trackedItems = {}
    u21.settingsGroupName = nil
    u21.worldModel = workspace
    u21.onItemDetails = {}
    u21.itemsToUntrack = {}
    u10.updateDetection(u21)
    u21.updated = v23:add(u9.new(), "destroy")
    local v24 = {
        "player",
        "part",
        "localPlayer",
        "item"
    }
    local v25 = { "entered", "exited" }
    for _, u26 in pairs(v24) do
        local u27 = 0
        local u28 = 0
        for _, v29 in pairs(v25) do
            local v30 = v23:add(u9.new(true), "destroy")
            local u31 = v29:sub(1, 1):upper() .. v29:sub(2)
            u21[u26 .. u31] = v30
            v30.connectionsChanged:Connect(function(p32) --[[ Line: 108 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u14
                    [3] = u31
                    [4] = u27
                    [5] = u28
                    [6] = u10
                    [7] = u21
                --]]
                if u26 == "localPlayer" and (not u14 and p32 == 1) then
                    error(("Can only connect to \'localPlayer%s\' on the client!"):format(u31))
                end
                u27 = u28
                u28 = u28 + p32
                if u27 == 0 and u28 > 0 then
                    u10._registerConnection(u21, u26, u31)
                elseif u27 > 0 and u28 == 0 then
                    u10._deregisterConnection(u21, u26)
                end
            end)
        end
    end
    u18.touchedConnectionActions = {}
    for _, v33 in pairs(v24) do
        local u34 = u21[("_%sTouchedZone"):format(v33)]
        if u34 then
            u21.trackingTouchedTriggers[v33] = {}
            u18.touchedConnectionActions[v33] = function(p35) --[[ Line: 132 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u21
                --]]
                u34(u21, p35)
            end
        end
    end
    u21:_update()
    u10._registerZone(u21)
    v23:add(function() --[[ Line: 143 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u21
        --]]
        u10._deregisterZone(u21)
    end, true)
    return u21
end
function u18.fromRegion(p36, p37) --[[ Line: 150 ]]
    --[[
    Upvalues:
        [1] = u18
    --]]
    local u38 = Instance.new("Model")
    local function u44(p39, p40) --[[ Line: 153 ]]
        --[[
        Upvalues:
            [1] = u44
            [2] = u38
        --]]
        if p40.X > 2024 or (p40.Y > 2024 or p40.Z > 2024) then
            local v41 = p40 * 0.25
            local v42 = p40 * 0.5
            u44(p39 * CFrame.new(-v41.X, -v41.Y, -v41.Z), v42)
            u44(p39 * CFrame.new(-v41.X, -v41.Y, v41.Z), v42)
            u44(p39 * CFrame.new(-v41.X, v41.Y, -v41.Z), v42)
            u44(p39 * CFrame.new(-v41.X, v41.Y, v41.Z), v42)
            u44(p39 * CFrame.new(v41.X, -v41.Y, -v41.Z), v42)
            u44(p39 * CFrame.new(v41.X, -v41.Y, v41.Z), v42)
            u44(p39 * CFrame.new(v41.X, v41.Y, -v41.Z), v42)
            u44(p39 * CFrame.new(v41.X, v41.Y, v41.Z), v42)
        else
            local v43 = Instance.new("Part")
            v43.CFrame = p39
            v43.Size = p40
            v43.Anchored = true
            v43.Parent = u38
        end
    end
    u44(p36, p37)
    local v45 = u18.new(u38)
    v45:relocate()
    return v45
end
function u18._calculateRegion(_, p46, p47) --[[ Line: 180 ]]
    local v48 = {
        ["Min"] = {},
        ["Max"] = {}
    }
    for u49, v50 in pairs(v48) do
        v50.Values = {}
        function v50.parseCheck(p51, p52) --[[ Line: 184 ]]
            --[[
            Upvalues:
                [1] = u49
            --]]
            if u49 == "Min" then
                return p51 <= p52
            end
            if u49 == "Max" then
                return p52 <= p51
            end
        end
        function v50.parse(p53, p54) --[[ Line: 191 ]]
            for v55, v56 in pairs(p54) do
                local v57 = p53.Values[v55] or v56
                if p53.parseCheck(v56, v57) then
                    p53.Values[v55] = v56
                end
            end
        end
    end
    for _, v58 in pairs(p46) do
        local v59 = v58.Size * 0.5
        local v60 = {
            v58.CFrame * CFrame.new(-v59.X, -v59.Y, -v59.Z),
            v58.CFrame * CFrame.new(-v59.X, -v59.Y, v59.Z),
            v58.CFrame * CFrame.new(-v59.X, v59.Y, -v59.Z),
            v58.CFrame * CFrame.new(-v59.X, v59.Y, v59.Z),
            v58.CFrame * CFrame.new(v59.X, -v59.Y, -v59.Z),
            v58.CFrame * CFrame.new(v59.X, -v59.Y, v59.Z),
            v58.CFrame * CFrame.new(v59.X, v59.Y, -v59.Z),
            v58.CFrame * CFrame.new(v59.X, v59.Y, v59.Z)
        }
        for _, v61 in pairs(v60) do
            local v62, v63, v64 = v61:GetComponents()
            local v65 = { v62, v63, v64 }
            v48.Min:parse(v65)
            v48.Max:parse(v65)
        end
    end
    local v66 = {}
    local v67 = {}
    for v68, v69 in pairs(v48) do
        for _, v73 in pairs(v69.Values) do
            local v71 = v68 == "Min" and v67 and v67 or v66
            if not p47 then
                local v72 = (v73 + (v68 == "Min" and -2 or 2) + 2) / 4
                local v73 = math.floor(v72) * 4
            end
            table.insert(v71, v73)
        end
    end
    local v74 = unpack
    local v75 = Vector3.new(v74(v67))
    local v76 = unpack
    local v77 = Vector3.new(v76(v66))
    return Region3.new(v75, v77), v75, v77
end
function u18._displayBounds(p78) --[[ Line: 246 ]]
    if not p78.displayBoundParts then
        p78.displayBoundParts = true
        local v79 = {
            ["BoundMin"] = p78.boundMin,
            ["BoundMax"] = p78.boundMax
        }
        for v80, v81 in pairs(v79) do
            local v82 = Instance.new("Part")
            v82.Anchored = true
            v82.CanCollide = false
            v82.Transparency = 0.5
            v82.Size = Vector3.new(1, 1, 1)
            v82.Color = Color3.fromRGB(255, 0, 0)
            v82.CFrame = CFrame.new(v81)
            v82.Name = v80
            v82.Parent = workspace
            p78.janitor:add(v82, "Destroy")
        end
    end
end
function u18._update(u83) --[[ Line: 265 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v84 = u83.container
    local v85 = {}
    local u86 = 0
    u83._updateConnections:clean()
    local v87 = typeof(v84)
    local v88 = {}
    if v87 == "table" then
        for _, v89 in pairs(v84) do
            if v89:IsA("BasePart") then
                table.insert(v85, v89)
            end
        end
    elseif v87 == "Instance" then
        if v84:IsA("BasePart") then
            table.insert(v85, v84)
        else
            table.insert(v88, v84)
            for _, v90 in pairs(v84:GetDescendants()) do
                if v90:IsA("BasePart") then
                    table.insert(v85, v90)
                else
                    table.insert(v88, v90)
                end
            end
        end
    end
    u83.zoneParts = v85
    u83.overlapParams = {}
    local v91 = true
    for _, u92 in pairs(v85) do
        local _, v93 = pcall(function() --[[ Line: 299 ]]
            --[[
            Upvalues:
                [1] = u92
            --]]
            return u92.Shape.Name
        end)
        if v93 ~= "Block" then
            v91 = false
        end
    end
    u83.allZonePartsAreBlocks = v91
    local v94 = OverlapParams.new()
    v94.FilterType = Enum.RaycastFilterType.Include
    v94.MaxParts = #v85
    v94.FilterDescendantsInstances = v85
    u83.overlapParams.zonePartsWhitelist = v94
    local v95 = OverlapParams.new()
    v95.FilterType = Enum.RaycastFilterType.Exclude
    v95.FilterDescendantsInstances = v85
    u83.overlapParams.zonePartsIgnorelist = v95
    local function v98() --[[ Line: 319 ]]
        --[[
        Upvalues:
            [1] = u83
            [2] = u86
            [3] = u2
        --]]
        if u83.autoUpdate then
            local u96 = tick()
            if u83.respectUpdateQueue then
                u86 = u86 + 1
                u96 = u96 + 0.1
            end
            local u97 = nil
            u97 = u2.Heartbeat:Connect(function() --[[ Line: 327 ]]
                --[[
                Upvalues:
                    [1] = u96
                    [2] = u97
                    [3] = u83
                    [4] = u86
                --]]
                if u96 <= tick() then
                    u97:Disconnect()
                    if u83.respectUpdateQueue then
                        u86 = u86 - 1
                    end
                    if u86 == 0 and u83.zoneId then
                        u83:_update()
                    end
                end
            end)
        end
    end
    local v99 = { "Size", "Position" }
    for _, u100 in pairs(v85) do
        for _, v101 in pairs(v99) do
            u83._updateConnections:add(u100:GetPropertyChangedSignal(v101):Connect(v98), "Disconnect")
        end
        if u100.CollisionGroupId ~= 0 then
            error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
        end
        u83._updateConnections:add(u100:GetPropertyChangedSignal("CollisionGroupId"):Connect(function() --[[ Line: 351 ]]
            --[[
            Upvalues:
                [1] = u100
            --]]
            if u100.CollisionGroupId ~= 0 then
                error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
            end
        end), "Disconnect")
    end
    local v102 = { "ChildAdded", "ChildRemoved" }
    for _, _ in pairs(v88) do
        for _, v103 in pairs(v102) do
            u83._updateConnections:add(u83.container[v103]:Connect(function(p104) --[[ Line: 358 ]]
                --[[
                Upvalues:
                    [1] = u83
                    [2] = u86
                    [3] = u2
                --]]
                if p104:IsA("BasePart") and u83.autoUpdate then
                    local u105 = tick()
                    if u83.respectUpdateQueue then
                        u86 = u86 + 1
                        u105 = u105 + 0.1
                    end
                    local u106 = nil
                    u106 = u2.Heartbeat:Connect(function() --[[ Line: 327 ]]
                        --[[
                        Upvalues:
                            [1] = u105
                            [2] = u106
                            [3] = u83
                            [4] = u86
                        --]]
                        if u105 <= tick() then
                            u106:Disconnect()
                            if u83.respectUpdateQueue then
                                u86 = u86 - 1
                            end
                            if u86 == 0 and u83.zoneId then
                                u83:_update()
                            end
                        end
                    end)
                end
            end), "Disconnect")
        end
    end
    local v107, v108, v109 = u83:_calculateRegion(v85)
    local v110, _, _ = u83:_calculateRegion(v85, true)
    u83.region = v107
    u83.exactRegion = v110
    u83.boundMin = v108
    u83.boundMax = v109
    local v111 = v107.Size
    u83.volume = v111.X * v111.Y * v111.Z
    u83:_updateTouchedConnections()
    u83.updated:Fire()
end
function u18._updateOccupants(p112, p113, p114) --[[ Line: 379 ]]
    local v115 = p112.occupants[p113]
    if not v115 then
        v115 = {}
        p112.occupants[p113] = v115
    end
    local v116 = {}
    for v117, v118 in pairs(v115) do
        local v119 = p114[v117]
        if v119 == nil or v119 ~= v118 then
            v115[v117] = nil
            if not v116.exited then
                v116.exited = {}
            end
            local v120 = v116.exited
            table.insert(v120, v117)
        end
    end
    for v121, _ in pairs(p114) do
        if v115[v121] == nil then
            v115[v121] = v121:IsA("Player") and (v121.Character or true) or true
            if not v116.entered then
                v116.entered = {}
            end
            local v122 = v116.entered
            table.insert(v122, v121)
        end
    end
    return v116
end
function u18._formTouchedConnection(p123, p124) --[[ Line: 409 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v125 = "_touchedJanitor" .. p124
    local v126 = p123[v125]
    if v126 then
        v126:clean()
    else
        p123[v125] = p123.janitor:add(u8.new(), "destroy")
    end
    p123:_updateTouchedConnection(p124)
end
function u18._updateTouchedConnection(p127, p128) --[[ Line: 421 ]]
    local v129 = p127["_touchedJanitor" .. p128]
    if v129 then
        for _, v130 in pairs(p127.zoneParts) do
            v129:add(v130.Touched:Connect(p127.touchedConnectionActions[p128], p127), "Disconnect")
        end
    end
end
function u18._updateTouchedConnections(p131) --[[ Line: 430 ]]
    for v132, _ in pairs(p131.touchedConnectionActions) do
        local v133 = p131["_touchedJanitor" .. v132]
        if v133 then
            v133:cleanup()
            p131:_updateTouchedConnection(v132)
        end
    end
end
function u18._disconnectTouchedConnection(p134, p135) --[[ Line: 441 ]]
    local v136 = "_touchedJanitor" .. p135
    local v137 = p134[v136]
    if v137 then
        v137:cleanup()
        p134[v136] = nil
    end
end
function u18._partTouchedZone(u138, u139) --[[ Line: 453 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u13
        [3] = u12
    --]]
    local u140 = u138.trackingTouchedTriggers.part
    if not u140[u139] then
        local u141 = 0
        local u142 = false
        local u143 = u139.Position
        local u144 = tick()
        local u145 = u138.janitor:add(u8.new(), "destroy")
        u140[u139] = u145
        if not ({
            ["Seat"] = true,
            ["VehicleSeat"] = true
        })[u139.ClassName] and ({
            ["HumanoidRootPart"] = true
        })[u139.Name] then
            u139.CanTouch = false
        end
        local v146 = u139.Size.X * u139.Size.Y * u139.Size.Z * 100000
        local u147 = math.round(v146) * 0.00001
        u138.totalPartVolume = u138.totalPartVolume + u147
        u145:add(u13:Connect(function() --[[ Line: 471 ]]
            --[[
            Upvalues:
                [1] = u141
                [2] = u12
                [3] = u138
                [4] = u139
                [5] = u142
                [6] = u143
                [7] = u144
                [8] = u145
            --]]
            local v148 = tick()
            if u141 <= v148 then
                local v149 = u12.Accuracy.getProperty(u138.accuracy)
                u141 = v148 + v149
                local v150 = u138:findPoint(u139.CFrame) or u138:findPart(u139)
                if u142 then
                    if not v150 then
                        u142 = false
                        u143 = u139.Position
                        u144 = tick()
                        u138.partExited:Fire(u139)
                    end
                else
                    if v150 then
                        u142 = true
                        u138.partEntered:Fire(u139)
                        return
                    end
                    if (u139.Position - u143).Magnitude > 1.5 and v149 <= v148 - u144 then
                        u145:cleanup()
                        return
                    end
                end
            end
        end), "Disconnect")
        u145:add(function() --[[ Line: 502 ]]
            --[[
            Upvalues:
                [1] = u140
                [2] = u139
                [3] = u138
                [4] = u147
            --]]
            u140[u139] = nil
            u139.CanTouch = true
            local v151 = u138
            local v152 = (u138.totalPartVolume - u147) * 100000
            v151.totalPartVolume = math.round(v152) * 0.00001
        end, true)
    end
end
local u156 = {
    ["Ball"] = function(p153) --[[ Line: 510 ]]
        return "GetPartBoundsInRadius", { p153.Position, p153.Size.X }
    end,
    ["Block"] = function(p154) --[[ Line: 513 ]]
        return "GetPartBoundsInBox", { p154.CFrame, p154.Size }
    end,
    ["Other"] = function(p155) --[[ Line: 516 ]]
        return "GetPartsInPart", { p155 }
    end
}
function u18._getRegionConstructor(p157, u158, p159) --[[ Line: 520 ]]
    --[[
    Upvalues:
        [1] = u156
    --]]
    local v160, v161 = pcall(function() --[[ Line: 521 ]]
        --[[
        Upvalues:
            [1] = u158
        --]]
        return u158.Shape.Name
    end)
    local v162 = nil
    local v163 = nil
    if v160 and p157.allZonePartsAreBlocks then
        local v164 = u156[v161]
        if v164 then
            v162, v163 = v164(u158)
        end
    end
    if not v162 then
        v162, v163 = u156.Other(u158)
    end
    if p159 then
        table.insert(v163, p159)
    end
    return v162, v163
end
function u18.findLocalPlayer(p165) --[[ Line: 541 ]]
    --[[
    Upvalues:
        [1] = u14
    --]]
    if not u14 then
        error("Can only call \'findLocalPlayer\' on the client!")
    end
    return p165:findPlayer(u14)
end
function u18._find(p166, p167, p168) --[[ Line: 548 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    u10.updateDetection(p166)
    local v169 = u10.trackers[p167]
    local v170 = u10.getTouchingZones(p168, false, p166._currentEnterDetection, v169)
    for _, v171 in pairs(v170) do
        if v171 == p166 then
            return true
        end
    end
    return false
end
function u18.findPlayer(p172, p173) --[[ Line: 560 ]]
    local v174 = p173.Character
    if v174 then
        v174 = v174:FindFirstChildOfClass("Humanoid")
    end
    if v174 then
        return p172:_find("player", p173.Character)
    else
        return false
    end
end
function u18.findItem(p175, p176) --[[ Line: 569 ]]
    return p175:_find("item", p176)
end
function u18.findPart(p177, p178) --[[ Line: 573 ]]
    local v179, v180 = p177:_getRegionConstructor(p178, p177.overlapParams.zonePartsWhitelist)
    local v181 = p177.worldModel[v179](p177.worldModel, unpack(v180))
    if #v181 > 0 then
        return true, v181
    else
        return false
    end
end
function u18.getCheckerPart(p182) --[[ Line: 583 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    local v183 = p182.checkerPart
    if not v183 then
        v183 = p182.janitor:add(Instance.new("Part"), "Destroy")
        v183.Size = Vector3.new(0.1, 0.1, 0.1)
        v183.Name = "ZonePlusCheckerPart"
        v183.Anchored = true
        v183.Transparency = 1
        v183.CanCollide = false
        p182.checkerPart = v183
    end
    local v184 = p182.worldModel
    if v184 == workspace then
        v184 = u10.getWorkspaceContainer()
    end
    if v183.Parent ~= v184 then
        v183.Parent = v184
    end
    return v183
end
function u18.findPoint(p185, p186) --[[ Line: 604 ]]
    if typeof(p186) == "Vector3" then
        p186 = CFrame.new(p186)
    end
    local v187 = p185:getCheckerPart()
    v187.CFrame = p186
    local v188, v189 = p185:_getRegionConstructor(v187, p185.overlapParams.zonePartsWhitelist)
    local v190 = p185.worldModel[v188](p185.worldModel, unpack(v189))
    if #v190 > 0 then
        return true, v190
    else
        return false
    end
end
function u18._getAll(p191, p192) --[[ Line: 621 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    u10.updateDetection(p191)
    local v193 = {}
    local v194 = u10._getZonesAndItems(p192, {
        ["self"] = true
    }, p191.volume, false, p191._currentEnterDetection)[p191]
    if v194 then
        for v195, _ in pairs(v194) do
            table.insert(v193, v195)
        end
    end
    return v193
end
function u18.getPlayers(p196) --[[ Line: 634 ]]
    return p196:_getAll("player")
end
function u18.getItems(p197) --[[ Line: 638 ]]
    return p197:_getAll("item")
end
function u18.getParts(p198) --[[ Line: 642 ]]
    local v199 = {}
    if p198.activeTriggers.part then
        local v200 = p198.trackingTouchedTriggers.part
        for v201, _ in pairs(v200) do
            table.insert(v199, v201)
        end
        return v199
    else
        local v202 = p198.worldModel:GetPartBoundsInBox(p198.region.CFrame, p198.region.Size, p198.overlapParams.zonePartsIgnorelist)
        for _, v203 in pairs(v202) do
            if p198:findPart(v203) then
                table.insert(v199, v203)
            end
        end
        return v199
    end
end
function u18.getRandomPoint(p204) --[[ Line: 663 ]]
    local v205 = p204.exactRegion
    local v206 = v205.Size
    local v207 = v205.CFrame
    local v208 = Random.new()
    local v209 = nil
    repeat
        local v210 = v207 * CFrame.new(v208:NextNumber(-v206.X / 2, v206.X / 2), v208:NextNumber(-v206.Y / 2, v206.Y / 2), v208:NextNumber(-v206.Z / 2, v206.Z / 2))
        local v211, v212 = p204:findPoint(v210)
        v209 = v211 and true or v209
    until v209
    return v210.Position, v212
end
function u18.setAccuracy(p213, p214) --[[ Line: 682 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    local v215 = tonumber(p214)
    if v215 then
        if not u12.Accuracy.getName(v215) then
            error(("%s is an invalid enumId!"):format(v215))
        end
    else
        v215 = u12.Accuracy[p214]
        if not v215 then
            error(("\'%s\' is an invalid enumName!"):format(p214))
        end
    end
    p213.accuracy = v215
end
function u18.setDetection(p216, p217) --[[ Line: 698 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    local v218 = tonumber(p217)
    if v218 then
        if not u12.Detection.getName(v218) then
            error(("%s is an invalid enumId!"):format(v218))
        end
    else
        v218 = u12.Detection[p217]
        if not v218 then
            error(("\'%s\' is an invalid enumName!"):format(p217))
        end
    end
    p216.enterDetection = v218
    p216.exitDetection = v218
end
function u18.trackItem(u219, u220) --[[ Line: 715 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u5
    --]]
    local v221 = u220:IsA("BasePart")
    local v222
    if v221 then
        v222 = false
    else
        v222 = u220:FindFirstChildOfClass("Humanoid")
        if v222 then
            v222 = u220:FindFirstChild("HumanoidRootPart")
        end
    end
    assert(v221 or v222, "Only BaseParts or Characters/NPCs can be tracked!")
    if not u219.trackedItems[u220] then
        if u219.itemsToUntrack[u220] then
            u219.itemsToUntrack[u220] = nil
        end
        local v223 = u219.janitor:add(u8.new(), "destroy")
        local v224 = {
            ["janitor"] = v223,
            ["item"] = u220,
            ["isBasePart"] = v221,
            ["isCharacter"] = v222
        }
        u219.trackedItems[u220] = v224
        v223:add(u220.AncestryChanged:Connect(function() --[[ Line: 740 ]]
            --[[
            Upvalues:
                [1] = u220
                [2] = u219
            --]]
            if not u220:IsDescendantOf(game) then
                u219:untrackItem(u220)
            end
        end), "Disconnect")
        require(u5).itemAdded:Fire(v224)
    end
end
function u18.untrackItem(p225, p226) --[[ Line: 750 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v227 = p225.trackedItems[p226]
    if v227 then
        v227.janitor:destroy()
    end
    p225.trackedItems[p226] = nil
    require(u5).itemRemoved:Fire(v227)
end
function u18.bindToGroup(p228, p229) --[[ Line: 761 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    p228:unbindFromGroup()
    (u10.getGroup(p229) or u10.setGroup(p229))._memberZones[p228.zoneId] = p228
    p228.settingsGroupName = p229
end
function u18.unbindFromGroup(p230) --[[ Line: 768 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    if p230.settingsGroupName then
        local v231 = u10.getGroup(p230.settingsGroupName)
        if v231 then
            v231._memberZones[p230.zoneId] = nil
        end
        p230.settingsGroupName = nil
    end
end
function u18.relocate(p232) --[[ Line: 778 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if not p232.hasRelocated then
        local v233 = require(u6).setupWorldModel(p232)
        p232.worldModel = v233
        p232.hasRelocated = true
        local v234 = p232.container
        if typeof(v234) == "table" then
            v234 = Instance.new("Folder")
            for _, v235 in pairs(p232.zoneParts) do
                v235.Parent = v234
            end
        end
        p232.relocationContainer = p232.janitor:add(v234, "Destroy", "RelocationContainer")
        v234.Parent = v233
    end
end
function u18._onItemCallback(u236, p237, p238, u239, u240) --[[ Line: 799 ]]
    local v241 = u236.onItemDetails[u239]
    if not v241 then
        v241 = {}
        u236.onItemDetails[u239] = v241
    end
    if #v241 == 0 then
        u236.itemsToUntrack[u239] = true
    end
    table.insert(v241, u239)
    u236:trackItem(u239)
    if u236:findItem(u239) == p238 then
        u240()
        if u236.itemsToUntrack[u239] then
            u236.itemsToUntrack[u239] = nil
            u236:untrackItem(u239)
            return
        end
    else
        local u242 = nil
        u242 = u236[p237]:Connect(function(p243) --[[ Line: 824 ]]
            --[[
            Upvalues:
                [1] = u242
                [2] = u239
                [3] = u240
                [4] = u236
            --]]
            if u242 and p243 == u239 then
                u242:Disconnect()
                u242 = nil
                u240()
                if u236.itemsToUntrack[u239] then
                    u236.itemsToUntrack[u239] = nil
                    u236:untrackItem(u239)
                end
            end
        end)
    end
end
function u18.onItemEnter(p244, ...) --[[ Line: 834 ]]
    p244:_onItemCallback("itemEntered", true, ...)
end
function u18.onItemExit(p245, ...) --[[ Line: 838 ]]
    p245:_onItemCallback("itemExited", false, ...)
end
function u18.destroy(p246) --[[ Line: 842 ]]
    p246:unbindFromGroup()
    p246.janitor:destroy()
end
u18.Destroy = u18.destroy
return u18