 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local u2 = require(v1.Modules.OceanModule)
v1.Assets.ClientFX:WaitForChild("Wave4", 3)
local u3 = v1.Assets.ClientFX:WaitForChild("FarPlane", 3)
local u4 = u2.PlaneSize
local u5 = u2.NumPlaneRows
local u6 = u2.SeaLevel
local u7 = u4 * 0.5
local u33 = (function() --[[ Name: InitFarPlanes, Line 17 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
        [3] = u3
        [4] = u2
        [5] = u6
    --]]
    local v8 = u5 * u4 + u4
    local v9 = u5 * u4 + u4
    local v10 = Vector3.new(v8, 0, v9)
    local v11 = u3:Clone()
    v11.Size = v10
    local u12 = {}
    local u13 = {}
    for v14 = -1, 1, 2 do
        local v15 = Vector3.new(v14, 1, 0)
        local v16 = v11:Clone()
        v16.Parent = u2.OceanMeshes.farPlaneMeshs
        u12[v10 * v15] = v16
        table.insert(u13, v16)
        local v17 = Vector3.new(-1, 1, v14)
        local v18 = v11:Clone()
        v18.Parent = u2.OceanMeshes.farPlaneMeshs
        u12[v10 * v17] = v18
        table.insert(u13, v18)
        local v19 = Vector3.new(0, 1, v14)
        local v20 = v11:Clone()
        v20.Parent = u2.OceanMeshes.farPlaneMeshs
        u12[v10 * v19] = v20
        table.insert(u13, v20)
        local v21 = Vector3.new(1, 1, v14)
        local v22 = v11:Clone()
        v22.Parent = u2.OceanMeshes.farPlaneMeshs
        u12[v10 * v21] = v22
        table.insert(u13, v22)
    end
    local v23 = workspace.Terrain:GetAttribute("OceanTransparency")
    local function v26() --[[ Line: 60 ]]
        --[[
        Upvalues:
            [1] = u13
        --]]
        local v24 = workspace.Terrain:GetAttribute("OceanTransparency")
        for v25 = 1, #u13 do
            u13[v25].Transparency = v24
        end
    end
    for v27 = 1, #u13 do
        u13[v27].Transparency = v23
    end
    workspace.Terrain:GetAttributeChangedSignal("OceanTransparency"):Connect(v26)
    return function(p28) --[[ Line: 71 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u12
            [3] = u13
        --]]
        local v29 = CFrame.new(p28.X, u6, p28.Y)
        local v30 = {}
        for v31 in next, u12 do
            local v32 = v29 + v31
            table.insert(v30, v32)
        end
        workspace:BulkMoveTo(u13, v30, Enum.BulkMoveMode.FireCFrameChanged)
    end
end)()
local u34 = workspace.CurrentCamera
local u35 = CFrame.Angles(0, 1.5707963267948966, 0)
local u36 = u34.CFrame * u35
local u37 = u36.X
local u38 = u36.Z
local u39 = Vector2.new(9000000000, 9000000000)
game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u34
        [3] = u36
        [4] = u35
        [5] = u37
        [6] = u38
        [7] = u4
        [8] = u7
        [9] = u39
        [10] = u33
    --]]
    debug.profilebegin("Far Ocean update [Client]")
    if u2.NoRender then
        debug.profileend()
    else
        u36 = u34.CFrame * u35
        local v40 = u36.X
        local v41 = u36.Z
        u37 = v40
        u38 = v41
        local v42 = Vector2.new
        local v43 = u4
        local v44 = u37 / v43
        local v45 = math.ceil(v44) * v43 - u7
        local v46 = u4
        local v47 = u38 / v46
        local v48 = v42(v45, math.ceil(v47) * v46 - u7)
        if v48 ~= u39 then
            u39 = v48
            u33(v48)
        end
        debug.profileend()
    end
end)