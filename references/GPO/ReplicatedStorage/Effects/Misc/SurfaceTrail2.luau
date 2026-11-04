 

local v1 = {}
require(script.Parent.Lightning)
function v1.start(_, p2) --[[ Line: 4 ]]
    local u3 = p2.obj
    local v4 = p2.siz
    local v5 = p2.speed
    local v6 = p2.lifeMulti
    local v7 = p2.checkDistance
    local u8 = p2.disable
    local u9 = p2.ti
    local v10 = p2.p
    local v11 = p2.offset
    local u12 = p2.force
    if _G.checkRenderDistance(u3.Position) ~= false then
        local u13 = nil
        local u14 = script.SurfaceT:Clone()
        if v10 then
            u14 = script.SurfaceT2:Clone()
        end
        if v4 then
            u14.dust.Size = NumberSequence.new(0, v4)
            u14.water.Size = NumberSequence.new(0, v4)
        end
        if v5 then
            u14.dust.Speed = NumberRange.new(v5 / 2, v5)
            u14.water.Speed = NumberRange.new(v5 / 2, v5)
        end
        u14.Parent = workspace.Effects
        local u15 = v7 == nil and 20 or v7
        if v6 then
            u14.dust.Lifetime = NumberRange.new(u14.dust.Lifetime.Min * v6, u14.dust.Lifetime.Max * v6)
            u14.rock.Lifetime = NumberRange.new(u14.rock.Lifetime.Min * v6, u14.rock.Lifetime.Max * v6)
            u14.water.Lifetime = NumberRange.new(u14.water.Lifetime.Min * v6, u14.water.Lifetime.Max * v6)
        end
        if u8 then
            pcall(function() --[[ Line: 50 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u14
                --]]
                for v16 = 1, #u8 do
                    u14[u8[v16]].Transparency = NumberSequence.new(1)
                end
            end)
        end
        local u17 = u3:IsDescendantOf(workspace.Ships) and v11 == nil and 0 or v11
        if u17 == nil then
            u17 = u3.Size.Y / 2
        end
        local u18 = tick()
        local u19 = u3.Position
        local _ = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 67 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u18
                [3] = u3
                [4] = u12
                [5] = u13
                [6] = u14
                [7] = u17
                [8] = u15
                [9] = u19
            --]]
            local v20 = u9 and u9 <= tick() - u18 and true or false
            if u3:IsDescendantOf(game) == false or v20 == true and u12 == nil then
                u13:Disconnect()
                u13 = nil
                u14.dust.Enabled = false
                u14.rock.Enabled = false
                u14.water.Enabled = false
                _G.destroy(u14, 2)
            else
                local v21 = u17
                local v22 = CFrame.new(u3.Position + Vector3.new(0, v21, 0))
                local v23 = Ray.new(v22.Position, v22.upVector * -u15)
                local v24, v25, v26 = _G.raycastWhitelist(v23, { workspace.Islands, workspace.Ships, workspace.Env })
                local v27 = u3.Position.Y - workspace.Env.WaterStuff.Ocean.Position.Y
                local v28 = (u3.Position - u19).Magnitude >= 0.1
                if v24 and (v24.CanCollide ~= false and (v28 == true and (v25.Y > workspace.Env.WaterStuff.Falls.Position.Y or workspace.Env.WaterStuff.Sand.Position.Y > v25.Y))) then
                    u14.CFrame = CFrame.new(v25, v25 + v26)
                    u14.dust.Enabled = true
                    u14.rock.Enabled = true
                    u14.dust.Color = ColorSequence.new(v24.Color)
                    u14.rock.Color = ColorSequence.new(v24.Color)
                    u14.water.Enabled = false
                elseif v27 >= 1 and (v27 < 20 and (v28 == true and v25.Y <= workspace.Env.WaterStuff.Falls.Position.Y)) then
                    u14.CFrame = CFrame.new(u3.Position.X, workspace.Env.WaterStuff.Ocean.Position.Y + 0.25, u3.Position.Z)
                    u14.water.Enabled = true
                    u14.dust.Enabled = false
                    u14.rock.Enabled = false
                else
                    u14.dust.Enabled = false
                    u14.rock.Enabled = false
                    u14.water.Enabled = false
                end
                if u3 then
                    u19 = u3.Position
                end
            end
        end)
    end
end
return v1