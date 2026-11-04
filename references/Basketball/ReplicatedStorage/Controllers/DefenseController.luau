 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = Trove.new();
local u8 = Trove.new();
local u9 = tick();
local v10 = Knit.CreateController({
    Name = "DefenseController"
});

function v10.StealDb(p11) -- Line: 36
    -- upvalues: u9 (ref), Zones (copy), LocalPlayer (copy)
    u9 = tick() + (Zones.StealCooldowns[LocalPlayer.Zone.Value] or 2.35);
end;

function v10.Steal(p12) -- Line: 40
    -- upvalues: u5 (ref), u9 (ref), u6 (ref), ReplicatedStorage (copy), LocalPlayer (copy), u7 (copy), u3 (ref), Zones (copy), u1 (ref), HumanoidRootPart (ref), RunService (copy), u4 (ref), Essentials (copy), u2 (ref)
    if u5.CharValues.HasBall then
        return;
    end;

    if u9 > tick() then
        return;
    end;

    if not u6 then
        return;
    end;

    if u6:NoAction() then
        return;
    end;

    if ReplicatedStorage.GameValues.Scoring.Value then
        return;
    end;

    if LocalPlayer.Team == game.Teams.Visitor or LocalPlayer.Team == nil then
        return;
    end;

    p12:StealDb();
    u7:Clean();
    u3.States.Stealing = true;
    local u13 = 42;

    if u5.CharValues.InZone and Zones.ZoneIncreasedStealingSpeed[LocalPlayer.Zone.Value] then
        u13 = u13 * (1 + Zones.ZoneIncreasedStealingSpeed[LocalPlayer.Zone.Value]);
    end;

    if u1:GetAttribute("Nutmeg") then
        u13 = u13 * 1.5;
    end;

    local ServerBallPosition = u6:GetServerBallPosition();
    local u14 = u13;
    local v15 = nil;
    local v16 = nil;

    for _, child in workspace.Debris:GetChildren() do
        if child:GetAttribute("Clone") then
            local Magnitude = (child.Position - HumanoidRootPart.Position).Magnitude;

            if Magnitude < (ServerBallPosition - HumanoidRootPart.Position).Magnitude and (not v15 or v15 < Magnitude) then
                v16 = child;
                v15 = Magnitude;
            end;
        end;
    end;

    if v16 and (v16.Position - HumanoidRootPart.Position).Magnitude < (ServerBallPosition - HumanoidRootPart.Position).Magnitude then
        ServerBallPosition = v16.Position;
    end;

    local Unit = (Vector3.new(ServerBallPosition.X, 0, ServerBallPosition.Z) - Vector3.new(HumanoidRootPart.Position.X, 0, HumanoidRootPart.Position.Z)).Unit;
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local v17 = HumanoidRootPart.CFrame.LookVector:Dot(Unit);
    local math_acos_ret = math.acos(v17);

    if math_acos_ret < 1.5707963267948966 or math_acos_ret < 1.9039955476301778 then
        LookVector = (LookVector + Unit).Unit;
    end;

    local u18 = HumanoidRootPart.CFrame + LookVector * (u14 * 0.36904761904761907);
    local u19 = false;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { u1 };
    RaycastParams_new_ret.CollisionGroup = "Player";
    u7:Connect(RunService.Heartbeat, function(p20) -- Line: 107
        -- upvalues: u3 (ref), u19 (ref), u7 (ref), u5 (ref), HumanoidRootPart (ref), LookVector (ref), RaycastParams_new_ret (copy), u13 (ref), u14 (ref), u18 (copy)
        if not u3.States.Stealing then
            u19 = true;
            u7:Clean();
            u3.States.Stealing = false;

            if u5.CharValues.HasBall then
                u3.States.Running = true;
            end;

            return;
        end;

        local v21 = workspace:Raycast(HumanoidRootPart.Position, LookVector * 4, RaycastParams_new_ret);

        if v21 and v21.Instance.Parent:FindFirstChild("Humanoid") == nil then
            u19 = true;
            u7:Clean();
            u3.States.Stealing = false;

            if u5.CharValues.HasBall then
                u3.States.Running = true;
            end;

            return;
        end;

        if u13 >= u14 / 2 then
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(u18, p20 * (u13 / 8));
            u13 = u13 - p20 * 22;

            return;
        end;

        u19 = true;
        u7:Clean();
        u3.States.Stealing = false;

        if u5.CharValues.HasBall then
            u3.States.Running = true;
        end;
    end);
    local v22 = u4:PlayChar("Blocks", `Steal{Essentials:ReturnRorL(u5.CharValues)}`, Enum.AnimationPriority.Action2, true);
    local v23 = u4:PlayBall("Blocks", `Steal{Essentials:ReturnRorL(u5.CharValues)}`, Enum.AnimationPriority.Action2, true);
    v22:AdjustSpeed(1.4);
    v23:AdjustSpeed(1.4);
    u2.Steal:Fire(u18);
    u5.CharValues.StealingTick = tick() + 0.5;
    u5.CharValues.Stealing = true;
    task.delay(0.51, function() -- Line: 147
        -- upvalues: u5 (ref)
        if u5.CharValues.StealingTick < tick() then
            u5.CharValues.Stealing = false;
        end;
    end);
    task.delay(0.45, function() -- Line: 153
        -- upvalues: u19 (ref), u7 (ref), u3 (ref), u5 (ref)
        if u19 then
            return;
        end;

        u7:Clean();
        u3.States.Stealing = false;

        if u5.CharValues.HasBall then
            u3.States.Running = true;
        end;
    end);
