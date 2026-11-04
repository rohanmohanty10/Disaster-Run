 

local u1, u2, u3, _, u4 = require(game.ReplicatedStorage.Modules.ScriptSet).get()
_G.blocking = false
_G.swordEquiped = false
require(game.ReplicatedStorage.Modules.RotatedRegion3)
require(game.ReplicatedStorage.Util.Movement.GpoClimbing)
require(game.ReplicatedStorage.Modules.CameraShaker)
require(game.ReplicatedStorage.Util.Movement.DashTypes)
local u5 = workspace:WaitForChild("Ragdolls", 5)
local v6 = u2.Humanoid:WaitForChild("Animator")
u2.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
u2.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
game.Workspace.CurrentCamera.FieldOfView = 70
game.Workspace.CurrentCamera.CameraType = "Custom"
v6:LoadAnimation(game.ReplicatedStorage.Util.Movement.Sit).Priority = Enum.AnimationPriority.Action4
v6:LoadAnimation(script.run)
_G.running = false
local v7 = script.EvasiveIndicator:Clone()
v7.ImageLabel.ImageTransparency = 1
v7.Parent = u2.PrimaryPart
_G.orgRun = script.run.AnimationId
_G.instantDash = true
local u8 = false
local u9 = 0
repeat
    task.wait()
