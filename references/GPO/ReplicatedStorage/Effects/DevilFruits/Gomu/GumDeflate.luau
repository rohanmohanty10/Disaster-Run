 

local v1 = {}
local u2 = require(game:GetService("ReplicatedStorage").Modules.sBeat)
function v1.start(_, u3, u4, u5, p6) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u3.HumanoidRootPart.Position) == false then
        return
    elseif u5 then
        local u7 = u3.LowerTorso
        local u8 = u3.Head
        local u9 = p6.root:WaitForChild("Attachment", 3).ParticleEmitter
        local u10 = p6.root.Fast.Waves
        _G.PlaySound(u5, script.Deflate)
        task.spawn(function() --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u4
                [3] = u5
                [4] = u8
                [5] = u3
                [6] = u9
                [7] = u10
                [8] = u2
            --]]
            local v11 = u7.CFrame.rightVector * (1.5 / u4)
            local _ = u5.Size
            local v12 = 60 * u4
            for _ = 1, math.floor(v12) do
                local _ = (u7.Position - u8.Position).Magnitude
                if u3 == game.Players.LocalPlayer.Character then
                    u7.AssemblyAngularVelocity = u7.AssemblyAngularVelocity + v11
                    if u7.Velocity.Magnitude > 50 then
                        u7.Velocity = u7.Velocity.unit * 50
                    end
                end
                u9:Emit(3)
                if u7.AssemblyAngularVelocity.Magnitude > 40 then
                    u10:Emit(1)
                end
                u2()
            end
            u5:Destroy()
        end)
    end
end
return v1