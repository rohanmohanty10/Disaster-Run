 

local u1 = {
    ["TIME_VARIANCE"] = 0.07,
    ["COMPARISON_CHECKS"] = 1,
    ["JUMP_WHEN_STUCK"] = true
}
local u2 = game:FindService("PathfindingService")
local u3 = game:FindService("Players")
local u7 = {
    ["StatusType"] = {
        ["Idle"] = "Idle",
        ["Active"] = "Active"
    },
    ["ErrorType"] = {
        ["LimitReached"] = "LimitReached",
        ["TargetUnreachable"] = "TargetUnreachable",
        ["ComputationError"] = "ComputationError",
        ["AgentStuck"] = "AgentStuck"
    },
    ["__index"] = function(p4, p5) --[[ Line: 36 ]]
        --[[
        Upvalues:
            [1] = u7
        --]]
        if p5 == "Stopped" and not p4._humanoid then
            local v6 = error
            v6((v6 == error and "SimplePath Error: " or "SimplePath: ") .. "Attempt to use Path.Stopped on a non-humanoid.")
        end
        return p4._events[p5] and p4._events[p5].Event or p5 == "LastError" and p4._lastError or (p5 == "Status" and p4._status or u7[p5])
    end
}
local u8 = Instance.new("Part")
u8.Size = Vector3.new(0.3, 0.3, 0.3)
u8.Anchored = true
u8.CanCollide = false
u8.Material = Enum.Material.Neon
u8.Shape = Enum.PartType.Ball
local function u13(p9) --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v10 = {}
    for _, v11 in ipairs(p9) do
        local v12 = u8:Clone()
        v12.Position = v11.Position
        v12.Color = v11 == p9[#p9] and Color3.fromRGB(0, 255, 0) or (v11.Action == Enum.PathWaypointAction.Jump and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 139, 0))
        v12.Parent = workspace
        table.insert(v10, v12)
    end
    return v10
end
local function u17(p14) --[[ Line: 82 ]]
    for v15 = 2, #p14._waypoints do
        local v16 = p14._waypoints[v15].Position - p14._waypoints[v15 - 1].Position
        if vector.magnitude(v16) > 0.1 then
            return v15
        end
    end
    return 2
end
local function u20(p18) --[[ Line: 91 ]]
    if p18._humanoid and p18._humanoid.Health > 0 then
        local v19 = p18._humanoid:GetState()
        if v19 ~= Enum.HumanoidStateType.Jumping and (v19 ~= Enum.HumanoidStateType.Freefall and v19 ~= Enum.HumanoidStateType.Dead) then
            p18._humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end
local function u37(p21, p22) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u20
        [2] = u7
    --]]
    if getmetatable(p21) then
        if p21._humanoid then
            if p22 and p21._currentWaypoint + 1 <= #p21._waypoints then
                if p21._currentWaypoint + 1 < #p21._waypoints then
                    local v23 = p21._waypoints[p21._currentWaypoint - 1]
                    local v24 = p21._waypoints[p21._currentWaypoint]
                    p21._events.WaypointReached:Fire(p21._agent, v23, v24)
                end
                p21._currentWaypoint = p21._currentWaypoint + 1
                if p21._waypoints[p21._currentWaypoint].Action == Enum.PathWaypointAction.Jump then
                    u20(p21)
                end
                p21._humanoid:MoveTo(p21._waypoints[p21._currentWaypoint].Position)
                return
            elseif p22 then
                if p21._moveConnection then
                    p21._moveConnection:Disconnect()
                    p21._moveConnection = nil
                end
                p21._status = u7.StatusType.Idle
                local v25 = p21._visualWaypoints
                if v25 then
                    for _, v26 in ipairs(v25) do
                        v26:Destroy()
                    end
                end
                p21._visualWaypoints = nil
                p21._events.Reached:Fire(p21._agent, p21._waypoints[p21._currentWaypoint])
            else
                if p21._moveConnection then
                    p21._moveConnection:Disconnect()
                    p21._moveConnection = nil
                end
                p21._status = u7.StatusType.Idle
                local v27 = p21._visualWaypoints
                if v27 then
                    for _, v28 in ipairs(v27) do
                        v28:Destroy()
                    end
                end
                p21._visualWaypoints = nil
                local v29 = p21.ErrorType.TargetUnreachable
                p21._lastError = v29
                p21._events.Error:Fire(v29)
            end
        elseif p22 and p21._currentWaypoint + 1 <= #p21._waypoints then
            local v30 = p21._waypoints[p21._currentWaypoint - 1]
            local v31 = p21._waypoints[p21._currentWaypoint]
            p21._events.WaypointReached:Fire(p21._agent, v30, v31)
            p21._currentWaypoint = p21._currentWaypoint + 1
            return
        elseif p22 then
            local v32 = p21._visualWaypoints
            if v32 then
                for _, v33 in ipairs(v32) do
                    v33:Destroy()
                end
            end
            p21._visualWaypoints = nil
            p21._target = nil
            p21._events.Reached:Fire(p21._agent, p21._waypoints[p21._currentWaypoint])
        else
            local v34 = p21._visualWaypoints
            if v34 then
                for _, v35 in ipairs(v34) do
                    v35:Destroy()
                end
            end
            p21._visualWaypoints = nil
            p21._target = nil
            local v36 = p21.ErrorType.TargetUnreachable
            p21._lastError = v36
            p21._events.Error:Fire(v36)
        end
    else
        return
    end
