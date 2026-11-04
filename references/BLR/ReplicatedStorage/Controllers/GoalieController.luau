  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("PathfindingService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.Tweens);
local PlayerData = require(ReplicatedStorage2.ClientModules.ClientGlobals).PlayerData;
local LocalPlayer = game.Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local _ = workspace.CurrentCamera;
local u2 = tick();
local u3 = false;
local v4 = Knit.CreateController({
    Name = "GoalieController"
});

function v4.Dive(u5) -- Line: 34
    -- upvalues: u1 (ref), u2 (ref), LocalPlayer (copy), u3 (ref), Trove (copy), HumanoidRootPart (ref), Humanoid (ref), RunService (copy)
    if u1.Values.HasBall.Value then
        return;
    end;

    if u5.SC.States.Ability then
        return;
    end;

    if u2 > tick() then
        return;
    end;

    if u5.DiveTrove then
        u5.DiveTrove:Destroy();
    end;

    if LocalPlayer.PlayerStats.Stamina.Value <= 10 then
        return;
    end;

    u3 = true;
    u5.SC.States.Ability = true;
    u5.SC.OwnWalkState = true;
    u5.DiveTrove = Trove.new();

    if LocalPlayer.PlayerStats.Style.Value == "Gagamaru" then
        if u5.Ability.InSuper == true then
            u2 = tick() + 1;
        else
            u2 = tick() + 3;
        end;
    else
        u2 = tick() + 3;
    end;

    u5.StaminaService.DecreaseStamina:Fire(10);
    u5.BallService.Dive:Fire();
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(inf, inf, inf);
    u5.DiveTrove:Add(BodyVelocity);
    local BodyGyro = Instance.new("BodyGyro", HumanoidRootPart);
    BodyGyro.MaxTorque = Vector3.new(9999999, 9999999, 9999999);
    BodyGyro.D = 100;
    BodyGyro.P = 1000;
    BodyGyro.CFrame = HumanoidRootPart.CFrame;
    u5.DiveTrove:Add(BodyGyro);
    local u6 = 75;
    local u7 = u5.SC.States.Running and 55 or 40;
    local MoveDirection = Humanoid.MoveDirection;
    task.delay(0.05, function() -- Line: 80
        -- upvalues: HumanoidRootPart (ref), Humanoid (ref), u5 (copy), MoveDirection (ref)
        local v8 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity);
        print(v8);
        local v9 = {};
        local math_clamp_ret = math.clamp(v8.X / Humanoid.WalkSpeed, 0.001, 1);
        v9.Right = math.abs(math_clamp_ret);
        local math_clamp_ret2 = math.clamp(v8.X / Humanoid.WalkSpeed, -1, -0.001);
        v9.Left = math.abs(math_clamp_ret2);
        local math_clamp_ret3 = math.clamp(v8.Z / Humanoid.WalkSpeed, -1, -0.001);
        v9.Forward = math.abs(math_clamp_ret3);
        local math_clamp_ret4 = math.clamp(v8.Z / Humanoid.WalkSpeed, 0.001, 1);
        v9.Back = math.abs(math_clamp_ret4);
        u5.Animations:StopAnims();
        print(v9.Right);

        if v9.Right >= 0.7 then
            print("r");
            u5.Animations.Movement.DiveR.Priority = Enum.AnimationPriority.Action3;
            u5.Animations.Movement.DiveR:Play();
            u5.Animations.Movement.DiveR:AdjustSpeed(1.25);
        elseif v9.Left >= 0.7 then
            print("l");
            u5.Animations.Movement.DiveL.Priority = Enum.AnimationPriority.Action3;
            u5.Animations.Movement.DiveL:Play();
            u5.Animations.Movement.DiveL:AdjustSpeed(1.25);
        elseif v9.Forward >= 0.7 then
            print("f");
            u5.Animations.Movement.DiveF.Priority = Enum.AnimationPriority.Action3;
            u5.Animations.Movement.DiveF:Play();
            u5.Animations.Movement.DiveF:AdjustSpeed(1.25);
        else
            print("f");
            MoveDirection = HumanoidRootPart.CFrame.LookVector;
            u5.Animations.Movement.DiveF.Priority = Enum.AnimationPriority.Action3;
            u5.Animations.Movement.DiveF:Play();
            u5.Animations.Movement.DiveF:AdjustSpeed(1.25);
        end;

        table.clear(v9);
    end);
    u5.DiveTrove:Add(task.delay(1, function() -- Line: 120
        -- upvalues: u5 (copy)
        u5.SC.States.Ability = false;
        u5.SC.OwnWalkState = false;
    end));
    u5.DiveTrove:Connect(RunService.Heartbeat, function(p10) -- Line: 125
        -- upvalues: BodyVelocity (copy), MoveDirection (ref), u6 (ref), u7 (ref), u3 (ref), u5 (copy)
        BodyVelocity.Velocity = MoveDirection * u6 + Vector3.new(0, u7, 0);
        u6 = u6 - p10 * 28;
        u7 = u7 - p10 * 300;

        if u7 <= -5 or u3 == false then
            BodyVelocity:Destroy();
            u6 = 0;
            u7 = 0;
            u5.DiveTrove:Destroy();
            u5.SC.States.Ability = false;
        end;
    end);
