 

local u1 = game:GetService("RunService")
local u2 = require(script.Parent.WavePlane)
local u3 = script.Parent:GetAttribute("PlaneSize") or 100
local u4 = script:GetAttribute("PlanesPerUpdate") or 1
local u5 = script:GetAttribute("UpdateRate") or 0.02
local u6 = nil
local u7 = {}
u7.__index = u7
function u7.new(p8, p9, p10, p11) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local v12 = u7
    local v13 = setmetatable({
        ["_player"] = p8,
        ["_resolution"] = p11,
        ["currentChunkPosition"] = Vector3.new(0, 0, 0),
        ["gridSize"] = p9,
        ["height"] = p10,
        ["_planesList"] = {},
        ["_noBoneList"] = {},
        ["_activeThread"] = nil,
        ["_lastUpdate"] = 0,
        ["_couroutineId"] = 0
    }, v12)
    v13:InitializeGrid()
    v13:enableHeartbeat(true)
    return v13
end
function u7.Destroy(p14) --[[ Line: 81 ]]
    p14:enableHeartbeat(false)
    p14._couroutineId = p14._couroutineId + 1
    if p14._planesList then
        for v15, _ in pairs(p14._planesList) do
            v15:Destroy()
        end
        p14._planesList = {}
    end
    p14._activeThread = nil
    p14._couroutineConnection = nil
end
function u7.InitializeGrid(p16) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u6
    --]]
    p16.currentChunkPosition = p16:GetPlayerChunkPosition()
    local v17 = p16.gridSize // 2
    local v18 = p16.gridSize
    for v19 = -v17, v17 do
        for v20 = -v17, v17 do
            local v21 = (p16.currentChunkPosition * Vector3.new(1, 0, 1) + Vector3.new(v19, 0, v20)) * u3
            local v22 = p16.height
            p16:CreatePlane(v21 + Vector3.new(0, v22, 0))
        end
    end
    local v23 = p16.currentChunkPosition * u3
    local v24 = u2.NoBoneResolution
    local v25 = {
        {
            ["x"] = 0,
            ["z"] = v18
        },
        {
            ["x"] = v18,
            ["z"] = 0
        },
        {
            ["x"] = 0,
            ["z"] = -v18
        },
        {
            ["x"] = -v18,
            ["z"] = 0
        }
    }
    local v26 = {
        {
            ["x"] = v18,
            ["z"] = v18
        },
        {
            ["x"] = v18,
            ["z"] = -v18
        },
        {
            ["x"] = -v18,
            ["z"] = -v18
        },
        {
            ["x"] = -v18,
            ["z"] = v18
        }
    }
    for _, v27 in ipairs(v25) do
        local v28 = v27.x * u3
        local v29 = v27.z * u3
        local v30 = (v23 + Vector3.new(v28, 0, v29)) * Vector3.new(1, 0, 1) + p16.height * Vector3.new(0, 1, 0)
        local v31 = u2.new(v24)
        v31.wavePlane.Mesh.Scale = Vector3.new(v18, 1, v18)
        v31:MoveTo(v30)
        p16._noBoneList[v31] = v30
    end
    for _, v32 in ipairs(v26) do
        local v33 = v32.x * u3
        local v34 = v32.z * u3
        local v35 = (v23 + Vector3.new(v33, 0, v34)) * Vector3.new(1, 0, 1) + p16.height * Vector3.new(0, 1, 0)
        local v36 = u2.new(v24)
        v36.wavePlane.Mesh.Scale = Vector3.new(v18, 1, v18)
        v36:MoveTo(v35)
        p16._noBoneList[v36] = v35
    end
    if u6 then
        u6:PivotTo(CFrame.new(p16.currentChunkPosition * u3))
    end
