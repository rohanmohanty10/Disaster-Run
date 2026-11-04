 

local v1 = {}
require(script.Parent.Lightning)
function v1.start(_, p2, u3, p4, p5, u6, p7, p8, p9, u10) --[[ Line: 4 ]]
    local u11 = _G.awaitObject(p2)
    if u11 == nil then
        return
    elseif _G.checkRenderDistance(u11.Position) ~= false then
        local u12 = nil
        local u13 = script.SurfaceT:Clone()
        if p4 then
            u13 = script.SurfaceT2:Clone()
        end
        if p5 then
            u13.dust.Size = NumberSequence.new(0, p5)
            u13.water.Size = NumberSequence.new(0, p5)
        end
        if p7 then
            u13.dust.Speed = NumberRange.new(p7 / 2, p7)
            u13.water.Speed = NumberRange.new(p7 / 2, p7)
        end
        u13.Parent = workspace.Effects
        local u14 = p8 == nil and 20 or p8
        if p9 then
            u13.dust.Lifetime = NumberRange.new(u13.dust.Lifetime.Min * p9, u13.dust.Lifetime.Max * p9)
            u13.rock.Lifetime = NumberRange.new(u13.rock.Lifetime.Min * p9, u13.rock.Lifetime.Max * p9)
            u13.water.Lifetime = NumberRange.new(u13.water.Lifetime.Min * p9, u13.water.Lifetime.Max * p9)
        end
        if u10 then
            pcall(function() --[[ Line: 35 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u13
                --]]
                for v15 = 1, #u10 do
                    u13[u10[v15]].Transparency = NumberSequence.new(1)
                end
            end)
        end
        local v16 = u11.Size.Y / 2
        local u17 = u11:IsDescendantOf(workspace.Ships) and 0 or v16
        local u18 = tick()
        local u19 = u11.Position
        local _ = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 47 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u18
                [3] = u11
                [4] = u6
                [5] = u12
                [6] = u13
                [7] = u17
                [8] = u14
                [9] = u19
            --]]
            local v20 = u3 and u3 <= tick() - u18 and true or false
            if u11:IsDescendantOf(game) == false or (u11.Anchored == true or v20 == true) and u6 == nil then
                u12:Disconnect()
                u12 = nil
                u13.dust.Enabled = false
                u13.rock.Enabled = false
                u13.water.Enabled = false
                _G.destroy(u13, 2)
            else
                local v21 = u17
                local v22 = CFrame.new(u11.Position + Vector3.new(0, v21, 0))
                local v23 = Ray.new(v22.Position, v22.upVector * -u14)
                local v24, v25, v26 = _G.raycastWhitelist(v23, { workspace.Islands, workspace.Ships, workspace.Env })
                local v27 = u11.Position.Y - workspace.Env.WaterStuff.Ocean.Position.Y
                local v28 = (u11.Position - u19).Magnitude >= 0.1
                if v24 and (v24.CanCollide ~= false and (v28 == true and (v25.Y > workspace.Env.WaterStuff.Falls.Position.Y or workspace.Env.WaterStuff.Sand.Position.Y > v25.Y))) then
                    u13.CFrame = CFrame.new(v25, v25 + v26)
                    u13.dust.Enabled = true
                    u13.rock.Enabled = true
                    u13.dust.Color = ColorSequence.new(v24.Color)
                    u13.rock.Color = ColorSequence.new(v24.Color)
                    u13.water.Enabled = false
                elseif v27 >= 1 and (v27 < 20 and (v28 == true and v25.Y <= workspace.Env.WaterStuff.Falls.Position.Y)) then
                    u13.CFrame = CFrame.new(u11.Position.X, workspace.Env.WaterStuff.Ocean.Position.Y + 0.25, u11.Position.Z)
                    u13.water.Enabled = true
                    u13.dust.Enabled = false
                    u13.rock.Enabled = false
                else
                    u13.dust.Enabled = false
                    u13.rock.Enabled = false
                    u13.water.Enabled = false
                end
                if u11 then
                    u19 = u11.Position
                end
            end
        end)
    end
end
return v1