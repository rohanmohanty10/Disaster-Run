
local v1 = {}
local function u3(p2) 
    _G.tween(p2, {
        0.25,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.In,
        0,
        false,
        0
    }, {
        ["Size"] = p2.Size * 1.25,
        ["Transparency"] = 1
    })
end
function v1.start(_, p4, p5, p6, p7) 
    
    if _G.checkRenderDistance(p4.Position) ~= false then
        local u8 = script.Ball:Clone()
        local u9 = p4:IsDescendantOf(workspace.NPCs) and 2 or p6
        if u9 then
            u8.Neon.Size = u8.Neon.Size * u9
            u8.Force.Size = u8.Force.Size * u9
        else
            u9 = 1
        end
        local v10 = Instance.new("Weld")
        v10.Part0 = p4
        v10.Part1 = u8.RootPart
        v10.Parent = u8
        u8.Parent = workspace.Effects
        local u11 = u8:GetDescendants()
        local u12 = {}
        for u13 = 1, #u11 do
            if u11[u13]:IsA("Bone") and u11[u13].Name ~= "Root" then
                task.spawn(function() --[[ Line: 34 ]]
                   
                    local v14 = u12
                    local v15 = _G.tween
                    local v16 = u11[u13]
                    local v17 = {
                        math.random(100, 250) / 1000,
                        "EntranceProductive",
                        Enum.EasingDirection.In,
                        -1,
                        true,
                        0
                    }
                    local v18 = {
                        ["Position"] = u11[u13].Position:Lerp(Vector3.new(0, 0, 0), -(math.random(35, 75) / 100)) * u9
                    }
                    table.insert(v14, v15(v16, v17, v18))
                end)
            end
        end
        pcall(function()
            
            local v19 = u12
            local v20 = _G.tween
            local v21 = u8.Neon
            local v22 = {
                0.25,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                -1,
                true,
                0
            }
            local v23 = {
                ["Size"] = u8.Neon.Size * 1.25
            }
            table.insert(v19, v20(v21, v22, v23))
            local v24 = u12
            local v25 = _G.tween
            local v26 = u8.Force
            local v27 = {
                0.25,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                -1,
                true,
                0
            }
            local v28 = {
                ["Size"] = u8.Force.Size * 1.25
            }
            table.insert(v24, v25(v26, v27, v28))
        end)
        u8.Neon.Attachment.ParticleEmitter.Size = NumberSequence.new(10 * u9, 0)
        _G.tween(u8.Neon.Attachment.ParticleEmitter, {
            2,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = NumberSequence.new(3 * u9, 0),
            ["TimeScale"] = 0.25
        })
        if p7 == nil then
            u8.Neon.sfx:Play()
        end
        task.spawn(function()
            
            task.wait(1)
            pcall(function() 
                
                u8.Neon.loop:Play()
            end)
        end)
        _G.PlayEffect("BallTrail", nil, p4, p5, 1.25 * u9, Color3.fromRGB(102, 207, 255), 0.25)
        repeat
            game["Run Service"].Heartbeat:Wait()
        until p5:IsDescendantOf(game) == false or p4:IsDescendantOf(game) == false
        for u29 = 1, #u12 do
            pcall(function() 
                
                u12[u29]:Stop()
                u12[u29]:Destroy()
            end)
        end
        u3(u8.Force)
        u3(u8.Neon)
        _G.destroy(u8, 0.25)
    end
end
return v1