end
local function u42(p38) --[[ Line: 159 ]]
    --[[
    Upvalues:
        [1] = u20
    --]]
    if p38._currentWaypoint == #p38._waypoints then
        return
    elseif p38._agent.PrimaryPart ~= nil then
        local v39 = p38._position
        local v40 = p38._agent.PrimaryPart.Position - p38._position._last
        v39._count = vector.magnitude(v40) <= 0.07 and (p38._position._count + 1 or 0) or 0
        p38._position._last = p38._agent.PrimaryPart.Position
        if p38._position._count >= p38._settings.COMPARISON_CHECKS then
            if p38._settings.JUMP_WHEN_STUCK then
                u20(p38)
            end
            local v41 = p38.ErrorType.AgentStuck
            p38._lastError = v41
            p38._events.Error:Fire(v41)
        end
    end
end
function u7.GetNearestCharacter(p43) --[[ Line: 175 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v44 = (1 / 0)
    local v45 = nil
    for _, v46 in ipairs(u3:GetPlayers()) do
        local v47 = v46.Character
        if v47 then
            local v48 = v47.PrimaryPart
            if v48 then
                local v49 = v48.Position - p43
                local v50 = vector.magnitude(v49)
                if v50 < v44 then
                    v45 = v47
                    v44 = v50
                end
            end
        end
    end
    return v45
end
function u7.new(p51, p52, p53) --[[ Line: 195 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u7
        [4] = u20
    --]]
    if not (p51 and (p51:IsA("Model") and p51.PrimaryPart)) then
        local v54 = error
        v54((v54 == error and "SimplePath Error: " or "SimplePath: ") .. "Pathfinding agent must be a valid Model Instance with a set PrimaryPart.")
    end
    local v55 = {
        ["_settings"] = p53 or u1,
        ["_events"] = {
            ["Reached"] = Instance.new("BindableEvent"),
            ["WaypointReached"] = Instance.new("BindableEvent"),
            ["Blocked"] = Instance.new("BindableEvent"),
            ["Error"] = Instance.new("BindableEvent"),
            ["Stopped"] = Instance.new("BindableEvent")
        },
        ["_agent"] = p51,
        ["_humanoid"] = p51:FindFirstChildOfClass("Humanoid"),
        ["_path"] = u2:CreatePath(p52),
        ["_status"] = "Idle",
        ["_t"] = 0,
        ["_position"] = {
            ["_last"] = Vector3.new(0, 0, 0),
            ["_count"] = 0
        }
    }
    local v56 = u7
    local u57 = setmetatable(v55, v56)
    local v58 = p51:GetFullName()
    u57._events.Reached.Name = v58 .. " ReachedEvent"
    u57._events.WaypointReached.Name = v58 .. " WaypointReachedEvent"
    u57._events.Stopped.Name = v58 .. " StoppedEvent"
    u57._events.Blocked.Name = v58 .. " BlockedEvent"
    u57._events.Error.Name = v58 .. " ErrorEvent"
    for v59, v60 in pairs(u1) do
        u57._settings[v59] = u57._settings[v59] == nil and v60 and v60 or u57._settings[v59]
    end
    u57._blockedConnection = u57._path.Blocked:Connect(function(p61) --[[ Line: 233 ]]
        --[[
        Upvalues:
            [1] = u57
            [2] = u20
        --]]
        local v62 = u57._currentWaypoint or 2
        if p61 and (v62 <= p61 and (p61 <= v62 + 1 and (u57._humanoid and u57._waypoints))) then
            u20(u57)
            u57._events.Blocked:Fire(u57._agent, u57._waypoints[p61])
        end
    end)
    if typeof(p51) == "Instance" then
        u57._destroyingConnection = p51.Destroying:Connect(function() --[[ Line: 242 ]]
            --[[
            Upvalues:
                [1] = u57
            --]]
            if u57._destroyingConnection then
                u57._destroyingConnection:Disconnect()
                u57._destroyingConnection = nil
            end
            u57:Destroy()
        end)
    end
    return u57
end
function u7.Destroy(p63) --[[ Line: 256 ]]
    if p63._moveConnection then
        p63._moveConnection:Disconnect()
        p63._moveConnection = nil
    end
    if p63._blockedConnection then
        p63._blockedConnection:Disconnect()
        p63._blockedConnection = nil
    end
    if p63._destroyingConnection then
        p63._destroyingConnection:Disconnect()
        p63._destroyingConnection = nil
    end
    for _, v64 in ipairs(p63._events) do
        v64:Destroy()
    end
    table.clear(p63._events)
    if rawget(p63, "_visualWaypoints") then
        local v65 = p63._visualWaypoints
        if v65 then
            for _, v66 in ipairs(v65) do
                v66:Destroy()
            end
        end
        p63._visualWaypoints = nil
    end
    if p63._path then
        p63._path:Destroy()
    end
    setmetatable(p63, nil)
    for v67, _ in pairs(p63) do
        p63[v67] = nil
    end
end
function u7.Stop(p68) --[[ Line: 291 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if p68._humanoid then
        if p68._status == u7.StatusType.Idle then
            local v70 = (function(p69) --[[ Line: 297 ]]
                warn(debug.traceback(p69))
            end == error and "SimplePath Error: " or "SimplePath: ") .. "Attempt to run Path:Stop() in idle state"
            warn(debug.traceback(v70))
        else
            if p68._moveConnection then
                p68._moveConnection:Disconnect()
                p68._moveConnection = nil
            end
            p68._status = u7.StatusType.Idle
            local v71 = p68._visualWaypoints
            if v71 then
                for _, v72 in ipairs(v71) do
                    v72:Destroy()
                end
            end
            p68._visualWaypoints = nil
            p68._events.Stopped:Fire(p68._model)
        end
    else
        local v73 = error
        v73((v73 == error and "SimplePath Error: " or "SimplePath: ") .. "Attempt to call Path:Stop() on a non-humanoid.")
        return
    end
end
function u7.Run(u74, p75) --[[ Line: 308 ]]
    --[[
    Upvalues:
        [1] = u37
        [2] = u7
        [3] = u42
        [4] = u13
        [5] = u17
    --]]
    if p75 or (u74._humanoid or not u74._target) then
        if u74._path then
            if not p75 or typeof(p75) ~= "Vector3" and not p75:IsA("BasePart") then
                local v76 = error
                v76((v76 == error and "SimplePath Error: " or "SimplePath: ") .. "Pathfinding target must be a valid Vector3 or BasePart.")
            end
            if os.clock() - u74._t <= u74._settings.TIME_VARIANCE and u74._humanoid then
                task.wait(os.clock() - u74._t)
                local v77 = u74.ErrorType.LimitReached
                u74._lastError = v77
                u74._events.Error:Fire(v77)
                return false
            end
            if u74._humanoid then
                u74._t = os.clock()
            end
            local v78 = pcall(u74._path.ComputeAsync, u74._path, u74._agent.PrimaryPart.Position, typeof(p75) == "Vector3" and p75 and p75 or p75.Position)
            if u74._path then
                if not v78 or (u74._path.Status == Enum.PathStatus.NoPath or (#u74._path:GetWaypoints() < 2 or u74._humanoid and u74._humanoid:GetState() == Enum.HumanoidStateType.Freefall)) then
                    local v79 = u74._visualWaypoints
                    if v79 then
                        for _, v80 in ipairs(v79) do
                            v80:Destroy()
                        end
                    end
                    u74._visualWaypoints = nil
                    local v81 = u74.ErrorType.ComputationError
                    u74._lastError = v81
                    u74._events.Error:Fire(v81)
                    return false
                end
                if u74._agent.PrimaryPart == nil then
                    local v82 = u74._visualWaypoints
                    if v82 then
                        for _, v83 in ipairs(v82) do
                            v83:Destroy()
                        end
                    end
                    u74._visualWaypoints = nil
                    return false
                end
                u74._status = u74._humanoid and u7.StatusType.Active or u7.StatusType.Idle
                u74._target = p75
                pcall(function() --[[ Line: 351 ]]
                    --[[
                    Upvalues:
                        [1] = u74
                    --]]
                    u74._agent.PrimaryPart:SetNetworkOwner(nil)
                end)
                u74._waypoints = u74._path:GetWaypoints()
                u74._currentWaypoint = 2
                if u74._humanoid then
                    u42(u74)
                end
                local v84 = u74._visualWaypoints
                if v84 then
                    for _, v85 in ipairs(v84) do
                        v85:Destroy()
                    end
                end
                local v86 = u74.Visualize
                if v86 then
                    v86 = u13(u74._waypoints)
                end
                u74._visualWaypoints = v86
                local v87 = u74._humanoid
                if v87 then
                    v87 = u74._moveConnection or u74._humanoid.MoveToFinished:Connect(function(...) --[[ Line: 365 ]]
                        --[[
                        Upvalues:
                            [1] = u37
                            [2] = u74
                        --]]
                        u37(u74, ...)
                    end)
                end
                u74._moveConnection = v87
                if u74._humanoid then
                    u74._humanoid:MoveTo(u74._waypoints[u74._currentWaypoint].Position)
                elseif #u74._waypoints == 2 then
                    u74._target = nil
                    local v88 = u74._visualWaypoints
                    if v88 then
                        for _, v89 in ipairs(v88) do
                            v89:Destroy()
                        end
                    end
                    u74._visualWaypoints = nil
                    u74._events.Reached:Fire(u74._agent, u74._waypoints[2])
                else
                    u74._currentWaypoint = u17(u74)
                    u37(u74, true)
                end
                return true
            end
        end
    else
        u37(u74, true)
        return
    end
end
return u7