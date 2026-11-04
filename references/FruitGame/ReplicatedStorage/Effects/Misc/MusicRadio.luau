 

local v1 = {}
require(script.Parent.Lightning)
function v1.start(_, u2, u3) --[[ Line: 8 ]]
    local u4 = nil
    local u5 = nil
    u5 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 11 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u4
            [4] = u5
        --]]
        if u2 and u2.Parent ~= nil then
            local v6 = u2.PlaybackLoudness / 100
            if u2.IsPlaying == true then
                local v7 = v6 / 50
                local v8 = u3.Parent.Bone.LeftBlast
                local v9 = u3.Parent.Bone.LeftBlast.Position
                local v10 = -0.161 - v7
                local v11 = u3.Parent.Bone.LeftBlast.Position.Y
                local v12 = u3.Parent.Bone.LeftBlast.Position.Z
                v8.Position = v9:Lerp(Vector3.new(v10, v11, v12), 0.2)
                local v13 = u3.Parent.BoneR.RightBlast
                local v14 = u3.Parent.BoneR.RightBlast.Position
                local v15 = -0.161 - v7
                local v16 = u3.Parent.BoneR.RightBlast.Position.Y
                local v17 = u3.Parent.BoneR.RightBlast.Position.Z
                v13.Position = v14:Lerp(Vector3.new(v15, v16, v17), 0.2)
                local v18 = u3:GetChildren()
                for v19 = 1, #v18 do
                    if v18[v19]:IsA("ParticleEmitter") then
                        if u4 == nil then
                            u4 = v6 / 7
                        end
                        local v20 = u4
                        local v21 = v20 + (v6 / 8 - v20) * 0.2
                        local v22 = math.clamp(v21, 0, 20)
                        v18[v19].Rate = 1 + v6 * 1
                        v18[v19].Drag = 2 - v6
                        v18[v19].RotSpeed = NumberRange.new(-v6 * 10, v6 * 10)
                        v18[v19].Speed = NumberRange.new(v6)
                        v18[v19].Size = NumberSequence.new(v22)
                        u4 = v22
                    end
                end
                return
            end
        else
            u5:Disconnect()
            u5 = nil
        end
    end)
end
return v1