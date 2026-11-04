 

local u1 = require(game.ReplicatedStorage.Modules.FastSignal)
local v2 = {}
local u3 = RaycastParams.new()
u3.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
u3.FilterType = Enum.RaycastFilterType.Whitelist
function v2.AwaitLanding(_, p4) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    assert(p4, "No Data provided!")
    local v5 = p4.Character
    assert(v5, "No Character provided!")
    local u6 = p4.Duration
    local u7 = p4.checkDelay
    local _ = p4.Type or "Normal"
    local u8 = p4.Character
    local u9 = u8.HumanoidRootPart
    local u10 = tick()
    local u11 = u1.new()
    coroutine.wrap(function() --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u8
            [3] = u9
            [4] = u3
            [5] = u11
            [6] = u10
            [7] = u6
        --]]
        local v12 = nil
        if u7 then
            task.wait(u7)
        end
        local v13, _, _ = _G.getRayFloor(u8.PrimaryPart.CFrame, 10)
        local v14 = nil
        while true do
            if false then
                if not v14 then
                    u11:Fire()
                end
                return
            end
            if not v12 then
                break
            end
            local v15 = u9.CFrame
            local v16 = v15.Position
            v14 = workspace:Raycast(v12.Position, (v16 - v12.Position).Unit * 5, u3)
            if not v14 then
                local v17 = workspace:Raycast(v16, -v15.RightVector * 4, u3)
                local v18 = workspace:Raycast(v16, -v15.RightVector * 4, u3)
                local v19 = workspace:Raycast(v16, v15.LookVector * 4, u3)
                v14 = workspace:Raycast(v16, -v15.LookVector * 5, u3) or (v19 or (v17 or v18))
            end
            if not v14 then
                break
            end
            if not v13 or v14.Instance ~= v13 then
                u11:Fire(v14)
                break
            end
            v14 = nil
            ::l15::
            if u6 <= tick() - u10 then
                break
            end
        end
        v12 = u9.CFrame
        game["Run Service"].Stepped:Wait()
        goto l15
    end)()
    return u11
end
return v2