end;

function v10.Input(u24) -- Line: 161
    -- upvalues: LocalPlayer (copy), Knit (copy), UserInputService (copy), u1 (ref), u6 (ref)
    for _, descendant in LocalPlayer.PlayerGui.Mobile:GetDescendants() do
        if descendant:IsA("ImageButton") ~= false then
            descendant.MouseButton1Click:Connect(function() -- Line: 166
                -- upvalues: descendant (copy), u24 (copy)
                if descendant.Name == "Steal" then
                    u24:Steal();
                end;
            end);
        end;
    end;

    local Controller = Knit.GetController("KeybindsController");
    UserInputService.InputBegan:Connect(function(p25, p26) -- Line: 175
        -- upvalues: u1 (ref), u6 (ref), Controller (copy), u24 (copy)
        if p26 then
            return;
        end;

        if u1:FindFirstChild("IsRagdoll") == nil then
            return;
        end;

        if u1.IsRagdoll.Value then
            return;
        end;

        if u6:NoAction() then
            return;
        end;

        if Controller.IsInputValid(p25, "Steal") then
            u24:Steal();
        end;
    end);
end;

function v10.Resets(p27) -- Line: 187
    -- upvalues: u8 (copy), Humanoid (ref), u1 (ref), u5 (ref), LocalPlayer (copy), Zones (copy), u6 (ref), HumanoidRootPart (ref), ReplicatedStorage (copy), Effects (copy), u2 (ref), u4 (ref)
    u8:Clean();
    u8:Connect(Humanoid.StateChanged, function(p28, p29) -- Line: 190
        -- upvalues: u1 (ref), u5 (ref), LocalPlayer (ref), Zones (ref), u6 (ref), HumanoidRootPart (ref), ReplicatedStorage (ref), Effects (ref), u2 (ref), u4 (ref)
        if p29 == Enum.HumanoidStateType.Jumping then
            if u1:FindFirstChild("IsRagdoll") == nil then
                return;
            end;

            if u5.CharValues.HasBall then
                return;
            end;

            if LocalPlayer.Team == game.Teams.Visitor then
                return;
            end;

            if u1.IsRagdoll.Value then
                return;
            end;

            local v30 = 1;

            if u5.CharValues.InZone and Zones.BlockDistBuffZones[LocalPlayer.Zone.Value] then
                v30 = v30 + Zones.BlockDistBuffZones[LocalPlayer.Zone.Value];
            end;

            if u5.CharValues.MalevolentVisionMode >= workspace:GetServerTimeNow() then
                v30 = v30 + 0.7;
            end;

            if u5.CharValues.BlockingRangeBoost and u5.CharValues.BlockingRangeBoost > 0 then
                v30 = v30 * u5.CharValues.BlockingRangeBoost;
            end;

            if LocalPlayer:GetAttribute("SlightBuff") then
                v30 = v30 + 0.175;
            end;

            local ServerBallPosition = u6:GetServerBallPosition();

            if (LocalPlayer:GetAttribute("SuperBlock") and 0 or (ServerBallPosition - HumanoidRootPart.Position).Magnitude) >= v30 * 25 and ReplicatedStorage.GameValues.TipOff.Value == false then
                if u5.ServerType == "Tutorial" then
                    Effects:Popup("Get closer to block!");
                end;

                return;
            end;

            u2.Block:Fire();
            u5.CharValues.Blocked = tick();

            if ReplicatedStorage.GameValues.TipOff.Value then
                u4:StopAll();
                u4:PlayChar("Blocks", "TipOff", Enum.AnimationPriority.Action3);

                return;
            end;

            if LocalPlayer.Zone.Value ~= "Animalistic" or not u5.CharValues.InZone then
                u4:StopAll();
                u4:PlayChar("Blocks", "Blocked", Enum.AnimationPriority.Action3);
            end;
        end;
    end);
    u8:Connect(ReplicatedStorage.GameValues.TipOff:GetPropertyChangedSignal("Value"), function() -- Line: 235
        -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), u4 (ref)
        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if not ReplicatedStorage.GameValues.TipOff.Value then
            u4:StopAll();

            return;
        end;

        u4:StopAll();
        u4:PlayChar("Movement", "TipOff", Enum.AnimationPriority.Action3);
    end);
