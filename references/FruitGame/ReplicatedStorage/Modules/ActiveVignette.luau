 

local u1 = require(script:WaitForChild("Physics"))
local function u42(p2) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u3 = {}
    local v4 = game.Workspace.CurrentCamera.FieldOfView
    local v5 = game.Workspace.CurrentCamera.FieldOfView
    local v6 = game.Workspace.CurrentCamera.ViewportSize
    local v7 = v6.X / v6.Y
    local v8 = math.rad(v5) * 0.5
    local v9 = math.tan(v8) * v7
    local v10 = math.atan(v9) * 2
    local v11 = v4 + (math.deg(v10) - v4) / 1.65
    local v12 = {}
    local v13 = CFrame.new()
    local v14 = CFrame.Angles
    local v15 = v4 / 2
    local v16 = math.rad(v15)
    local v17 = v11 / 2
    v12.topLeft = v13 * v14(v16, math.rad(v17), 0) * CFrame.new(0, 0, -5)
    local v18 = CFrame.new()
    local v19 = CFrame.Angles
    local v20 = v4 / 2
    local v21 = math.rad(v20)
    local v22 = v11 / 2
    v12.topRight = v18 * v19(v21, -math.rad(v22), 0) * CFrame.new(0, 0, -5)
    local v23 = CFrame.new()
    local v24 = CFrame.Angles
    local v25 = v4 / 2
    local v26 = -math.rad(v25)
    local v27 = v11 / 2
    v12.bottomLeft = v23 * v24(v26, math.rad(v27), 0) * CFrame.new(0, 0, -5)
    local v28 = CFrame.new()
    local v29 = CFrame.Angles
    local v30 = v4 / 2
    local v31 = -math.rad(v30)
    local v32 = v11 / 2
    v12.bottomRight = v28 * v29(v31, -math.rad(v32), 0) * CFrame.new(0, 0, -5)
    local v33 = (v12.topLeft.Position - v12.topRight.Position).magnitude
    local v34 = (v12.topLeft.Position - v12.bottomLeft.Position).magnitude
    local v35 = {
        ["Top"] = {
            ["Size"] = Vector3.new(0.2, 0.2, v33),
            ["Corners"] = { "topLeft", "topRight" }
        },
        ["Bottom"] = {
            ["Size"] = Vector3.new(0.2, 0.2, v33),
            ["Corners"] = { "bottomRight", "bottomLeft" }
        },
        ["Right"] = {
            ["Size"] = Vector3.new(0.2, 0.2, v34),
            ["Corners"] = { "topRight", "bottomRight" }
        },
        ["Left"] = {
            ["Size"] = Vector3.new(0.2, 0.2, v34),
            ["Corners"] = { "topLeft", "bottomLeft" }
        }
    }
    u3.sides = v35
    u3.sideInstances = {}
    u3.corePart = Instance.new("Part")
    u3.corePart.Size = Vector3.new(0.2, 0.2, 0.2)
    u3.corePart.Transparency = 1
    u3.corePart.CanCollide = false
    u3.corePart.CanQuery = false
    u3.corePart.Parent = game.Workspace.Effects
    u3.Connection = game:GetService("RunService").RenderStepped:Connect(function() --[[ Name: updateCorePart, Line 64 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        u3.corePart.CFrame = game.Workspace.CurrentCamera.CFrame
    end)
    for v36, v37 in next, u3.sides do
        local v38 = Instance.new("Part")
        v38.Anchored = false
        v38.Size = v37.Size
        v38.Transparency = 1
        v38.CanQuery = false
        v38.Parent = game.Workspace.Effects
        v38.CanCollide = false
        local v39 = CFrame.new(v12[v37.Corners[1]].Position, v12[v37.Corners[2]].Position) * CFrame.new(0, 0, -v37.Size.Z / 2)
        local v40 = {
            ["Object"] = v38,
            ["Joint"] = u1.joint.new(v38, u3.corePart, CFrame.new(), v39)
        }
        u3.sideInstances[v36] = v40
        for _, v41 in p2 do
            v41:Clone().Parent = v38
        end
    end
    return u3
end
local function u79(p43, p44) --[[ Line: 98 ]]
    local v45 = game.Workspace.CurrentCamera.FieldOfView
    local v46 = game.Workspace.CurrentCamera.FieldOfView
    local v47 = game.Workspace.CurrentCamera.ViewportSize
    local v48 = v47.X / v47.Y
    local v49 = math.rad(v46) * 0.5
    local v50 = math.tan(v49) * v48
    local v51 = math.atan(v50) * 2
    local v52 = v45 + (math.deg(v51) - v45) / 1.65
    local v53 = {}
    local v54 = CFrame.new()
    local v55 = CFrame.Angles
    local v56 = v45 / 2
    local v57 = math.rad(v56)
    local v58 = v52 / 2
    v53.topLeft = v54 * v55(v57, math.rad(v58), 0) * CFrame.new(0, 0, -p44)
    local v59 = CFrame.new()
    local v60 = CFrame.Angles
    local v61 = v45 / 2
    local v62 = math.rad(v61)
    local v63 = v52 / 2
    v53.topRight = v59 * v60(v62, -math.rad(v63), 0) * CFrame.new(0, 0, -p44)
    local v64 = CFrame.new()
    local v65 = CFrame.Angles
    local v66 = v45 / 2
    local v67 = -math.rad(v66)
    local v68 = v52 / 2
    v53.bottomLeft = v64 * v65(v67, math.rad(v68), 0) * CFrame.new(0, 0, -p44)
    local v69 = CFrame.new()
    local v70 = CFrame.Angles
    local v71 = v45 / 2
    local v72 = -math.rad(v71)
    local v73 = v52 / 2
    v53.bottomRight = v69 * v70(v72, -math.rad(v73), 0) * CFrame.new(0, 0, -p44)
    local v74 = (v53.topLeft.Position - v53.topRight.Position).magnitude
    local v75 = (v53.topLeft.Position - v53.bottomLeft.Position).magnitude
    p43.sides.Top.Size = Vector3.new(0.2, 0.2, v74)
    p43.sides.Bottom.Size = Vector3.new(0.2, 0.2, v74)
    p43.sides.Right.Size = Vector3.new(0.2, 0.2, v75)
    p43.sides.Left.Size = Vector3.new(0.2, 0.2, v75)
    for v76, v77 in next, p43.sides do
        local v78 = CFrame.new(v53[v77.Corners[1]].Position, v53[v77.Corners[2]].Position) * CFrame.new(0, 0, -v77.Size.Z / 2)
        p43.sideInstances[v76].Object.Velocity = Vector3.new()
        p43.sideInstances[v76].Joint.C1 = v78
    end
end
local v80 = {}
local u96 = {
    ["new"] = function(p81) --[[ Name: new, Line 136 ]]
        --[[
        Upvalues:
            [1] = u96
        --]]
        local v82 = {
            ["__index"] = u96
        }
        local v83 = setmetatable({}, v82)
        v83.viewmodel = p81
        v83.effects = {}
        v83.enabled = true
        v83.distance = 5
        v83.updating = false
        v83.updateConnections = {
            ["viewport"] = nil,
            ["fov"] = nil
        }
        for _, v84 in next, p81.sideInstances do
            for _, v85 in v84.Object:GetChildren() do
                local v86 = v83.effects
                table.insert(v86, v85)
            end
        end
        return v83
    end,
    ["Enabled"] = function(p87, p88) --[[ Name: Enabled, Line 159 ]]
        p87.enabled = p88
        for _, v89 in p87.effects do
            v89.Enabled = p87.enabled
        end
    end,
    ["SetDistance"] = function(p90, p91) --[[ Name: SetDistance, Line 167 ]]
        --[[
        Upvalues:
            [1] = u79
        --]]
        u79(p90.viewmodel, p91)
        p90.distance = p91
    end,
    ["UpdateEnabled"] = function(u92, p93) --[[ Name: UpdateEnabled, Line 172 ]]
        --[[
        Upvalues:
            [1] = u79
        --]]
        u92.updating = p93
        if u92.updating then
            u92.updateConnections.viewport = game.Workspace.CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(function() --[[ Line: 175 ]]
                --[[
                Upvalues:
                    [1] = u79
                    [2] = u92
                --]]
                u79(u92.viewmodel, u92.distance)
            end)
            u92.updateConnections.fov = game.Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 179 ]]
                --[[
                Upvalues:
                    [1] = u79
                    [2] = u92
                --]]
                u79(u92.viewmodel, u92.distance)
            end)
        else
            if u92.updateConnections.fov then
                u92.updateConnections.fov:Disconnect()
            end
            if u92.upateConnections.viewport then
                u92.updateConnections.viewport:Disconnect()
            end
        end
    end,
    ["Destroy"] = function(p94) --[[ Name: Destroy, Line 192 ]]
        for _, v95 in next, p94.viewmodel.sideInstances do
            v95.Object:Destroy()
        end
        p94.viewmodel.Connection:Disconnect()
        p94.viewmodel.corePart:Destroy()
    end
}
function v80.CreateVignette(_, p97) --[[ Line: 200 ]]
    --[[
    Upvalues:
        [1] = u42
        [2] = u96
    --]]
    local v98 = typeof(p97) == "table"
    assert(v98, "CreateVignette only accepts a table of \'ParticleEmitter\' objects!")
    for _, v99 in p97 do
        local v100 = typeof(v99) == "Instance"
        local v101 = "All objects provided must be an instance \'ParticleEmitter\'! You provided a " .. typeof(v99)
        assert(v100, v101)
        local v102 = v99:IsA("ParticleEmitter")
        local v103 = "All objects provided must be an instance \'ParticleEmitter\'! You provided a " .. v99.ClassName
        assert(v102, v103)
    end
    local v104 = u42(p97)
    return u96.new(v104)
end
return v80