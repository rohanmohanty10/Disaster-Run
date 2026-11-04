 

local u1 = game:GetService("TweenService")
local u2 = Random.new()
local u3 = RaycastParams.new()
u3.FilterType = Enum.RaycastFilterType.Include
u3.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local u4 = {}
u4.__index = u4
function u4.new(p5) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    local v6 = u4
    local v7 = setmetatable({}, v6)
    v7.Height = p5.Height
    v7.Detection = workspace:Raycast(p5.Position + Vector3.new(0, 1, 0), Vector3.new(-0, -25, -0), u3)
    v7.Duration = p5.Duration
    v7.Size = p5.Size
    if v7.Detection then
        v7.Rock = v7:_createRock()
        v7:_main()
        return v7
    end
end
function u4._createRock(p8) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v9 = script.Rock:Clone()
    v9.Size = p8.Size or u2:NextUnitVector():Abs() * 15
    v9.Material = p8.Detection.Material
    v9.Color = p8.Detection.Instance.Color
    v9.Position = p8.Detection.Position
    v9.Name = "Rock"
    v9.Parent = workspace.Effects
    return v9
end
function u4._main(p10) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v11 = p10.Duration or u2:NextNumber(3, 5)
    local v12 = p10.Height or u2:NextNumber(5, 50)
    u1:Create(p10.Rock, TweenInfo.new(v11, Enum.EasingStyle.Linear), {
        ["CFrame"] = p10.Rock.CFrame * CFrame.Angles(3.141592653589793 * math.random(), 3.141592653589793 * math.random(), 3.141592653589793 * math.random()) + Vector3.new(0, 1, 0) * v12,
        ["Size"] = Vector3.new(0, 0, 0)
    }):Play()
    _G.destroy(p10.Rock, v11)
end
return u4