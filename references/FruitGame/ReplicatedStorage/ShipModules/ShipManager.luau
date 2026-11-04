 

local u1 = {}
u1.__index = u1
function u1.SetUp(p2) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u3 = {}
    local v4 = require(p2.Parent.Info.Settings):Get()
    local v5 = p2.Occupant
    if v5 ~= nil then
        u3.orgInfo = v4
        u3.MaxSpeed = p2.MaxSpeed
        u3.Speed = 0
        u3.TiltAngle = v4.TiltAngle
        u3.RotateAngle = v4.Rotate
        u3.WheelAngle = 1
        u3.Driver = v5.Parent
        u3.Accel = v4.Accl
        u3.Brake = v4.Brake
        u3.MainPart = p2.Parent.m
        u3.Seat = p2
        u3.GroundDeep = v4.Deep
        u3.preFlag = 0
        if p2.Parent:FindFirstChild("Wheel") then
            u3.wheel = p2.Parent.Wheel.Model.TriColor.Wheel
        end
        local v6 = p2.Parent:GetChildren()
        local v7 = {}
        for v8 = 1, #v6 do
            if v6[v8].Name == "Sail" then
                local v9 = v6[v8]
                table.insert(v7, v9)
            end
        end
        u3.Sails = v7
        u3.ShipType = v4.Type
        local v10 = u1
        setmetatable(u3, v10)
        local v11 = v4.ShipWheel
        if v11 and script.ShipAnimations:FindFirstChild(v11) then
            local v12 = script.ShipAnimations:FindFirstChild(v11):FindFirstChild("Idle")
            local v13 = script.ShipAnimations:FindFirstChild(v11):FindFirstChild("Right")
            local v14 = script.ShipAnimations:FindFirstChild(v11):FindFirstChild("Left")
            local v15 = script.ShipAnimations:FindFirstChild(v11):FindFirstChild("Back")
            local v16 = script.ShipAnimations:FindFirstChild(v11):FindFirstChild("Foward")
            local v17
            if v12 then
                v17 = v5:LoadAnimation(v12)
            else
                v17 = nil
            end
            local v18
            if v13 then
                v18 = v5:LoadAnimation(v13)
            else
                v18 = nil
            end
            local v19
            if v14 then
                v19 = v5:LoadAnimation(v14)
            else
                v19 = nil
            end
            local v20
            if v15 then
                v20 = v5:LoadAnimation(v15)
            else
                v20 = nil
            end
            local v21
            if v16 then
                v21 = v5:LoadAnimation(v16)
            else
                v21 = nil
            end
            u3.Anims = {
                ["idle"] = v17,
                ["right"] = v18,
                ["left"] = v19,
                ["back"] = v20,
                ["front"] = v21
            }
            u3.Anims.idle:Play()
            u3.Anims.idle:AdjustWeight(2)
            for _, v22 in u3.Anims do
                if v22 ~= u3.Anims.idle then
                    v22:AdjustWeight(4)
                end
            end
        end
        if script.ShipSpecs:FindFirstChild(v4.Type) then
            local v23 = require(script.ShipSpecs[v4.Type])
            if v23.Foward ~= nil and game["Run Service"]:IsClient() == true then
                u3.customControls = v23:int(v5.Parent, p2.Parent)
            end
        end
        u3.LastGround = nil
        function u3.PlayAnimation(p24) --[[ Line: 88 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            if u3.Anims ~= nil then
                for _, v25 in u3.Anims do
                    if v25 ~= u3.Anims.idle then
                        if v25 == p24 or v25.IsPlaying ~= true then
                            if v25 == p24 and v25.IsPlaying == false then
                                v25:Play()
                            end
                        else
                            v25:Stop()
                        end
                    end
                end
            end
        end
        return u3
    end
end
local function u30(p26, p27) --[[ Line: 106 ]]
    local v28 = p26:GetChildren()
    for v29 = 1, #v28 do
        if v28[v29]:IsA("Decal") then
            v28[v29].Transparency = p27
        end
    end
end
function u1.Flags(p31, p32) --[[ Line: 114 ]]
    --[[
    Upvalues:
        [1] = u30
    --]]
    local v33 = p31.Seat
    if v33.Parent:FindFirstChild("Sail") ~= nil and (tick() - p31.preFlag >= 0.15 and v33.Parent.Sail.Transparency ~= p32) then
        local v34 = p31.Sails
        for v35 = 1, #v34 do
            if v34[v35].Name == "Sail" then
                v34[v35].Transparency = p32
                if v34[v35]:FindFirstChild("Flag") and p32 == 0 then
                    v34[v35].Flag:Play()
                elseif v34[v35]:FindFirstChild("Flag") then
                    v34[v35].Flag:Stop()
                end
                u30(v34[v35], p32)
            end
        end
        p31.preFlag = tick()
        game.ReplicatedStorage.Events.ShipEvents.Flag:FireServer(v33.Parent, p32)
    end
end
function u1.ApplySpeed(p36) --[[ Line: 137 ]]
    if p36.done == nil then
        local v37 = p36.Seat
        local v38 = v37.Parent
        if p36.Speed >= p36.MaxSpeed then
            p36.Speed = p36.MaxSpeed
        end
        local v39 = Ray.new
        local v40 = v38.Bottom.Position
        local v41 = -p36.GroundDeep
        local v42 = v39(v40, (Vector3.new(0, v41, 0)))
        local v43, _ = _G.raycastIgnoreList(v42, {
            workspace.Ragdolls,
            p36.Seat.Parent,
            workspace.Effects,
            workspace.Projectiles,
            workspace.PlayerCharacters,
            workspace.CurrentCamera,
            workspace.Env,
            workspace.NPCs
        })
        if v43 and v37.Occupant then
            if p36.Speed > 0 and v37.Throttle == 1 then
                p36.Speed = 4
            elseif p36.Speed < 0 then
                p36.Speed = 0
            elseif p36.Speed == 0 then
                p36.Speed = 0
            end
            v38.Bottom.ParticleEmitter.Color = ColorSequence.new(v43.Color)
            v38.Bottom.ParticleEmitter.Enabled = true
            if v38.Bottom.SandSFX.IsPlaying == false then
                v38.Bottom.SandSFX:Play()
            end
            game.ReplicatedStorage.Events.ShipEvents.Rough:FireServer(v38, true, v38.Bottom.Position)
        elseif v43 == nil and v38.Bottom.SandSFX.IsPlaying == true then
            v38.Bottom.SandSFX:Stop()
            v38.Bottom.ParticleEmitter.Enabled = false
            game.ReplicatedStorage.Events.ShipEvents.Rough:FireServer(v38, false, v38.Bottom.Position)
        end
        local v44 = v38.shipHP.Value / v38.shipHP.MaxValue
        local v45 = v44 >= 1 and 1 or v44
        if _G.currentisland and _G.currentisland == "Rough Waters" then
            v45 = v45 * 0.6
        end
        p36.MainPart.BodyVelocity.Velocity = v37.CFrame.lookVector * (p36.Speed * v45)
    end
end
function u1.Foward(p46) --[[ Line: 177 ]]
    if p46.done ~= nil then
        return
    end
    local v47 = p46.Seat
    local v48 = v47.Parent.MainPart.Value.WaterSFX
    p46.Speed = p46.Speed + _G.ScaleWithFPS(p46.Accel)
    local v49 = p46.orgInfo
    local v50 = require(v47.Parent.Info.Settings):Get()
    local v51
    if #v49 == #v50 then
        for v52 = 1, #v49 do
            if v49[v52] ~= v50[v52] then
                v51 = false
                goto l5
            end
        end
        v51 = true
        goto l5
    else
        v51 = false
        ::l5::
        if v51 == false then
            v47.Parent:Destroy()
        end
        if p46.Anims and p46.Anims.front ~= nil then
            p46.PlayAnimation(p46.Anims.front)
            p46.Anims.front:AdjustSpeed(1 + p46.Speed / p46.MaxSpeed)
        end
        p46:Flags(0)
        p46:ApplySpeed()
        if p46.customControls ~= nil and p46.customControls.Foward then
            p46.customControls:Foward(v47.Parent)
        end
        if p46.ShipType == "Hoverboard" then
            local v53 = CFrame.new(v47.Position)
            local v54 = Ray.new(v53.Position, v53.UpVector * -5)
            local _, v55 = _G.raycastWhitelist(v54, { workspace.Islands, workspace.Env })
            if v55.Y > workspace.Env.WaterStuff.Falls.Position.Y and v48.IsPlaying == true then
                game.ReplicatedStorage.Events.ShipEvents.sfx:FireServer(p46.Seat.Parent, v48, false)
                v48:Stop()
                return
            end
            if v48.IsPlaying == false then
                game.ReplicatedStorage.Events.ShipEvents.sfx:FireServer(p46.Seat.Parent, v48, true)
                v48:Play()
                return
            end
        elseif p46.ShipType ~= "Hoverboard" and v48.IsPlaying == false then
            game.ReplicatedStorage.Events.ShipEvents.sfx:FireServer(p46.Seat.Parent, v48, true)
            v48:Play()
        end
        return
    end
end
function u1.Backward(p56) --[[ Line: 215 ]]
    if p56.done == nil then
        local v57 = p56.Seat
        local v58 = v57.Parent.MainPart.Value.WaterSFX
        p56.Speed = p56.Speed - _G.ScaleWithFPS(p56.Brake)
        if p56.Speed <= -p56.MaxSpeed / 2 then
            p56.Speed = -p56.MaxSpeed / 2
        end
        if v58.IsPlaying == true then
            game.ReplicatedStorage.Events.ShipEvents.sfx:FireServer(p56.Seat.Parent, v58, false)
            v58:Stop()
        end
        if p56.Anims and p56.Anims.back ~= nil then
            p56.PlayAnimation(p56.Anims.back)
        end
        p56:Flags(1)
        p56:ApplySpeed()
        if p56.customControls ~= nil and p56.customControls.Backward then
            p56.customControls:Backward(v57.Parent)
        end
    end
end
function u1.Idle(p59) --[[ Line: 240 ]]
    if p59.done == nil then
        local v60 = p59.Speed
        local v61 = p59.Seat
        local v62 = v61.Parent.MainPart.Value.WaterSFX
        local _ = v61.Parent.MainPart.Value.sway
        if v60 > 0 then
            p59.Speed = p59.Speed - _G.ScaleWithFPS(p59.Brake / 2)
            if p59.Speed <= 0 then
                p59.Speed = 0
            end
        elseif v60 < 0 then
            p59.Speed = p59.Speed + _G.ScaleWithFPS(p59.Brake / 2)
            if p59.Speed >= 0 then
                p59.Speed = 0
            end
        end
        if v61.Steer == 0 and (p59.Anims and p59.Anims.idle ~= nil) then
            p59.PlayAnimation(p59.Anims.idle)
        end
        if v62.IsPlaying == true then
            game.ReplicatedStorage.Events.ShipEvents.sfx:FireServer(p59.Seat.Parent, v62, false)
            v62:Stop()
        end
        p59:Flags(1)
        p59:ApplySpeed()
        if p59.customControls ~= nil and p59.customControls.Idle then
            p59.customControls:Idle(v61.Parent)
        end
    end
end
function u1.RightTurn(p63) --[[ Line: 278 ]]
    if p63.done == nil then
        local _ = p63.Seat
        local v64 = p63.MainPart.tilt
        local v65 = p63.TiltAngle
        local _ = p63.MainPart.BodyGyro
        local v66 = p63.wheel
        v64.DesiredAngle = v65
        if p63.Anims and p63.Anims.right ~= nil then
            if p63.Anims.right.IsPlaying == false then
                p63.PlayAnimation(p63.Anims.right)
            end
            if v66 then
                v66.DesiredAngle = -p63.WheelAngle
                if v66.CurrentAngle <= -p63.WheelAngle then
                    p63.Anims.right:AdjustSpeed(0)
                    return
                end
                p63.Anims.right:AdjustSpeed(1)
            end
        end
    end
end
function u1.LeftTurn(p67) --[[ Line: 306 ]]
    if p67.done == nil then
        local _ = p67.Seat
        local v68 = p67.MainPart.tilt
        local v69 = p67.TiltAngle
        local _ = p67.MainPart.BodyGyro
        local v70 = p67.wheel
        v68.DesiredAngle = -v69
        if p67.Anims and p67.Anims.left ~= nil then
            if p67.Anims.left.IsPlaying == false then
                p67.PlayAnimation(p67.Anims.left)
            end
            if v70 then
                v70.DesiredAngle = p67.WheelAngle
                if v70.CurrentAngle >= p67.WheelAngle then
                    p67.Anims.left:AdjustSpeed(0)
                    return
                end
                p67.Anims.left:AdjustSpeed(1)
            end
        end
    end
end
function u1.NormalWheel(p71) --[[ Line: 333 ]]
    if p71.done == nil then
        local _ = p71.Seat
        local v72 = p71.MainPart.tilt
        local _ = p71.TiltAngle
        local _ = p71.MainPart.BodyGyro
        local v73 = p71.wheel
        v72.DesiredAngle = 0
        if v73 then
            if v73.Part0 ~= nil and (p71.Anims and p71.Anims.idle ~= nil) then
                p71.PlayAnimation(p71.Anims.idle)
            end
            v73.DesiredAngle = 0
        end
    end
end
function u1.looped(p74) --[[ Line: 352 ]]
    if p74.customControls ~= nil and p74.customControls.looped ~= nil then
        p74.customControls:looped(p74.Seat.Parent)
    end
end
function u1.End(p75) --[[ Line: 360 ]]
    if p75.Anims ~= nil then
        for _, v76 in p75.Anims do
            v76:Stop()
            v76:Destroy()
        end
        p75.done = true
        if p75.MainPart and p75.MainPart:FindFirstChild("BodyVelocity") then
            p75.MainPart.BodyVelocity.Velocity = Vector3.new()
        end
        p75.Speed = 0
        pcall(function() --[[ Line: 372 ]] end)
        local v77 = p75.Seat.Parent.MainPart.Value.WaterSFX
        game.ReplicatedStorage.Events.ShipEvents.sfx:FireServer(p75.Seat.Parent, v77, false)
        v77:Stop()
        p75:Flags(1)
        p75.Anims = nil
    end
    if p75.specs then
        p75.specs:End()
    end
    if p75.customControls then
        p75.customControls:End()
        local v78 = p75.customControls
        setmetatable(v78, nil)
        p75.customControls = nil
    end
    setmetatable(p75, nil)
end
return u1