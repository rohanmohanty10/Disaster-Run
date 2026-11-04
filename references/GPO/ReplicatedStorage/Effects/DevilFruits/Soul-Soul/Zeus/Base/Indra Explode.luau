 

local u1 = game:GetService("TweenService")
game:GetService("Debris")
Random.new()
require(script.Parent.Shared)
local _ = script.VFX
local v2 = RaycastParams.new()
v2.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
v2.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 14 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v4 = p3.Orb1
        local v5 = p3.Orb2
        local v6 = p3.Beam
        local v7 = p3.Hit
        local v8 = p3.Duration
        local v9 = CFrame.new(v4.Position, v5.Position)
        local v10 = v9:ToObjectSpace(CFrame.new(v7))
        local v11 = v9 * CFrame.new(0, 0, v10.Z)
        local v12 = TweenInfo.new(v8, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        u1:Create(v4, v12, {
            ["CFrame"] = v11
        }):Play()
        u1:Create(v5, v12, {
            ["CFrame"] = v11
        }):Play()
        local v13 = os.clock()
        local v14 = script.VFX.Appear_Emit:Clone()
        v14.CFrame = CFrame.new(v7)
        v14.Parent = workspace.Effects
        _G.customEmit(v14)
        _G.destroy(v14, 5)
        _G.PlaySound(v14, script.SoulZeusMiniCloudTriggerTrap, {
            ["RandomPitch"] = true
        })
        local v15 = v5.Position - v4.Position
        local v16 = v15.Z
        local v17 = -v15.X
        local v18 = Vector3.new(v16, 0, v17).Unit
        local u19 = v4.Position + v15 * 0.5 + (v18 * 0 + Vector3.new(0, 0, 0))
        local function v23(p20) --[[ Line: 68 ]]
            local v21 = p20:GetDescendants()
            for v22 = 1, #v21 do
                if v21[v22]:IsA("ParticleEmitter") then
                    v21[v22].LockedToPart = true
                end
            end
        end
        v23(v4)
        v23(v5)
        local function v26(p24) --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u19
            --]]
            _G.PlayEffect("DeadLightning", nil, {
                ["StartPosition"] = p24,
                ["EndPosition"] = u19,
                ["Points"] = 3,
                ["Size"] = 4,
                ["Branches"] = true,
                ["RandomSize"] = NumberRange.new(0.5, 1),
                ["Offset"] = NumberRange.new(0),
                ["MainColor"] = Color3.fromRGB(255, 255, 255),
                ["GlowColor"] = Color3.fromRGB(151, 65, 255),
                ["LightningDuration"] = math.random(100, 200) / 2000,
                ["WaitFunction"] = function(p25, _) --[[ Name: WaitFunction, Line 60 ]]
                    if p25 % 2 == 0 then
                        task.wait(math.random(100, 300) / 10000)
                    end
                end
            })
        end
        local function v30(p27) --[[ Line: 77 ]]
            local v28 = p27:GetDescendants()
            for v29 = 1, #v28 do
                if v28[v29]:IsA("ParticleEmitter") then
                    v28[v29]:Clear()
                end
            end
        end
        for _ = 1, 2 do
            v26(v4.Position)
            v26(v5.Position)
            task.wait(0.05)
        end
        while os.clock() - v13 <= v8 and v6.Parent do
            local v31 = v5.Position - v4.Position
            v6.CFrame = CFrame.new(v4.Position, v5.Position) + v31 / 2
            local v32 = v31.Magnitude
            v6.Size = Vector3.new(15, 15, v32)
            v6.B.Position = Vector3.new(0, 0, 1) * v31.Magnitude / 2
            v6.F.Position = -v6.B.Position
            task.wait()
        end
        v30(v4)
        v30(v5)
        _G.PlayEffect("SoulCurrentExplode", nil, v7)
    end
}