end;

function v4.ResetChecks(u11) -- Line: 141
    -- upvalues: Trove (copy), Humanoid (ref), u1 (ref), Knit (copy), RunService (copy), HumanoidRootPart (ref), ReplicatedStorage (copy), LocalPlayer (copy)
    if u11.NewTrove then
        u11.NewTrove:Destroy();
    end;

    u11.NewTrove = Trove.new();
    u11.NewTrove:Connect(Humanoid.StateChanged, function(p12, p13) -- Line: 145
        -- upvalues: u1 (ref), u11 (copy)
        if p13 == Enum.HumanoidStateType.Jumping and (u1.Values.Goalie.Value and u1.Values.IsInPenalty.Value) then
            u11.Animations:StopAnims();
            u11.Animations.Movement.GoalieJump.Priority = Enum.AnimationPriority.Action2;
            u11.Animations.Movement.GoalieJump:Play();
            u11.BallService.Jump:Fire();
        end;
    end);
    local u14 = tick();
    tick();
    local u15 = false;
    local u16 = tick();
    local u17 = tick();
    local Controller = Knit.GetController("AbilityController");
    u11.NewTrove:Connect(RunService.Heartbeat, function() -- Line: 166
        -- upvalues: u16 (ref), u1 (ref), HumanoidRootPart (ref), ReplicatedStorage (ref), u14 (ref), Controller (copy), LocalPlayer (ref), u17 (ref), u15 (ref), u11 (copy)
        if u16 > tick() then
            return;
        end;

        u16 = tick() + 0.2;

        if u1 == nil then
            return;
        end;

        if HumanoidRootPart == nil then
            return;
        end;

        if not ReplicatedStorage.Football.Value:FindFirstChild("Char") then
            return;
        end;

        if not u1:FindFirstChild("Values") then
            return;
        end;

        if u1.Values.InCutscene.Value then
            u14 = tick();

            return;
        end;

        if ReplicatedStorage.Football.Value.Char.Value ~= u1 or Controller.InAbility then
            u14 = tick();
        end;

        if u1.Values.IsInPenalty.Value == false or (LocalPlayer.Team == game.Teams.Visitor or u1.Values.Goalie.Value == false) then
            if u17 < tick() then
                u14 = tick();

                if u1.Values.HasBall.Value == false then
                    u17 = tick() + 1;
                else
                    u17 = tick() + 6.5;
                end;
            end;

            u15 = false;
        end;

        if u14 + 5 < tick() then
            if u1.Values.HasBall.Value and (u1.Values.IsInPenalty.Value and (u1.Values.Goalie.Value and not u15)) then
                u14 = tick();
                u15 = true;
                print("Shooting");
                u11.BallService.GoalieShoot:Fire(230, nil, nil, (workspace.BallSpawn.Position - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.7, 0));
            end;
        else
            u15 = false;
        end;
    end);
    u11.NewTrove:Connect(u1:WaitForChild("Values").HasBall:GetPropertyChangedSignal("Value"), function() -- Line: 202
        -- upvalues: u1 (ref), u14 (ref), ReplicatedStorage (ref), u11 (copy)
        if u1.Values.IsInPenalty.Value == false then
            u14 = tick();

            return;
        end;

        if u1.Values.HasBall.Value == false then
            return;
        end;

        if u1.Values.Goalie.Value == false then
            return;
        end;

        if u14 == nil then
            u14 = tick();
        end;

        if ReplicatedStorage.Football.Value.Char.Value ~= u1 then
            u14 = tick();
        end;

        if u1.Values.BallY.Value > 13.2 then
            u11.Animations.Movement.Catch.Priority = Enum.AnimationPriority.Action3;
            u11.Animations.Movement.Catch:Play();
            u11.Animations.Ball.Catch.Priority = Enum.AnimationPriority.Action3;
            u11.Animations.Ball.Catch:Play();

            return;
        end;

        u11.Animations.Movement.PickUp.Priority = Enum.AnimationPriority.Action3;
        u11.Animations.Movement.PickUp:Play();
        u11.Animations.Ball.PickUp.Priority = Enum.AnimationPriority.Action3;
        u11.Animations.Ball.PickUp:Play();
    end);
    u11.NewTrove:Connect(u1.Values.IsInPenalty:GetPropertyChangedSignal("Value"), function() -- Line: 227
        -- upvalues: u1 (ref)
        if u1.Values.IsInPenalty.Value and u1.Values.Goalie.Value then
            local Descendants = workspace.Goals:GetDescendants();

            for _, v in pairs(Descendants) do
                if v:IsA("MeshPart") then
                    v.Transparency = 0.85;
                end;
            end;

            table.clear(Descendants);

            return;
        end;

        local Descendants = workspace.Goals:GetDescendants();

        for _, v in pairs(Descendants) do
            if v:IsA("MeshPart") then
                v.Transparency = 0;
            end;
        end;

        table.clear(Descendants);
    end);
