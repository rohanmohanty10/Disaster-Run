 

local u1 = workspace.Effects
game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = {}
u3.__index = u3
function u3.new(p4) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    local v5 = u3
    local v6 = setmetatable({}, v5)
    v6.Direction = p4.Direction
    v6.Model = script.Spark:Clone()
    local v7 = Random.new():NextNumber(3, 6)
    v6.Model.CustomPhysicalProperties = PhysicalProperties.new(0.3, 0.1, 1, 0, v7)
    v6.Model.Position = p4.Position
    v6.Model.Parent = u1
    v6.Bounces = math.random(2, 5)
    v6:_main()
    _G.destroy(v6.Model, 3)
    return v6
end
local v8 = RaycastParams.new()
v8.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
v8.FilterType = Enum.RaycastFilterType.Include
function u3._main(p9) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    p9.Model.AssemblyLinearVelocity = p9.Direction
    local v10 = Instance.new("BodyForce")
    local v11 = workspace.Gravity * p9.Model:GetMass() * 0.5
    v10.Force = Vector3.new(0, v11, 0)
    v10.Parent = p9.Model
    local v12 = Random.new():NextNumber(1, 2)
    u2:Create(p9.Model.Trail, TweenInfo.new(v12), {
        ["MaxLength"] = 0.1
    }):Play()
    u2:Create(p9.Model.Att1, TweenInfo.new(v12), {
        ["Position"] = Vector3.new()
    }):Play()
    u2:Create(p9.Model.Att2, TweenInfo.new(v12), {
        ["Position"] = Vector3.new()
    }):Play()
end
local v13 = {}
local u14 = 0
function v13.start(_, p15) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u3
    --]]
    if _G.checkRenderDistance(p15.Position) == false then
        return
    elseif u14 < 25 and _G.FPS > 30 then
        u14 = u14 + 1
        u3.new({
            ["Direction"] = p15.Direction,
            ["Position"] = p15.Position
        })
        task.delay(2, function() --[[ Line: 104 ]]
            --[[
            Upvalues:
                [1] = u14
            --]]
            u14 = u14 - 1
        end)
    end
end
return v13