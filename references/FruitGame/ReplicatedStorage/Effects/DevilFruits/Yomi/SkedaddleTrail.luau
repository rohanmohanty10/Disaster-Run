 

local v1 = {}
function AlignCFrame(p2, p3, _)
    local v4 = p2.Position
    local v5 = p2.LookVector:Cross(p3).Unit
    local v6 = (v5.Magnitude > 0.001 and v5 and v5 or p2.RightVector).Unit
    local v7 = v6:Cross(p3).Unit.Unit
    return CFrame.fromMatrix(v4, v6, p3, v7)
end
function v1.start(_, u8) --[[ Line: 16 ]]
    if _G.checkRenderDistance(u8.Position) ~= false then
        local u9 = nil
        u9 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 21 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u9
            --]]
            if u8 == nil or u8 and u8:IsDescendantOf(game) == false or u8 and u8.Name == "done" then
                u9:Disconnect()
                u9 = nil
                if u8 then
                    _G.particleEnabled(u8, false)
                end
            else
                local v10, v11, v12 = _G.getRayFloor(CFrame.new(u8.Position + Vector3.new(0, 3, 0)), 15)
                if v11.Y <= workspace.Env.WaterStuff.Ocean.Position.Y then
                    local v13 = v11.X
                    local v14 = workspace.Env.WaterStuff.Ocean.Position.Y
                    local v15 = v11.Z
                    v11 = Vector3.new(v13, v14, v15)
                end
                u8.Attachment.WorldCFrame = AlignCFrame(CFrame.new(Vector3.new(), u8.CFrame.LookVector) + v11, v12)
                if v10 then
                    if v11.Y > workspace.Env.WaterStuff.Ocean.Position.Y then
                        u8.Attachment.water.Enabled = false
                        u8.Attachment.Dust.Enabled = true
                        u8.Attachment.Dust2.Enabled = true
                        u8.Attachment.Waves.Enabled = true
                        u8.Attachment.Dust.Color = ColorSequence.new(v10.Color)
                        u8.Attachment.Waves.Color = ColorSequence.new(v10.Color)
                        u8.Attachment.Dust2.Color = ColorSequence.new(v10.Color)
                        u8.YomiRunWaterAddon:Stop()
                        return
                    end
                elseif v11.Y <= workspace.Env.WaterStuff.Ocean.Position.Y then
                    u8.Attachment.Dust.Enabled = false
                    u8.Attachment.Dust2.Enabled = false
                    u8.Attachment.Waves.Enabled = false
                    u8.Attachment.water.Enabled = true
                    if u8.YomiRunWaterAddon.IsPlaying == false then
                        u8.YomiRunWaterAddon:Play()
                        return
                    end
                else
                    u8.YomiRunWaterAddon:Stop()
                    _G.particleEnabled(u8, false)
                end
            end
        end)
    end
end
return v1