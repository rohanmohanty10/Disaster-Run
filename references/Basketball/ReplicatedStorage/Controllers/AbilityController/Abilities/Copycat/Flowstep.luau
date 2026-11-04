 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Styles = require(ReplicatedStorage.Shared.Tables.Styles);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 19, Name: Flowstep
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), RunService (copy), Players (copy), Styles (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Humanoid = Character.Humanoid;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.CameraController;

    if u2.States.PumpFake then
        u6:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    if u6.FlowstepDash then
        local v7 = u6:CheckInfront(25);
        u6.FlowstepDash = nil;
        RunService.Heartbeat:Wait();
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Flowstep";
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
        v7 = v7;
        local v8;

        if v7 then
            v8 = Players:GetPlayerFromCharacter(v7);
        else
            v8 = v7;
        end;

        local v9 = "Shooter";

        if v8 then
            v9 = Styles.Setting[v8.Style.Value];
            Effects:Popup("Other player was a " .. v9 .. "! Activated BURST!");
        else
            Effects:Popup("No player infront of you! Activated BURST!");
        end;

        if v9 ~= "Slasher" then
            local u10 = HumanoidRootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection);
            local v11 = u10.X > 0 and "R" or "L";
            task.delay(0.5, function() -- Line: 79
                -- upvalues: u2 (ref), u6 (copy)
                u2.States.Ability = false;
                u6.AC:Clean();
            end);
            u3:StopAll();
            u3:PlayChar("Copycat", `Flowstep{v11}`, Enum.AnimationPriority.Action3, true);
            u3:PlayBall("Copycat", `Flowstep{v11}Ball`, Enum.AnimationPriority.Action3, true);
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
            LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.Parent = HumanoidRootPart;
            u6.AC:Add(LinearVelocity);
            local u12 = 85;
            u6.AC:Connect(RunService.Heartbeat, function(p13) -- Line: 94
                -- upvalues: u10 (copy), HumanoidRootPart (copy), u12 (ref), LinearVelocity (copy)
                u12 = u12 - p13 * 15;
                LinearVelocity.VectorVelocity = (u10.X > 0 and HumanoidRootPart.CFrame.RightVector or -HumanoidRootPart.CFrame.RightVector) * u12;
            end);
            u1.Ability:Fire("Flowstep", {
                Dash = true,
                TimeSent = workspace:GetServerTimeNow()
            });

            return;
        end;

        task.delay(0.75, function() -- Line: 50
            -- upvalues: u2 (ref), u6 (copy)
            u2.States.Ability = false;
            u6.AC:Clean();
        end);
        u3:StopAll();
        local v14 = u3:PlayChar("Copycat", "FlowstepSlasher", Enum.AnimationPriority.Action3, true);
        local v15 = u3:PlayBall("Copycat", "FlowstepSlasherBall", Enum.AnimationPriority.Action3, true);
        v14:AdjustSpeed(1.25);
        v15:AdjustSpeed(1.25);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
        LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.Parent = HumanoidRootPart;
        u6.AC:Add(LinearVelocity);
        local LookVector = HumanoidRootPart.CFrame.LookVector;
        local u16 = 75;
        u6.AC:Connect(RunService.Heartbeat, function(p17) -- Line: 69
            -- upvalues: u16 (ref), LinearVelocity (copy), LookVector (copy)
            u16 = u16 - p17 * 15;
            LinearVelocity.VectorVelocity = LookVector * u16;
        end);
        u1.Ability:Fire("Flowstep", {
            Dash = true,
            TimeSent = workspace:GetServerTimeNow(),
            Other = v7
        });

        return;
    end;

    u6.CDS[2] = tick() + 0.5;
    u2.States.Ability = true;
    u6.FlowstepDash = true;
    u6.AC:Add(task.delay(0.8, function() -- Line: 110
        -- upvalues: u2 (ref), u6 (copy)
        u2.States.Ability = false;
        u6.AC:Clean();
    end));
    task.delay(3, function() -- Line: 113
        -- upvalues: u6 (copy), LocalPlayer (ref)
        if u6.FlowstepDash then
            u6.FlowstepDash = nil;

            if not (workspace:GetAttribute("NoAbilityCooldowns") or LocalPlayer:GetAttribute("NoAbilityCooldowns")) then
                u6.CDS[2] = tick() + 75;
            end;

            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
        end;
    end);
    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity;
    local v18 = HumanoidRootPart.CFrame:VectorToObjectSpace(HumanoidRootPart.AssemblyLinearVelocity);
    local v19 = {};
    local v20 = {};
    local math_clamp_ret = math.clamp(v18.X / Humanoid.WalkSpeed, 0.01, 1);
    v20[1], v20[2] = math.abs(math_clamp_ret), HumanoidRootPart.CFrame.RightVector;
    v19.R = v20;
    local v21 = {};
    local math_clamp_ret2 = math.clamp(v18.X / Humanoid.WalkSpeed, -1, -0.01);
    v21[1], v21[2] = math.abs(math_clamp_ret2), -HumanoidRootPart.CFrame.RightVector;
    v19.L = v21;
    local v22 = {};
    local math_clamp_ret3 = math.clamp(v18.Z / Humanoid.WalkSpeed, -1, -0.01);
    v22[1], v22[2] = math.abs(math_clamp_ret3), HumanoidRootPart.CFrame.LookVector;
    v19.F = v22;
    local v23 = {};
    local math_clamp_ret4 = math.clamp(v18.Z / Humanoid.WalkSpeed, 0.01, 1);
    v23[1], v23[2] = math.abs(math_clamp_ret4), -HumanoidRootPart.CFrame.LookVector;
    v19.B = v23;

    if AssemblyLinearVelocity.Magnitude < 5 then
        AssemblyLinearVelocity = HumanoidRootPart.CFrame.LookVector;
    end;

    if AssemblyLinearVelocity.Y > 3 and (AssemblyLinearVelocity.X < 5 and AssemblyLinearVelocity.Z < 5) then
        AssemblyLinearVelocity = HumanoidRootPart.CFrame.LookVector;
    end;

    local v24 = 0.1;
    local v25 = "F";

    for i, v in v19 do
        if v24 < v[1] then
            v24 = v[1];
            AssemblyLinearVelocity = v[2];
            v25 = i;
        end;
    end;

    u3:StopAll();
    u3:PlayChar("Copycat", `Flowstep{v25}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Copycat", `Flowstep{v25}Ball`, Enum.AnimationPriority.Action3);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis;
    LinearVelocity.MaxAxesForce = Vector3.new(20000, 0, 20000);
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.Parent = HumanoidRootPart;
    u6.AC:Add(LinearVelocity);
    local u26 = 60;
    local u27 = 1;
    local u28 = false;
    u6.AC:Connect(RunService.Heartbeat, function(p29) -- Line: 161
        -- upvalues: u26 (ref), LinearVelocity (copy), AssemblyLinearVelocity (ref)
        u26 = u26 - p29 * 15;
        LinearVelocity.VectorVelocity = AssemblyLinearVelocity.Unit * u26;
    end);
    local u30 = nil;
    u30 = RunService.Heartbeat:Connect(function(p31) -- Line: 167
        -- upvalues: u6 (copy), u30 (ref), LocalPlayer (ref), u27 (ref), u28 (ref)
        if not u6.FlowstepDash then
            u30:Disconnect();

            return;
        end;

        if not u6.Network.CharValues.HasBall then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = u27;

        if u27 > 0.5 and not u28 then
            p31 = -p31 or p31;
        end;

        u27 = u27 + p31;

        if u27 <= 0.5 then
            u28 = true;
        end;

        if u27 >= 1 then
            u28 = false;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "BURST";
    end);
    u1.Ability:Fire("Flowstep", {
        TimeSent = workspace:GetServerTimeNow(),
        Direction = v25
    });
end;