end;

function v4.KnitStart(u18) -- Line: 254
    -- upvalues: Knit (copy), UserInputService (copy), u1 (ref), PlayerData (copy), LocalPlayer (copy), HumanoidRootPart (ref)
    u18.Animations = require(script.Parent.AnimationController);
    u18.BallController = Knit.GetController("BallController");
    u18.StaminaService = Knit.GetService("StaminaService");
    u18.BallService = Knit.GetService("BallService");
    u18.SC = Knit.GetController("StatesController");
    u18.Ability = Knit.GetController("AbilityController");
    u18.BaseTrove:Connect(UserInputService.InputBegan, function(p19, p20) -- Line: 262
        -- upvalues: u1 (ref), PlayerData (ref), u18 (copy)
        if p20 then
            return;
        end;

        if u1.Values.Goalie.Value == false then
            return;
        end;

        if u1.Values.IsInPenalty.Value == false then
            return;
        end;

        if p19.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.PC.Dive] or p19.KeyCode == Enum.KeyCode[PlayerData.Data.PlayerKeybinds.Console.Dive] then
            u18:Dive();
        end;
    end);
    u18.BaseTrove:Connect(LocalPlayer.PlayerGui.Mobile.NoBall.Dive.MouseButton1Click, function() -- Line: 272
        -- upvalues: u1 (ref), u18 (copy)
        if u1.Values.Goalie.Value == false then
            return;
        end;

        if u1.Values.IsInPenalty.Value == false then
            return;
        end;

        u18:Dive();
    end);
    u18.BaseTrove:Connect(LocalPlayer.PlayerGui:WaitForChild("Mobile"):WaitForChild("NoBall"):WaitForChild("Dribble").MouseButton1Click, function() -- Line: 278
        -- upvalues: u1 (ref), u18 (copy)
        if u1.Values.Goalie.Value == false then
            return;
        end;

        if u1.Values.IsInPenalty.Value == false then
            return;
        end;

        u18:Dive();
    end);
    u18.BaseTrove:Connect(u18.BallService.GoalieShoot, function(p21) -- Line: 285
        -- upvalues: LocalPlayer (ref), HumanoidRootPart (ref), u18 (copy)
        local Players = LocalPlayer.Team:GetPlayers();

        for i, v in pairs(Players) do
            if v == LocalPlayer then
                table.remove(Players, i);
                break;
            end;
        end;

        local v22 = nil;
        local v23 = (workspace.BallSpawn.Position - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.7, 0);

        if #Players > 0 then
            local math_random_ret = math.random(1, #Players);

            if Players[math_random_ret] and Players[math_random_ret].Character then
                v22 = Players[math_random_ret].Character;
            end;
        end;

        if v22 ~= nil then
            v23 = (v22.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.25, 0);
        end;

        p21.AssemblyLinearVelocity = v23 * 160;
        u18.BallController:DragBall(p21);
    end);
end;

function v4.KnitInit(u24) -- Line: 316
    -- upvalues: Knit (copy), Trove (copy), LocalPlayer (copy), u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
    u24.Settings = Knit.GetController("Settings");
    u24.BaseTrove = Trove.new();
    u24.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p25) -- Line: 320
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref), u24 (copy)
        u1 = p25;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");

        if u24.DiveTrove then
            u24.DiveTrove:Destroy();
        end;

        u24:ResetChecks();
    end);
    u24.BaseTrove:Connect(game.Players.PlayerRemoving, function(p26) -- Line: 329
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), Humanoid (ref), u24 (copy)
        if p26 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u24.BaseTrove:Destroy();
        end;
    end);
    u24:ResetChecks();
end;

return v4;