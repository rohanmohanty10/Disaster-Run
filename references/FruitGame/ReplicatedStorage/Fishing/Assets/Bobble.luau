 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local u3 = game:GetService("RunService")
local u4 = workspace.Effects
local u5 = v2.LocalPlayer
local u6 = Random.new()
local u7 = v1.Fishing.Remotes.Action
workspace:WaitForChild("Env")
workspace:WaitForChild("Ships")
workspace:WaitForChild("Islands")
local u8 = RaycastParams.new()
u8.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
u8.FilterType = Enum.RaycastFilterType.Include
local u9 = require(v1.Modules.Shared.Maids.Maid)
require(v1.Modules.Shared.Signals.GoodSignal)
local u10 = {}
u10.__index = u10
function u10.new(p11) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u9
    --]]
    local v12 = u10
    local u13 = setmetatable({}, v12)
    u13.Cleaner = u9.new()
    u13.Landed = false
    u13.Client = p11.Client
    u13.Velocity = p11.Velocity
    u13.Pull = Vector3.new(0, 0, 0)
    u13.Push = Vector3.new(0, 0, 0)
    u13.Model = u13:_getBobble()
    u13.Model.Destroying:Connect(function() --[[ Line: 43 ]]
        --[[
        Upvalues:
            [1] = u13
        --]]
        warn("bobble model desteroyed")
        _G.canuse = true
        u13.Client.IsCharging = false
    end)
    u13:_main()
    return u13
end
function u10._getBobble(p14) --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v15 = u4:WaitForChild((("%*\'s hook"):format(u5)))
    p14.Cleaner:AddTask(v15)
    return v15
end
local u16 = OverlapParams.new()
u16.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u16.FilterType = Enum.RaycastFilterType.Include
function u10._bobbleFall(p17, _) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u5
        [3] = u7
    --]]
    local v18 = workspace.Env.WaterStuff.Falls.Position.Y
    local v19 = p17.Model
    local v20 = workspace:GetPartsInPart(v19, u16)
    if v20 and #v20 > 0 then
        p17.Client:_reelBack()
        return
    elseif v19.Position.Y <= v18 then
        if u5.Character.HumanoidRootPart.Position.Y <= v18 then
            p17.Client:_reelBack()
        else
            p17.Landed = true
            p17.LandedClock = os.clock()
            p17.Client:_play("Idle")
            v19.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            local v21 = Instance.new("BodyPosition")
            v21.MaxForce = Vector3.new(0, 2000000000, 0)
            v21.Position = v19.Position
            v21.Parent = v19
            u7:InvokeServer({
                ["Action"] = "Landed"
            })
        end
    else
        v19.CFrame = CFrame.new(Vector3.new(0, 0, 0), v19.AssemblyLinearVelocity.Unit) * CFrame.Angles(0, 0, 0) + v19.Position
        return
    end
end
function u10._bobbleIdle(p22, _) --[[ Line: 100 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v23 = p22.Model
    local v24 = u5.Character.HumanoidRootPart
    local v25 = (v23.Position - v24.Position).Unit
    local v26 = (os.clock() - p22.LandedClock) * 2
    local v27 = Vector3.new(0, 1, 0) * math.sin(v26) * 0.1
    local v28 = Vector3.new(0, 1, 0) * _G.getWavePosition(v23.Position) + v23.Position * Vector3.new(1, 0, 1) + v27
    v23.CFrame = v23.CFrame:Lerp(CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(0, 1, 0)):Cross(v25)) * CFrame.Angles(-1.5707963267948966, 0, 0) + v28, 0.75)
end
function u10._bobbleStruggle(p29, p30) --[[ Line: 133 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v31 = p29.Model
    if p29.FishCaughtClock then
        local v32 = os.clock() - p29.FishCaughtClock
        local v33 = math.noise(v32 * p29.PathSeed.X)
        local v34 = math.noise
        local v35 = v32 * p29.PathSeed.Z
        local v36 = (Vector3.new(v33, 0, v34(v35)) * 35 + p29.Pull) * p30 + p29.Push
        local v37 = workspace:Raycast(v31.Position, v36 * 5, u8)
        p29.Pull = p29.Pull:Lerp(Vector3.new(0, 0, 0), p30)
        p29.Push = p29.Push:Lerp(Vector3.new(0, 0, 0), p30)
        if v37 then
            p29.Push = (Vector3.new(0, 1, 0)):Cross(CFrame.new(Vector3.new(0, 0, 0), v37.Normal).RightVector) * 0.1
            return
        else
            local v38 = Vector3.new(0, 1, 0) * _G.getWavePosition(v31.Position) + v31.Position * Vector3.new(1, 0, 1) + v36
            local v39 = v36 * Vector3.new(1, 0, 1)
            if v39.Magnitude > 0.001 then
                v31.CFrame = CFrame.lookAt(v38, v38 + v39) * CFrame.Angles(-1.5707963267948966, 0, 0)
            else
                v31.CFrame = v31.CFrame - v31.Position + v38
            end
        end
    else
        return
    end
end
function u10._update(p40, p41) --[[ Line: 157 ]]
    if p40.Client.Debounce then
        if p40.Landed then
            if p40.Client.FishCaught then
                p40:_bobbleStruggle(p41)
            else
                p40:_bobbleIdle(p41)
            end
        else
            p40:_bobbleFall(p41)
            return
        end
    else
        return
    end
end
function u10.CleanConnections(p42) --[[ Line: 171 ]]
    if p42.Cleaner.Update then
        p42.Cleaner.Update:Disconnect()
        p42.Cleaner.Update = nil
    end
    if p42.Cleaner.Caught then
        p42.Cleaner.Caught:Disconnect()
        p42.Cleaner.Caught = nil
    end
end
function u10._main(u43) --[[ Line: 183 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
        [3] = u10
        [4] = u3
    --]]
    u43.Model.AssemblyLinearVelocity = u43.Velocity
    local u44 = u5.Character.HumanoidRootPart
    local u45 = u43.Model
    local u46 = u45.Position
    local function v54(p47) --[[ Line: 198 ]]
        --[[
        Upvalues:
            [1] = u43
            [2] = u5
            [3] = u46
            [4] = u45
            [5] = u44
        --]]
        if u43.Client.Debounce then
            u43:_update(p47)
            if u5.Character.Humanoid.SeatPart == nil then
                u46 = u46:Lerp(u45.Position, p47)
                local v48 = u44
                local v49 = CFrame.new
                local v50 = u44.Position
                local v51 = u46.X
                local v52 = u44.Position.Y
                local v53 = u46.Z
                v48.CFrame = v49(v50, (Vector3.new(v51, v52, v53)))
            end
        end
    end
    local function v56() --[[ Line: 204 ]]
        --[[
        Upvalues:
            [1] = u43
            [2] = u6
            [3] = u10
        --]]
        local v55 = u43.Model:GetAttribute("Caught")
        if v55 then
            u43.FishCaughtClock = os.clock()
            u43.PathSeed = u6:NextUnitVector():Abs()
            u43.BobbleCFrame = u10.CFrame
            u43.Client:_fishCaught()
        else
            u43.Client:_stop("Reel")
        end
        u43.Client.FishCaught = v55
        print("caught")
    end
    u43.Cleaner.Update = u3.Heartbeat:Connect(v54)
    u43.Cleaner.Caught = u43.Model:GetAttributeChangedSignal("Caught"):Connect(v56)
end
function u10.Destroy(p57) --[[ Line: 227 ]]
    p57.Cleaner:Destroy()
    p57.Client.FishCaught = nil
    warn("bobble destroyed!")
    setmetatable(p57, nil)
end
return u10