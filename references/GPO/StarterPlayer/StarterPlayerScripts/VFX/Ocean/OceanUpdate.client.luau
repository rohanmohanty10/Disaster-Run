 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
game:GetService("TestService")
local _ = game:GetService("StarterPlayer").StarterPlayerScripts
local v3 = UserSettings().GameSettings
local v4 = v1.Modules
local u5 = require(v4.OceanModule)
local u6 = require(script.Parent.Parallel)
local u7 = u5.VertexGrid
local u8 = u5.PlaneSize
local v9 = u5.NumPlaneRows
local u10 = u5.SeaLevel
local v11 = u5.PlaneParams
local u12 = u8 * 0.5
local u13 = v11.Planes
local u14 = Vector2.new(9000000000, 9000000000)
local u15 = -u12
local u16 = table.create(4000)
local u17 = {}
local u18 = workspace.CurrentCamera
local u19 = v9 * 0.5
local u20 = {}
local u21 = 0.016
local function v23() --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u21
    --]]
    local v22 = UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value
    if v22 == 0 then
        u21 = 0.033
        return
    elseif v22 < 5 then
        u21 = 0.05
    else
        u21 = 0.016
    end
end
v3:GetPropertyChangedSignal("SavedQualityLevel"):Connect(v23)
local v24 = UserSettings():GetService("UserGameSettings").SavedQualityLevel.Value
local u25
if v24 == 0 then
    u21 = 0.033
    u25 = u21
elseif v24 < 5 then
    u21 = 0.05
    u25 = u21
else
    u21 = 0.016
    u25 = u21
end
local u26 = u5.WaveAc
local u27 = u5.WaveBc
local u28 = require(script.BulkWorker)
local u29 = require(script.Worker)
local u30 = u5.OceanGrid
local u31 = true
local u32 = Vector3.new(9000000000, 9000000000, 9000000000)
local u33 = {}
local u34 = 0
local u35 = 0
repeat
    task.wait()
until game.Players.LocalPlayer and game.Players.LocalPlayer.Character
v2.Heartbeat:Connect(function() --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u26
        [3] = u27
        [4] = u18
        [5] = u8
        [6] = u12
        [7] = u14
        [8] = u35
        [9] = u25
        [10] = u19
        [11] = u10
        [12] = u13
        [13] = u15
        [14] = u20
        [15] = u7
        [16] = u16
        [17] = u31
        [18] = u6
        [19] = u28
        [20] = u30
        [21] = u34
        [22] = u32
        [23] = u33
        [24] = u17
        [25] = u29
    --]]
    if u5.NoRender then
        return
    end
    local v36 = workspace:GetServerTimeNow()
    u5.ctA = u26 * v36
    u5.ctB = u27 * v36
    local v37 = u18.CFrame
    local v38 = v37.X
    local v39 = v37.Z
    local v40 = Vector2.new
    local v41 = u8
    local v42 = v38 / v41
    local v43 = math.ceil(v42) * v41 - u12
    local v44 = u8
    local v45 = v39 / v44
    local v46 = v40(v43, math.ceil(v45) * v44 - u12)
    local v47 = v46 ~= u14
    if v47 then
        u35 = os.clock()
    else
        if os.clock() - u35 < u25 then
            return
        end
        u35 = os.clock()
    end
    if v47 then
        debug.profilebegin("Ocean:GridUpdate")
        local v48 = {}
        local v49 = {}
        for v50 = -u19, u19 do
            for v51 = -u19, u19 do
                local v52 = u8
                local v53 = (v38 + v50 * u8) / v52
                local v54 = math.ceil(v53) * v52 - u12
                local v55 = u8
                local v56 = (v39 + v51 * u8) / v55
                local v57 = math.ceil(v56) * v55 - u12
                local v58 = CFrame.new(v54, u10, v57)
                local v59 = false
                for _, v60 in ipairs(u13) do
                    local v61 = v60.CFrame:ToObjectSpace(v58)
                    local v62
                    if u15 < v61.X and (v61.X < u12 and u15 < v61.Z) then
                        v62 = v61.Z < u12
                    else
                        v62 = false
                    end
                    if v62 then
                        v48[v60] = true
                        v59 = true
                        break
                    end
                end
                if not v59 then
                    table.insert(v49, v58)
                end
            end
        end
        for _, v63 in ipairs(u13) do
            if not v48[v63] then
                local v64 = table.remove(v49)
                if not v64 then
                    break
                end
                u20[v63.Object] = v64
                v63.CFrame = v64
                v63.InverseCFrame = v64:Inverse()
                local v65 = v64.X
                local v66 = v64.Z
                v63.X = v65
                v63.Z = v66
            end
            local v67 = v63.X
            local v68 = v63.Z
            for _, v69 in ipairs(v63.Vertices) do
                local v70 = v67 + v69[6]
                local v71 = v68 + v69[7]
                u7:MoveNode(v69, v70, v71)
                v69[1] = v70
                v69[2] = v71
            end
            for _, v72 in ipairs(v63.EdgeVertices) do
                v72[1] = v67 + v72[4]
                v72[2] = v68 + v72[5]
            end
        end
        for v73, v74 in next, u20 do
            v73.CFrame = v74
        end
        table.clear(u20)
        u14 = v46
        debug.profileend()
    end
    table.clear(u16)
    local v75 = u16
    local v76 = false
    if v47 or not u31 then
        u31 = true
        v76 = true
        for _, v77 in ipairs(u13) do
            task.spawn(u6.runParallel, u28, v75, v77, v36, u5, u30)
        end
    else
        local v78 = (u18.CFrame * CFrame.new(0, 0, -395)).Position
        if os.clock() - u34 >= 0.25 or (v78 - u32).Magnitude >= 50 then
            u33 = u5.VertexGrid:RadiusSearch(v78.X, v78.Z, 400)
            u34 = os.clock()
            u32 = v78
        end
        local v79 = #u33
        if v79 > 0 then
            local v80 = v79 / 30
            local v81 = math.ceil(v80)
            local v82 = math.clamp(v81, 1, 8)
            local v83 = v79 / v82
            local v84 = math.ceil(v83)
            for v85 = 1, v82 do
                if not u17[v85] then
                    u17[v85] = table.create(v84)
                end
                table.clear(u17[v85])
            end
            for v86, v87 in ipairs(u33) do
                local v88 = u17[(v86 - 1) % v82 + 1]
                table.insert(v88, v87)
            end
            local v89 = 0
            for v90 = 1, v82 do
                local v91 = u17[v90]
                if #v91 > 0 then
                    task.spawn(u6.runParallel, u29, v75, v91, v36, u25, u5, v89)
                    v89 = v89 + #v91
                end
            end
        end
    end
    u6.waitForThreads()
    debug.profilebegin("Ocean:ApplyBones")
    for _, v92 in ipairs(v75) do
        local v93 = v92[1]
        v93.WorldPosition = v92[2]
        if v76 and v92[3] ~= nil then
            local v94 = v93:GetAttribute("noRender")
            if v92[3] == false and v94 ~= true then
                v93:SetAttribute("noRender", true)
            elseif v92[3] == true and v94 ~= nil then
                v93:SetAttribute("noRender", nil)
            end
        end
    end
    debug.profileend()
end)
script.Parent.Parent.OceanReady:Fire()