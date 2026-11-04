 

game:GetService("ReplicatedStorage")
local u1 = script.Aura:GetChildren()
local u2 = script.Emit:GetChildren()
local v3 = {}
local v4 = RaycastParams.new()
v4.FilterType = Enum.RaycastFilterType.Whitelist
v4.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
local function u11(p5) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local u6 = p5.Dagger
    for _, u7 in u2 do
        local v8 = u7:Clone()
        v8.Name = "EMIT"
        v8.Parent = u6
        _G.customEmit(v8)
        task.delay(u7.Lifetime.Max, function() --[[ Line: 21 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            u7:Destroy()
        end)
    end
    task.delay(0.2, function() --[[ Line: 26 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u6
        --]]
        for _, v9 in u1 do
            local v10 = v9:Clone()
            v10.Name = "AURA"
            v10.Parent = u6
            v10.Enabled = true
        end
    end)
end
local function u14(p12) --[[ Line: 39 ]]
    for _, u13 in p12.Dagger:GetDescendants() do
        if u13:IsA("ParticleEmitter") and u13.Name == "AURA" then
            u13.Enabled = false
            task.delay(u13.Lifetime.Max, function() --[[ Line: 49 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13:Destroy()
            end)
        end
    end
end
function v3.start(_, p15, p16) --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u14
    --]]
    if _G.checkRenderDistance(p15.PrimaryPart.Position) == false then
        return
    else
        local _ = p15.HumanoidRootPart
        if p16 then
            u11(p15.IceDagger)
            u11(p15.IceDagger2)
        else
            u14(p15.IceDagger)
            u14(p15.IceDagger2)
        end
    end
end
return v3