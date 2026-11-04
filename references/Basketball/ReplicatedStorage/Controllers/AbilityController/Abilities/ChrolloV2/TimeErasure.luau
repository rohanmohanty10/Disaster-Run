 
 

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
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), RunService (copy), TweenService (copy), Effects (copy), Abilities (copy), Essentials (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;

    if not u6.TimeErasure then
        u1.Ability:Fire("Time Erasure", {
            State = "Erasure",
            TimeSent = workspace:GetServerTimeNow()
        });
        local u7 = {};
        u6.TimeErasure = {};
        u6:ResetCD(4);
        u2.States.Ability = true;
        u2.States.AbilitiesUsable = -1;
        local v8 = u2;
        v8.Boost = v8.Boost + 20;
        task.delay(5, function() -- Line: 166
            -- upvalues: u6 (copy), Effects (ref)
            for i = 1, 5 do
                if not (u6.Network.CharValues.InAwakening and u6.TimeErasure) then
                    return;
                end;

                Effects:Popup((`{tostring(5 - i)} SECONDS LEFT.`));
                task.wait(1);
                local _ = i;
            end;
        end);
        local u9 = nil;
        task.delay(10, function() -- Line: 175
            -- upvalues: u9 (ref)
            u9 = true;
        end);
        local u10 = 1;
        local u11 = false;
        local u12 = nil;

        local function End() -- Line: 184
            -- upvalues: LocalPlayer (ref), u6 (copy), Abilities (ref), u12 (ref), u7 (copy), u2 (ref)
            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
                u6.CDS[4] = tick() + Abilities.ChrolloV2[4];
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
            u12:Disconnect();

            for _, v in pairs(u7) do
                if v then
                    v:Destroy();
                end;
            end;

            if u6.TimeErasure then
                u6.TimeErasure = nil;
                u2.States.Ability = false;
                u2.States.AbilitiesUsable = 0;
                local v13 = u2;
                v13.Boost = v13.Boost - 20;

                if u2.Boost < 0 then
                    u2.Boost = 0;
                end;
            end;
        end;

        u12 = RunService.Heartbeat:Connect(function(p14) -- Line: 212
            -- upvalues: u6 (copy), u9 (ref), End (copy), u5 (ref), Essentials (ref), LocalPlayer (ref), HumanoidRootPart (copy), ReplicatedStorage (ref), u7 (copy), u10 (ref), u11 (ref)
            if not u6.TimeErasure or u9 then
                End();

                return;
            end;

            if not u5.CharValues.InAwakening then
                End();

                return;
            end;

            for _, v in game.Teams[Essentials:ActualTeam(LocalPlayer.Team.Name)]:GetPlayers() do
                if v.Character and not (table.find(u6.TimeErasure, v.Character) or (not v.Character:FindFirstChild("HumanoidRootPart") or (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 15)) then
                    local v15 = ReplicatedStorage.Controllers.BallController.Pass.PlrStyle:Clone();
                    v15.Parent = v.Character;
                    v15.Style.Text = "Marked";
                    v15.Style.TextColor3 = Color3.fromRGB(220, 20, 60);
                    table.insert(u6.TimeErasure, v.Character);
                    table.insert(u7, v15);
                end;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u10;

            if u10 > 0.5 and not u11 then
                p14 = -p14 or p14;
            end;

            u10 = u10 + p14;

            if u10 <= 0.5 then
                u11 = true;
            end;

            if u10 >= 1 then
                u11 = false;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Time Skip";
        end);
        u6.AwakeningAbility1Used = true;
        local u16 = nil;
        u16 = RunService.Heartbeat:Connect(function() -- Line: 254
            -- upvalues: u5 (ref), u16 (ref), u6 (copy)
            if not u5.CharValues.InAwakening then
                u16:Disconnect();
                u6.AwakeningAbility1Used = nil;
            end;
        end);

        return;
    end;

    local TimeErasure = u6.TimeErasure;
    u6.TimeErasure = nil;
    u2.States.Ability = true;
    u2.States.AbilitiesUsable = 0;
    local v17 = u2;
    v17.Boost = v17.Boost - 20;

    if u2.Boost < 0 then
        u2.Boost = 0;
    end;

    u6.AC:Add(function() -- Line: 43
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    u6.AC:Add(task.delay(4.05, function() -- Line: 47
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end));
    u6.AC:Add(task.delay(4.266666666666667, function() -- Line: 51
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    u1.Ability:Fire("Time Erasure", {
        State = "Skip",
        TimeSent = workspace:GetServerTimeNow(),
        Marked = TimeErasure
    });
    local u18 = nil;
    local u19 = u6.AC:Add(Instance.new("NumberValue"));
    local u20 = u6.AC:Add(Instance.new("LinearVelocity"));
    u20.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    u20.MaxAxesForce = Vector3.new(20000, 0, 20000);
    u20.Attachment0 = HumanoidRootPart.RootAttachment;
    u20.Parent = HumanoidRootPart;
    u6.AC:Connect(RunService.Heartbeat, function() -- Line: 67
        -- upvalues: u20 (copy), u18 (ref), u19 (copy), HumanoidRootPart (copy)
        u20.VectorVelocity = typeof(u18) == "Vector3" and u18 * u19.Value or (typeof(u18) == "string" and HumanoidRootPart.CFrame[u18] * u19.Value or HumanoidRootPart.CFrame.LookVector * u19.Value);
    end);

    for i = 1, 4 do
        u4:StopAll();
        u4:PlayChar("ChrolloV2", `TimeSkip{i}`, Enum.AnimationPriority.Action3);
        u4:PlayBall("ChrolloV2", `TimeSkipBall{i}`, Enum.AnimationPriority.Action3);
        local v21 = TimeErasure[i];
        local v22 = v21 and v21:FindFirstChild("HumanoidRootPart") and v21.HumanoidRootPart.Position - HumanoidRootPart.Position;
        local u23;

        if v22 then
            if v22.Magnitude > 0 then
                u23 = v22.Unit;
            else
                u23 = false;
            end;
        end;

        local u24 = v22 and v22.Magnitude or 0;
        local v25;

        if i == 1 then
            u18 = u23;
            u19.Value = math.clamp(u24 * 4, 60, 240);
            task.delay(0.26666666666666666, function() -- Line: 85
                -- upvalues: u18 (ref), u19 (copy), TweenService (ref)
                u18 = "RightVector";
                u19.Value = 90;
                TweenService:Create(u19, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    Value = 5
                }):Play();
            end);
            task.delay(0.4666666666666667, function() -- Line: 91
                -- upvalues: u18 (ref), u23 (copy), u19 (copy), u24 (copy), TweenService (ref)
                u18 = u23;
                u19.Value = math.clamp(u24 * 6, 90, 360);
                TweenService:Create(u19, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    Value = 5
                }):Play();
            end);
            task.wait(0.8);
            v25 = i;
        elseif i == 2 then
            u18 = u23;
            u19.Value = math.clamp(u24 * 2, 30, 120);
            task.delay(0.4666666666666667, function() -- Line: 102
                -- upvalues: u18 (ref), u19 (copy), TweenService (ref)
                u18 = "RightVector";
                u19.Value = -90;
                TweenService:Create(u19, TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    Value = 5
                }):Play();
            end);
            task.delay(0.6333333333333333, function() -- Line: 108
                -- upvalues: u18 (ref), u23 (copy), u19 (copy), u24 (copy), TweenService (ref)
                u18 = u23;
                u19.Value = math.clamp(u24 * 6, 90, 360);
                TweenService:Create(u19, TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    Value = 5
                }):Play();
            end);
            task.wait(1.0333333333333334);
            v25 = i;
        elseif i == 3 then
            u18 = u23;
            u19.Value = math.clamp(u24 * 4, 60, 240);
            TweenService:Create(u19, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                Value = 30
            }):Play();
            task.delay(0.7, function() -- Line: 120
                -- upvalues: u18 (ref), u19 (copy), TweenService (ref)
                u18 = "LookVector";
                u19.Value = -90;
                TweenService:Create(u19, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    Value = -5
                }):Play();
            end);
            task.delay(0.8666666666666667, function() -- Line: 126
                -- upvalues: u18 (ref), u23 (copy), TweenService (ref), u19 (copy)
                u18 = u23;
                TweenService:Create(u19, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Value = 90
                }):Play();
            end);
            task.delay(1.0666666666666667, function() -- Line: 131
                -- upvalues: u19 (copy), u24 (copy), TweenService (ref)
                u19.Value = math.clamp(u24 * 6, 90, 360);
                TweenService:Create(u19, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    Value = 5
                }):Play();
            end);
            task.wait(1.2666666666666666);
            v25 = i;
        elseif i == 4 then
            u18 = u23;
            u19.Value = math.clamp(u24 * 4, 60, 240);
            task.delay(0.8, function() -- Line: 141
                -- upvalues: u18 (ref), u23 (copy), u19 (copy), u24 (copy), TweenService (ref)
                u18 = u23;
                u19.Value = math.clamp(u24 * 6, 90, 360);
                TweenService:Create(u19, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    Value = 5
                }):Play();
            end);
            task.wait(1.1666666666666667);
            v25 = i;
        else
            v25 = i;
        end;
    end;
end;