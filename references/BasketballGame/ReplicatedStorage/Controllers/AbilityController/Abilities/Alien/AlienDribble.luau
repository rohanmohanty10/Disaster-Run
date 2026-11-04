 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Abilities = require(ReplicatedStorage.Shared.Tables.Cooldowns).Abilities;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 20
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), Abilities (copy), RunService (copy), Essentials (copy), ReplicatedStorage (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if u6.InDominance then
        local v7 = u6:HoopDist();

        if v7 > 100 then
            Effects:Popup("Too far away from hoop!");
            u6:ResetCD(1);

            return;
        end;

        if v7 < 30 then
            Effects:Popup("Too close to the hoop!");
            u6:ResetCD(1);

            return;
        end;

        u6.CDS[2] = Abilities.Alien[2];
        u6.InDominance = nil;
        u2.States.AbilitiesUsable = 0;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Alien Dribble";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Dominance";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
        u1.Ability:Fire("The Reach", {
            State = "Layup",
            TimeSent = workspace:GetServerTimeNow()
        });
        u4:StopAll();
        u4:PlayChar("Alien", "Layup", Enum.AnimationPriority.Action3);
        u4:PlayBall("Alien", "LayupBall", Enum.AnimationPriority.Action3);

        if Character:FindFirstChild(script.Name .. "AlignPosition") then
            Character:FindFirstChild(script.Name .. "AlignPosition"):Destroy();
        end;

        local FieldOfView = workspace.CurrentCamera.FieldOfView;
        local u9 = RunService.Heartbeat:Connect(function(p8) -- Line: 68
            -- upvalues: FieldOfView (ref), Essentials (ref), HumanoidRootPart (copy)
            FieldOfView = Essentials:Lerp(FieldOfView, 45 + HumanoidRootPart.AssemblyLinearVelocity.Magnitude, p8 * 4);
            workspace.CurrentCamera.FieldOfView = FieldOfView;
        end);
        task.delay(0.6, function() -- Line: 73
            -- upvalues: u9 (copy)
            u9:Disconnect();
        end);
        task.wait(0.2);
        local _ = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u2.States.Dunking = true;
        task.spawn(function() -- Line: 84
            -- upvalues: RunService (ref), Humanoid (copy), u2 (ref)
            RunService.Heartbeat:Wait();
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping);
            u2.States.Boost = 10;
            task.wait(0.4);
            u2.States.Dunking = false;
            u2.States.Boost = 0;
        end);
        u6.AC:Connect(u1.Ability, function() -- Line: 93
            -- upvalues: u6 (copy), ReplicatedStorage (ref), u3 (ref), LocalPlayer (ref)
            u6.AC:Clean();
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local Position = Value.Position;
            local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position).Magnitude;
            local v10 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position;
            local math_log_ret = math.log(1 + v10.Magnitude * 0.045);
            Value.AssemblyLinearVelocity = v10 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
        end);

        return;
    end;

    if u2.States.PumpFake then
        Effects:Popup("Can\'t use after a fake!");
        u6:ResetCD(1);

        return;
    end;

    u2.States.Ability = true;
    u6.AC:Add(function() -- Line: 122
        -- upvalues: u2 (ref)
        u2.Boost = 0;
        u2.States.Ability = false;
    end);

    if not u6.Dribble then
        u6.AC:Add(task.delay(1.25, function() -- Line: 199
            -- upvalues: u6 (copy)
            u6.AC:Clean();
        end));
        u1.Ability:Fire("Alien Dribble", {
            State = "Dribble",
            TimeSent = workspace:GetServerTimeNow()
        });
        u4:StopAll();
        u4:PlayChar("Alien", "AlienDribble", Enum.AnimationPriority.Action3);
        u4:PlayBall("Alien", "AlienDribbleBall", Enum.AnimationPriority.Action3);
        u2.Boost = -5;
        u6.AC:Add(task.delay(0.6666666666666666, function() -- Line: 211
            -- upvalues: u2 (ref)
            u2.Boost = 10;
        end));
        u6.AC:Add(task.delay(0.75, function() -- Line: 215
            -- upvalues: u2 (ref)
            u2.Boost = 25;
        end));
        u6.AC:Add(task.delay(1, function() -- Line: 219
            -- upvalues: u2 (ref)
            u2.Boost = -10;
        end));
        task.wait(1.25);
        u6.Dribble = true;
        u6:ResetCD(1);
        local u11 = nil;
        task.delay(6, function() -- Line: 229
            -- upvalues: u11 (ref)
            u11 = true;
        end);
        local u12 = 1;
        local u13 = false;
        local u14 = nil;

        local function End() -- Line: 238
            -- upvalues: LocalPlayer (ref), u6 (copy), Abilities (ref), u14 (ref)
            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[1] = tick() + Abilities.Alien[1];
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Alien Dribble";
            u14:Disconnect();

            if u6.Dribble then
                u6.Dribble = nil;
            end;
        end;

        u14 = RunService.Heartbeat:Connect(function(p15) -- Line: 253
            -- upvalues: u6 (copy), u11 (ref), End (copy), u5 (ref), Character (copy), LocalPlayer (ref), u12 (ref), u13 (ref)
            if not u6.Dribble or (u6.InDominance or u11) then
                End();

                return;
            end;

            if not (u5.CharValues.HasBall or Character:GetAttribute("Nutmeg")) then
                End();

                return;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u12;

            if u12 > 0.5 and not u13 then
                p15 = -p15 or p15;
            end;

            u12 = u12 + p15;

            if u12 <= 0.5 then
                u13 = true;
            end;

            if u12 >= 1 then
                u13 = false;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Alien Shift";
        end);

        return;
    end;

    if u6.Dribble == "Second" then
        u6.Dribble = nil;
    else
        u6.Dribble = "Second";
        u6:ResetCD(1);
    end;

    u6.AC:Add(task.delay(0.25, function() -- Line: 135
        -- upvalues: u2 (ref)
        u2.Boost = 50;
    end));
    u6.AC:Add(task.delay(0.5, function() -- Line: 138
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    local u16 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection).X > 0.01 and "R" or "L";
    u1.Ability:Fire("Alien Dribble", {
        State = "Shift",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    u4:PlayChar("Alien", `AlienShift{u16}`, Enum.AnimationPriority.Action3);
    u4:PlayBall("Alien", `AlienShift{u16}Ball`, Enum.AnimationPriority.Action3);
    local NumberValue = Instance.new("NumberValue");
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(40000, 0, 40000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(NumberValue);
    u6.AC:Add(LinearVelocity);
    local FieldOfView = workspace.CurrentCamera.FieldOfView;
    u6.AC:Connect(RunService.Heartbeat, function(p17) -- Line: 163
        -- upvalues: LinearVelocity (copy), u16 (copy), HumanoidRootPart (copy), NumberValue (copy), FieldOfView (ref), Essentials (ref)
        if LinearVelocity then
            local v18 = u16 == "R" and HumanoidRootPart.CFrame.RightVector;

            if not v18 then
                if u16 == "L" then
                    v18 = -HumanoidRootPart.CFrame.RightVector;
                else
                    v18 = false;
                end;
            end;

            LinearVelocity.VectorVelocity = v18 * NumberValue.Value;
        end;

        FieldOfView = Essentials:Lerp(FieldOfView, 45 + HumanoidRootPart.AssemblyLinearVelocity.Magnitude, p17 * 4);
        workspace.CurrentCamera.FieldOfView = FieldOfView;
    end);
    local u19 = nil;
    u19 = u1.Ability:Connect(function() -- Line: 173
        -- upvalues: u19 (ref), ReplicatedStorage (ref), u2 (ref), u3 (ref), u16 (copy), HumanoidRootPart (copy)
        u19:Disconnect();
        local Value = ReplicatedStorage.Basketball.Value;
        task.delay(0.5, function() -- Line: 178
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.Boost = 0;
        end);
        Value.CFrame = u3:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame + Vector3.new(0, 0.5, 0);
        local v20 = u16 == "R" and HumanoidRootPart.CFrame.RightVector;

        if not v20 then
            if u16 == "L" then
                v20 = -HumanoidRootPart.CFrame.RightVector;
            else
                v20 = false;
            end;
        end;

        Value.AssemblyLinearVelocity = (v20 + Vector3.new(0, 0.5, 0)) * 50;
    end);
    u6.AC:Add(u19);
    NumberValue.Value = 25;
    task.wait(0.25);
    TweenService:Create(NumberValue, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 100
    }):Play();
    task.wait(0.1);
    TweenService:Create(NumberValue, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 25
    }):Play();
end;