end;

function v10.KnitStart(u31) -- Line: 246
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), u4 (ref), u6 (ref), u5 (ref), u1 (ref), RunService (copy), LocalPlayer (copy), Essentials (copy), HumanoidRootPart (ref), Humanoid (ref)
    u2 = Knit.GetService("BallService");
    u3 = Knit.GetController("MovementController");
    u4 = Knit.GetController("AnimationController");
    u6 = Knit.GetController("BallController");
    u5 = Knit.GetController("Network");
    u2.Steal:Connect(function(p32, u33, p34) -- Line: 254
        -- upvalues: u1 (ref), RunService (ref)
        if p32 == u1 then
            return;
        end;

        local HumanoidRootPart2 = p32.HumanoidRootPart;
        local u35 = nil;
        u35 = RunService.Heartbeat:Connect(function(p36) -- Line: 258
            -- upvalues: HumanoidRootPart2 (copy), u33 (copy), u35 (ref)
            if (HumanoidRootPart2.Position - u33.Position).Magnitude > 3 then
                HumanoidRootPart2.CFrame = HumanoidRootPart2.CFrame:Lerp(u33, p36 * 6.2);

                return;
            end;

            u35:Disconnect();
        end);
        task.delay(0.5, function() -- Line: 267
            -- upvalues: u35 (ref)
            u35:Disconnect();
        end);
    end);
    RunService.Heartbeat:Connect(function(p37) -- Line: 270
        -- upvalues: LocalPlayer (ref), u5 (ref), Essentials (ref), u6 (ref), HumanoidRootPart (ref)
        if LocalPlayer.Team == game.Teams.Visitor or LocalPlayer.Team == nil then
            return;
        end;

        local v38 = false;

        if u5.CharValues.HasBall then
            for _, v in game.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)]:GetPlayers() do
                local Character = v.Character;

                if Character then
                    Character = Character:FindFirstChild("HumanoidRootPart");
                end;

                if Character and (HumanoidRootPart.Position - Character.Position).Magnitude <= 25 then
                    local v39 = HumanoidRootPart.CFrame.LookVector:Dot((Character.Position - HumanoidRootPart.Position).Unit);
                    local math_acos_ret = math.acos(v39);
                    local v40 = math_acos_ret < 1.5707963267948966;
                    local _ = math_acos_ret < 1.9039955476301778;

                    if v40 then
                        v38 = v40;
                        break;
                    end;
                end;
            end;

            u5.CharValues.Defense = false;
            u5.CharValues.BeingSpotted = v38;

            return;
        end;

        for _, v in Essentials:GetPlayers(Essentials:ActualTeam(LocalPlayer.Team.Name)) do
            local Character = v.Character;

            if Character and u6:GetCharacterPossessingBall() == Character then
                local HumanoidRootPart2 = Character:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart2 and (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude <= 25 then
                    local v41 = HumanoidRootPart2.CFrame.LookVector:Dot((HumanoidRootPart.Position - HumanoidRootPart2.Position).Unit);
                    local math_acos_ret = math.acos(v41);
                    local v42 = math_acos_ret < 1.5707963267948966;
                    local _ = math_acos_ret < 1.9039955476301778;

                    if v42 then
                        v38 = v42;
                        break;
                    end;
                end;
            end;
        end;

        u5.CharValues.Defense = v38;
        u5.CharValues.BeingSpotted = false;
    end);
    u31:Input();
    u31:Resets();
    LocalPlayer.CharacterAdded:Connect(function(p43) -- Line: 333
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref), u31 (copy)
        u1 = p43;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
        u31:Resets();
    end);
end;

function v10.KnitInit(p44) -- Line: 342
end;

return v10;