end
function u7.GetPlayerChunkPosition(p37) --[[ Line: 160 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v38 = p37._player.Character
    if v38 then
        v38 = p37._player.Character:GetPivot().Position
    end
    if not v38 then
        return Vector3.new(0, 0, 0)
    end
    local v39 = (v38.X + u3 / 2) // u3
    local v40 = (v38.Z + u3 / 2) // u3
    local v41 = p37.height
    return Vector3.new(v39, v41, v40)
end
function u7.Update(p42) --[[ Line: 173 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u3
    --]]
    local v43 = p42.currentChunkPosition
    p42.currentChunkPosition = p42:GetPlayerChunkPosition()
    if v43 ~= p42.currentChunkPosition then
        p42:UpdateNoBonePosition()
        p42:UpdateGrid()
        if u6 then
            u6:PivotTo(CFrame.new(p42.currentChunkPosition * u3))
        end
    end
end
function u7.UpdateNoBonePosition(p44) --[[ Line: 187 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v45 = p44.gridSize
    local v46 = p44.currentChunkPosition * u3
    local v47 = {
        {
            ["x"] = 0,
            ["z"] = v45
        },
        {
            ["x"] = v45,
            ["z"] = 0
        },
        {
            ["x"] = 0,
            ["z"] = -v45
        },
        {
            ["x"] = -v45,
            ["z"] = 0
        }
    }
    local v48 = {
        {
            ["x"] = v45,
            ["z"] = v45
        },
        {
            ["x"] = v45,
            ["z"] = -v45
        },
        {
            ["x"] = -v45,
            ["z"] = -v45
        },
        {
            ["x"] = -v45,
            ["z"] = v45
        }
    }
    local v49 = {}
    for v50, _ in pairs(p44._noBoneList) do
        table.insert(v49, v50)
    end
    local v51 = 1
    for _, v52 in ipairs(v47) do
        local v53 = v52.x * u3
        local v54 = v52.z * u3
        local v55 = (v46 + Vector3.new(v53, 0, v54)) * Vector3.new(1, 0, 1) + p44.height * Vector3.new(0, 1, 0)
        v49[v51]:MoveTo(v55)
        v51 = v51 + 1
    end
    for _, v56 in ipairs(v48) do
        local v57 = v56.x * u3
        local v58 = v56.z * u3
        local v59 = (v46 + Vector3.new(v57, 0, v58)) * Vector3.new(1, 0, 1) + p44.height * Vector3.new(0, 1, 0)
        v49[v51]:MoveTo(v59)
        v51 = v51 + 1
    end
end
function u7.CreatePlane(p60, p61, p62) --[[ Line: 234 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v63 = u2.new(p62 or p60._resolution)
    v63:MoveTo(p61)
    v63:Activate()
    p60._planesList[v63] = p61
end
function u7.UpdateGrid(u64) --[[ Line: 243 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v65 = u64.currentChunkPosition
    local v66 = u64.gridSize // 2
    local u67 = u64.gridSize * u3
    local u68 = u64.gridSize * u3
    local u69 = (v65 - Vector3.new(1, 1, 1) * v66) * u3
    local u70 = (v65 + Vector3.new(1, 1, 1) * v66) * u3
    if u64._activeThread and coroutine.status(u64._activeThread) ~= "dead" then
        u64._couroutineId = u64._couroutineId + 1
    end
    u64._activeThread = coroutine.create(function() --[[ Line: 259 ]]
        --[[
        Upvalues:
            [1] = u64
            [2] = u69
            [3] = u70
            [4] = u67
            [5] = u68
            [6] = u4
        --]]
        local v71 = u64._couroutineId
        local v72 = 0
        for v73, v74 in pairs(u64._planesList) do
            if u64._couroutineId ~= v71 then
                break
            end
            if v74.X < u69.X or (v74.X > u70.X or (v74.Z < u69.Z or v74.Z > u70.Z)) then
                local v75 = v74.X - u69.X
                local v76 = v74.Z - u69.Z
                local v77 = u69.X + v75 % u67
                local v78 = u69.Z + v76 % u68
                local v79 = u64.height
                local v80 = Vector3.new(v77, v79, v78)
                u64._planesList[v73] = v80
                v73:MoveTo(v80)
            end
            v72 = v72 + 1
            if u4 > 0 and u4 <= v72 then
                coroutine.yield()
                v72 = 0
            end
        end
    end)
end
function u7.enableHeartbeat(u81, p82) --[[ Line: 290 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
    --]]
    if p82 then
        if not u81._couroutineConnection then
            u81._couroutineConnection = u1.Heartbeat:Connect(function(p83) --[[ Line: 293 ]]
                --[[
                Upvalues:
                    [1] = u81
                    [2] = u5
                --]]
                local v84 = u81
                v84._lastUpdate = v84._lastUpdate + p83
                if u81._lastUpdate >= u5 then
                    if u81._activeThread and coroutine.status(u81._activeThread) ~= "dead" then
                        u81._lastUpdate = 0
                        coroutine.resume(u81._activeThread)
                    end
                end
            end)
            return
        end
    elseif u81._couroutineConnection then
        u81._couroutineConnection:Disconnect()
        u81._couroutineConnection = nil
    end
end
function u7.enableTexturePreload(_, p85) --[[ Line: 310 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if p85 then
        if not u6 then
            u6 = script.PBRWaterPreLoad:Clone()
            u6.Parent = workspace
            return
        end
    elseif u6 then
        u6:Destroy()
    end
end
return table.freeze(u7)