until _G.clientimpacts ~= nil
require(game.ReplicatedStorage.Modules.Skills)
_G.geppo = 1
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Soru]
require(game.ReplicatedStorage.Modules.FastWait)
local u10 = require(u1.Backpack:WaitForChild("InputCallbacks"))
local v11 = u1:WaitForChild("PlayerScripts")
require(v11:WaitForChild("InputHandler"))
u3.InputBegan:Connect(function(p12, p13) --[[ Line: 110 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u8
        [3] = u10
        [4] = u1
        [5] = u2
    --]]
    if p13 and (p12.KeyCode ~= Enum.KeyCode.B and (p12.KeyCode ~= Enum.KeyCode.Backspace and (p12.KeyCode ~= Enum.KeyCode.Space and (p12.KeyCode ~= Enum.KeyCode.W and (p12.KeyCode ~= Enum.KeyCode.V and (p12.KeyCode ~= Enum.KeyCode.P and p12.KeyCode ~= Enum.KeyCode.LeftControl)))))) then
        return
    elseif not p13 then
        if p12.KeyCode == Enum.KeyCode.W and u4.Settings.AutoRun.Value == false then
            if u8 == false then
                u8 = true
            else
                u8 = "run"
            end
            if u8 == "run" then
                u10.Callbacks.Run.HoldingRun = true
                u10.Callbacks.Run:PC_Activate()
                u8 = false
                return
            end
            task.wait(0.2)
            if u8 == true then
                u8 = false
                return
            end
        else
            if p12.KeyCode == Enum.KeyCode.LeftControl then
                u10.Callbacks.Evasive:PC_Activate()
                u10.Callbacks.Climb:PC_Activate()
                return
            end
            if p12.KeyCode == Enum.KeyCode.Q then
                u10.Callbacks.Dash:PC_Activate()
                return
            end
            if p12.KeyCode == Enum.KeyCode.H and (u1.Name == "Phoeating" and _G.check:inspect(u2) == true) then
                game.ReplicatedStorage.Events.Haki:FireServer("Haoshoku3")
                return
            end
            if p12.KeyCode == Enum.KeyCode.V then
                u10.Callbacks.Carry:PC_Activate()
                return
            end
            if p12.KeyCode == Enum.KeyCode.B then
                u10.Callbacks.Grip:PC_Activate()
                return
            end
            if p12.KeyCode == Enum.KeyCode.Space then
                u10.Callbacks.Geppo:PC_Activate()
                return
            end
            if p12.KeyCode == Enum.KeyCode.P then
                u10.Callbacks.ShipSeat:PC_Activate()
                return
            end
            if p12.KeyCode == Enum.KeyCode.Backspace then
                u10.Callbacks.DropTool:PC_Activate()
            end
        end
    end
end)
u3.InputEnded:Connect(function(p14, _) --[[ Line: 154 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u10
    --]]
    if p14.KeyCode == Enum.KeyCode.W and u4.Settings.AutoRun.Value == false then
        u10.Callbacks.Run.HoldingRun = false
    end
end)
u2.Humanoid.HealthChanged:Connect(function(p15) --[[ Line: 161 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p15 <= 0 and u2:FindFirstChild("Rag") == nil then
        workspace.CurrentCamera.CameraType = Enum.CameraType.Track
    end
end)
local v17, v18 = pcall(function() --[[ Line: 167 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v16 = Instance.new("BindableEvent", game.ReplicatedStorage)
    v16.Name = "resetBindable"
    v16.Event:Connect(function() --[[ Line: 170 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if game.ReplicatedStorage.reservedCode.Value == "arena" and game.ReplicatedStorage.Matchinfo.matchStarted.Value == false then
            return
        elseif game.ReplicatedStorage.reservedCode:GetAttribute("battleRoyale") then
            _G.displayMessage("<Color=Red>Cannot reset in battle royale!")
            return
        elseif _G.isCustomHUB == true then
            return
        elseif (_G.canuse == false or _G.check:inspect(u2) == false) and (game.ReplicatedStorage:FindFirstChild("RAIDMODE") == nil and u2.Parent == workspace.PlayerCharacters) then
            _G.displayMessage("<Color=Red>Cannot reset while stunned, or casting a skill!")
            return
        elseif game.ReplicatedStorage.reservedCode.Value == "arena" and (game.ReplicatedStorage:FindFirstChild("RAIDMODE") == nil and u2.Parent ~= workspace.Ragdolls) then
            _G.displayMessage("<Color=Red>Cannot reset unless you are knocked out!")
        else
            game.ReplicatedStorage.Events.KnockedOut:FireServer("self")
        end
    end)
    game:GetService("StarterGui"):SetCore("ResetButtonCallback", v16)
end)
if not v17 then
    warn("ERROR: " .. v18)
end
local u19 = false
local v20 = require(game.ReplicatedStorage.Modules.BindToRender)
local u21 = u2.Humanoid
u21.Seated:Connect(function() --[[ Line: 207 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.canuse == false and (u2.Humanoid.SeatPart and (u2:FindFirstChild("KarooRace") == nil and u2.Humanoid.SeatPart ~= nil)) then
        u2.Humanoid.Sit = true
        warn("unsit")
        u2.Humanoid.SeatPart:Sit(nil)
        task.delay(0.2, function() --[[ Line: 213 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            u2.Humanoid.Sit = false
        end)
    end
end)
u21:GetPropertyChangedSignal("HipHeight"):Connect(function() --[[ Name: fixHipHeight, Line 229 ]]
    --[[
    Upvalues:
        [1] = u21
        [2] = u2
    --]]
    if u21.HipHeight <= 0.1 then
        local v22 = u2
        local v23 = v22.HumanoidRootPart.Position.Y - 0.5 * v22.HumanoidRootPart.Size.Y - (v22.LeftFoot.Position.Y - 0.5 * v22.LeftFoot.Size.Y)
        v22:FindFirstChildOfClass("Humanoid").HipHeight = v23
    end
end)
if u21.HipHeight <= 0.1 then
    local v24 = u2.HumanoidRootPart.Position.Y - 0.5 * u2.HumanoidRootPart.Size.Y - (u2.LeftFoot.Position.Y - 0.5 * u2.LeftFoot.Size.Y)
    u2:FindFirstChildOfClass("Humanoid").HipHeight = v24
end
local u25 = nil
local u26 = 0
_G.grounded = false
local u27 = nil
game:GetService("ContextActionService")
local u28 = false
u2.PrimaryPart.ChildAdded:Connect(function(p29) --[[ Line: 250 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v30 = p29.Name ~= "knockback" and (p29:IsA("BodyVelocity") and u2.HumanoidRootPart:FindFirstChild("ComboBP"))
    if v30 then
        v30:Destroy()
    end
end)
local v31 = game:GetService("ProximityPromptService")
local v32 = game.Teams:FindFirstChild("Eliminated")
local _ = v31.Enabled == false
local _ = v32 and u1.Team == v32
local u33 = false
_G.allowJumpWhileStunned = nil
local function v46(_) --[[ Line: 271 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u26
        [3] = u27
        [4] = u1
        [5] = u19
        [6] = u28
        [7] = u5
        [8] = u33
        [9] = u9
        [10] = u25
        [11] = u4
        [12] = u3
        [13] = u10
    --]]
    local v34 = u2:FindFirstChild("Dizzed")
    local v35 = u2:FindFirstChild("Stun")
    local v36 = u2:FindFirstChild("frozen")
    if v35 == nil then
        v35 = u2:FindFirstChild("PB")
    end
    if u2.PrimaryPart ~= nil and u2.Parent ~= workspace.Effects then
        if tick() - u26 >= 0.1 then
            u26 = tick()
            if u2:GetAttribute("Grounded") then
                if _G.grounded == false then
                    script.GroundedHit:Play()
                    _G.displayMessage("<Color=Orange>You have been grounded, dashes and mobility moves are restricted.")
                    u27 = script.GroundedUI:Clone()
                    u27.ImageLabel.ImageTransparency = 1
                    u27.Parent = u1.PlayerGui
                    _G.tween(u27.ImageLabel, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                        ["ImageTransparency"] = script.GroundedUI.ImageLabel.ImageTransparency
                    })
                end
                _G.grounded = true
            else
                if u27 then
                    _G.tween(u27.ImageLabel, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                        ["ImageTransparency"] = 1
                    })
                    _G.destroy(u27, 0.25)
                    u27 = nil
                    script.UnGroundedHit:Play()
                end
                _G.grounded = false
            end
        end
        if (v34 or (v35 or v36)) and u2:GetAttribute("evading") == nil then
            u2.Humanoid.WalkSpeed = 0
            u2.Humanoid.JumpPower = 0
            if u2.Humanoid.SeatPart ~= nil and u2:FindFirstChild("KarooRace") == nil then
                u2.Humanoid.Sit = true
                u2.Humanoid.SeatPart:Sit(nil)
                task.delay(0.2, function() --[[ Line: 314 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                    --]]
                    u2.Humanoid.Sit = false
                end)
            end
            u2.Humanoid:MoveTo(u2.PrimaryPart.Position)
            u2.Humanoid.Jump = false
            u19 = true
        elseif v34 == nil and (u19 == true and (v35 == nil and v36 == nil)) then
            u2.Humanoid.WalkSpeed = 16
            u2.Humanoid.JumpPower = 50
            u19 = false
            u28 = false
        end
        if u2:FindFirstChild("Rag") then
            u2.Humanoid.AutoRotate = false
        end
        if u2.Parent == u5 and u2.Humanoid.SeatPart ~= nil then
            local v37 = u2.Humanoid.SeatPart:FindFirstChild("SeatWeld")
            if v37 then
                v37:Destroy()
            end
            if u2.Humanoid:GetState() ~= Enum.HumanoidStateType.Physics then
                u2.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            end
        end
        if u2:FindFirstChild("Cuffed") then
            local v38 = u2:GetChildren()
            for v39 = 1, #v38 do
                if v38[v39]:IsA("Tool") then
                    v38[v39].Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
        local v40 = u2.Humanoid
        if u33 == true and tick() - u9 >= 1 or _G.allowJumpWhileStunned == true then
            u33 = false
            u2.Humanoid.JumpPower = 50
        end
        if _G.allowJumpWhileStunned == nil then
            if tick() - u9 < 1 then
                u2.Humanoid.Jump = false
                u2.Humanoid.JumpPower = 0
                u33 = true
            elseif u2.Humanoid.Jump == true or v40:GetState() == Enum.HumanoidStateType.Jumping then
                u9 = tick()
            end
        end
        if u2.PrimaryPart.Anchored == true then
            u2.PrimaryPart.Velocity = Vector3.new()
        end
        local v41 = u2.PrimaryPart.Velocity.Magnitude
        local v42 = u2.HumanoidRootPart:findFirstChild("knockback")
        if (v41 >= 75 or v42 and v42.Velocity.magnitude >= 25) and (u2:GetAttribute("bypassSpeedLines") == nil and (u2.Humanoid.SeatPart == nil and (u2.PrimaryPart.Anchored == false and u2.Parent == workspace.PlayerCharacters))) then
            if u25 == nil then
                u25 = script.fallingParticle:Clone()
                local v43 = Instance.new("Weld")
                v43.Part0 = u2.LowerTorso
                v43.Part1 = u25
                v43.Parent = u25
                u25.Parent = workspace.Effects
            else
                local v44 = u25.Lines
                local v45 = 15 + u2.PrimaryPart.Velocity.Magnitude
                v44.Rate = math.clamp(v45, 15, 50)
                u25.Lines.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(0.2, 1 + v41 / 100, 0), NumberSequenceKeypoint.new(1, 0, 0) })
                u25.Lines2.Size = u25.Lines.Size
                u25.Lines2.Rate = u25.Lines.Rate
                script.fallingLoop.Pitch = v41 / 40
            end
        elseif u25 then
            u25.Lines.Enabled = false
            u25.Lines2.Enabled = false
            _G.destroy(u25, 3)
            u25 = nil
        end
        _G.inCombat = u2:FindFirstChild("inCombat") ~= nil
        if u4 and u4.Settings.AutoRun.Value == true then
            if _G.mobile == false and u3:IsKeyDown(Enum.KeyCode.W) == false then
                u10.Callbacks.Run.HoldingRun = false
                _G.running = false
                return
            end
            if u10.Callbacks.Run.HoldingRun ~= true and _G.mobile == false then
                u10.Callbacks.Run.HoldingRun = true
                _G.running = true
                u10.Callbacks.Run:PC_Activate()
            end
        end
    end
end
v20:AddToRender("Movement", script, 1).Event:Connect(v46)