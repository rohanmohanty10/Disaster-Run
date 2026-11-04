 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Zones = require(ReplicatedStorage.Shared.Tables.Zones);
local LocalPlayer = game.Players.LocalPlayer;
local Attribute = LocalPlayer:GetAttribute("Focused");
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Head = u1:WaitForChild("Head");
local workspace_CurrentCamera = workspace.CurrentCamera;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = Knit.CreateController({
    Name = "CameraController",
    FOVActive = true
});
LocalPlayer:GetMouse().Icon = "";
local Visitor = game.Teams.Visitor;
local u8 = nil;
local u9 = nil;
local u10 = false;
local u11 = 70;

function u7.Lerp(p12, p13, p14, p15, p16) -- Line: 49
    return p16 > 0.008333333333333333 and p13:Lerp(p14, 1 - (1 - p15) ^ (p16 / math.min(p16, 0.008333333333333333))) or p13:Lerp(p14, p15);
end;

function u7.SetShiftlock(u17, p18, p19) -- Line: 53
    -- upvalues: UserInputService (copy), Humanoid (ref), LocalPlayer (copy), RunService (copy), workspace_CurrentCamera (copy), u5 (ref), u6 (ref), HumanoidRootPart (ref), u2 (ref), Zones (copy), ReplicatedStorage (copy)
    u17.Shiftlock = p18;
    u17.LockOn = p19;

    if not (u17.Shiftlock or u17.LockOn) then
        LocalPlayer.PlayerGui.Misc.Center.Visible = false;
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        Humanoid.AutoRotate = true;
        UserInputService.MouseIconEnabled = true;
        RunService:UnbindFromRenderStep("ShiftLock");

        return;
    end;

    UserInputService.MouseIconEnabled = false;
    Humanoid.AutoRotate = false;
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
    LocalPlayer.PlayerGui.Misc.Center.Visible = true;
    task.wait();
    RunService:UnbindFromRenderStep("ShiftLock");
    RunService:BindToRenderStep("ShiftLock", Enum.RenderPriority.Character.Value, function(p20) -- Line: 65
        -- upvalues: workspace_CurrentCamera (ref), u5 (ref), u17 (copy), UserInputService (ref), LocalPlayer (ref), u6 (ref), HumanoidRootPart (ref), u2 (ref), Zones (ref), ReplicatedStorage (ref)
        if workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            return;
        end;

        if u5.CharValues.HasBall then
            u17.LockOn = false;
        end;

        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
        local Attribute2 = LocalPlayer:GetAttribute("SlightBuff");
        local PlayerPossessingBall = u6:GetPlayerPossessingBall();

        if not u17.LockOn or PlayerPossessingBall and workspace.Debris:FindFirstChild("CutTheLights") then
            if u2.States.Dunking ~= false or (u2.States.NoWalk ~= false or (u2.States.Shooting ~= false or u2.States.AimAssist ~= false)) then
                if (u2.States.Shooting or u2.States.AimAssist) and not u2.States.Stunned then
                    local Hoop = workspace.Hoops[LocalPlayer.Team.Name].Hoop;
                    local Vector3_new_ret = Vector3.new(HumanoidRootPart.Position.X, 0, HumanoidRootPart.Position.Z);
                    local Vector3_new_ret2 = Vector3.new(Hoop.Position.X, 0, Hoop.Position.Z);
                    local Magnitude = (Vector3_new_ret - Vector3_new_ret2).Magnitude;
                    local v21 = HumanoidRootPart.Position + Vector3.new(HumanoidRootPart.CFrame.LookVector.X, 0, HumanoidRootPart.CFrame.LookVector.Z) * Magnitude;
                    local Magnitude2 = (Vector3.new(v21.X, Hoop.Position.Y, v21.Z) - Hoop.Position).Magnitude;
                    local v22 = not (Zones.DistBuffZones[LocalPlayer.Zone.Value] and (Magnitude < Zones.DistBuffZones[LocalPlayer.Zone.Value] and u5.CharValues.InZone)) and 100 or Zones.DistBuffZones[LocalPlayer.Zone.Value];
                    local v23;

                    if Zones.AssistBuffZones[LocalPlayer.Zone.Value] and u5.CharValues.InZone then
                        v23 = Zones.AssistBuffZones[LocalPlayer.Zone.Value];

                        if u5.CharValues.ScaryJump > workspace:GetServerTimeNow() then
                            v23 = v23 * 2;
                        end;
                    else
                        v23 = 26;
                    end;

                    if u5.CharValues.InZone and (LocalPlayer.Zone.Value == "777" and (u5.CharValues.ZoneRNG == 2 or u5.CharValues.ZoneRNG == 3) or LocalPlayer.Zone.Value == "Wildcard" and u5.CharValues.ZoneRNG == 1) then
                        v22 = v22 + 35;
                        v23 = v23 + 4.5;
                    end;

                    if u5.Player.Statistics.Matches < 3 then
                        v23 = v23 + 1.5;
                        v22 = v22 + 7;
                    end;

                    if workspace:GetAttribute("NoAimAssist") or (u5.Gamemode == "Match-2v2" or u5.Gamemode == "Match-1v1") then
                        v23 = v23 / 1.7;
                        v22 = v22 / 1.5;
                    end;

                    if ReplicatedStorage.Controllers.Device.Value == "Mobile" or ReplicatedStorage.Controllers.Device.Value == "Console" then
                        v23 = v23 + 5;
                        v22 = v22 + 7;
                    end;

                    local v24 = v23 * ReplicatedStorage.GameTweaks:GetAttribute("AimAssistMultiplier");

                    if LocalPlayer.Zone.Value == "Wildcard" and (u5.CharValues.InZone and (u5.CharValues.ZoneRNG == 1 and math.abs(Vector3_new_ret.X - Vector3_new_ret2.X) <= 145)) or Magnitude <= v22 and Magnitude2 <= v24 then
                        if Attribute2 then
                            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z)));
                            workspace_CurrentCamera.CFrame = CFrame.new(workspace_CurrentCamera.CFrame.Position, (Vector3.new(Hoop.Position.X, workspace_CurrentCamera.CFrame.Position.Y, Hoop.Position.Z)));

                            return;
                        end;

                        HumanoidRootPart.CFrame = u17:Lerp(HumanoidRootPart.CFrame, CFrame.new(HumanoidRootPart.Position, (Vector3.new(Hoop.Position.X, HumanoidRootPart.Position.Y, Hoop.Position.Z))), 0.12, p20);
                        workspace_CurrentCamera.CFrame = u17:Lerp(workspace_CurrentCamera.CFrame, CFrame.new(workspace_CurrentCamera.CFrame.Position, (Vector3.new(Hoop.Position.X, workspace_CurrentCamera.CFrame.Position.Y, Hoop.Position.Z))), 0.03, p20);

                        return;
                    end;

                    local _, v25 = workspace.CurrentCamera.CFrame.Rotation:ToEulerAnglesYXZ();

                    if Attribute2 then
                        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0, v25, 0);

                        return;
                    end;

                    HumanoidRootPart.CFrame = u17:Lerp(HumanoidRootPart.CFrame, CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0, v25, 0), 0.1, p20);
                end;

                return;
            end;

            local _, v26 = workspace.CurrentCamera.CFrame.Rotation:ToEulerAnglesYXZ();

            if Attribute2 then
                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0, v26, 0);

                return;
            end;

            HumanoidRootPart.CFrame = u17:Lerp(HumanoidRootPart.CFrame, CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0, v26, 0), 0.1, p20);

            return;
        end;

        local ServerBallPosition = u6:GetServerBallPosition();

        if (ServerBallPosition - HumanoidRootPart.Position).Magnitude == 0 then
            return;
        end;

        local v27 = nil;
        local v28 = nil;

        for _, child in workspace.Debris:GetChildren() do
            if child:GetAttribute("Clone") then
                local Magnitude = (child.Position - HumanoidRootPart.Position).Magnitude;

                if Magnitude < (ServerBallPosition - HumanoidRootPart.Position).Magnitude and (not v27 or v27 < Magnitude) then
                    v28 = child;
                    v27 = Magnitude;
                end;
            end;
        end;

        if v28 then
            ServerBallPosition = v28.Position;
        end;

        local Vector3_new_ret = Vector3.new(ServerBallPosition.X, ServerBallPosition.Y > HumanoidRootPart.Position.Y and ServerBallPosition.Y or HumanoidRootPart.Position.Y, ServerBallPosition.Z);
        HumanoidRootPart.CFrame = u17:Lerp(HumanoidRootPart.CFrame, CFrame.lookAt(HumanoidRootPart.Position, (Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z))), 0.1, p20);
        workspace_CurrentCamera.CFrame = u17:Lerp(workspace_CurrentCamera.CFrame, CFrame.lookAt((HumanoidRootPart.CFrame * CFrame.new(0, 4, 12)).Position, Vector3_new_ret), 1, p20);
    end);
end;

function u7.HeadMovement(p29, p30, p31) -- Line: 186
    -- upvalues: u8 (ref), workspace_CurrentCamera (copy), Head (ref), HumanoidRootPart (ref), u2 (ref), Humanoid (ref)
    if not (p31 or u8.Enabled) then
        local _ = workspace_CurrentCamera.CameraSubject == Head;
    end;

    local v32 = HumanoidRootPart.CFrame:ToObjectSpace(Head.CFrame);

    if u2.States.Shooting then
        Humanoid.CameraOffset = Humanoid.CameraOffset:Lerp(v32.Position + Vector3.new(0, 0.25, 0), p30 * 25);

        return;
    end;

    Humanoid.CameraOffset = Humanoid.CameraOffset:Lerp(v32.Position + Vector3.new(0, 0.15, 0), p30 * 15);
end;

function u7.FOV(p33, p34, p35) -- Line: 202
    -- upvalues: Attribute (ref), workspace_CurrentCamera (copy), u2 (ref), u7 (copy), u11 (ref), HumanoidRootPart (ref), Humanoid (ref), Essentials (copy)
    if Attribute then
        return;
    end;

    if p35 and (workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable or (u2.States.Ability or u7.FOVActive ~= true)) then
        u11 = workspace_CurrentCamera.FieldOfView;

        return;
    end;

    local v36;

    if p35 then
        local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity;
        local Vector3_new_ret = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z);
        local WalkSpeed = Humanoid.WalkSpeed;
        local v37 = Vector3_new_ret:Dot(Vector3_new_ret) < 324 and 18 or WalkSpeed;
        v36 = u2.States.Shooting and 10 or (u2.States.Dunking and 0 or (WalkSpeed <= 0 and 0 or (u2.States.Defense and 15 or v37)));
    else
        v36 = 18;
    end;

    local v38 = u11;
    u11 = Essentials:Lerp(u11, v36 * 1.32 + 40, p34 * 3);

    if u11 ~= v38 then
        workspace_CurrentCamera.FieldOfView = u11;
    end;
end;

function u7.Input(u39) -- Line: 242
    -- upvalues: LocalPlayer (copy), UserInputService (copy)
    for _, descendant in LocalPlayer.PlayerGui.Mobile:GetDescendants() do
        if descendant:IsA("ImageButton") ~= false then
            descendant.MouseButton1Click:Connect(function() -- Line: 247
                -- upvalues: descendant (copy), u39 (copy)
                if descendant.Name == "Shiftlock" then
                    u39:SetShiftlock(not u39.Shiftlock);
                end;

                if descendant.Name == "Lock" then
                    u39:SetShiftlock(u39.Shiftlock, not u39.LockOn);
                end;
            end);
        end;
    end;

    UserInputService.InputBegan:Connect(function(p40, p41) -- Line: 257
        -- upvalues: u39 (copy)
        if p41 then
            return;
        end;

        if p40.KeyCode == Enum.KeyCode.LeftControl or p40.KeyCode == Enum.KeyCode.ButtonL3 then
            u39:SetShiftlock(not u39.Shiftlock);
        end;
    end);
end;

function u7.PlayCutscene(u42, p43, u44, u45) -- Line: 266
    -- upvalues: Effects (copy), u2 (ref), u3 (ref), LocalPlayer (copy), RunService (copy), u10 (ref), workspace_CurrentCamera (copy)
    u45:Clean();
    Effects:Blackbars("Spawn", "Cutscene");
    workspace.CitySounds.Crowd.Volume = 0;
    workspace.CitySounds["City Day Ambience 2 (SFX)"].Volume = 0;
    local workspace_CurrentCamera2 = workspace.CurrentCamera;
    local _ = workspace_CurrentCamera2.CFrame;
    workspace_CurrentCamera2.CameraType = Enum.CameraType.Scriptable;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u3:StopAll();
    local u46 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if u46 then
        task.spawn(function() -- Line: 286
            -- upvalues: RunService (ref), u46 (copy), u44 (copy)
            RunService.Heartbeat:Wait();
            u46.Anchored = true;

            if u44 then
                u46.CFrame = u44;
            end;
        end);
    end;

    local u47 = workspace_CurrentCamera2.CameraSubject == LocalPlayer.Character.Humanoid;
    u10 = u10 or u42.Shiftlock;
    u42:SetShiftlock(false);

    local function End() -- Line: 300
        -- upvalues: Effects (ref), u2 (ref), u46 (copy), LocalPlayer (ref), workspace_CurrentCamera2 (copy), u47 (copy), workspace_CurrentCamera (ref), u42 (copy), u10 (ref)
        Effects:Blackbars("Back", "Cutscene");
        workspace.CitySounds.Crowd.Volume = 0.5;
        workspace.CitySounds["City Day Ambience 2 (SFX)"].Volume = 0.1;
        u2.States.Ability = false;
        u2.States.NoWalk = false;

        if u46 then
            u46.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            u46.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
            u46.Anchored = false;
        end;

        while not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) do
            task.wait(0.01);
        end;

        local CameraSubject = workspace_CurrentCamera2.CameraSubject;

        if CameraSubject:IsA("Humanoid") then
            CameraSubject = CameraSubject.Parent;
        end;

        workspace_CurrentCamera2.CFrame = CameraSubject:GetPivot();
        workspace_CurrentCamera2.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera2.FieldOfView = 70;

        if u47 then
            workspace_CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid;
        end;

        u42:SetShiftlock(u10);
        u10 = false;
    end;

    local u48 = tick();
    local u49 = p43 or 12;
    u45:Add(End);
    u45:Connect(RunService.RenderStepped, function() -- Line: 343
        -- upvalues: u48 (copy), u49 (ref), u45 (copy), workspace_CurrentCamera2 (copy)
        local CamRig = workspace:FindFirstChild("CamRig");

        if u48 + u49 < tick() then
            u45:Clean();

            return;
        end;

        if CamRig == nil then
            u45:Clean();

            return;
        end;

        if CamRig:FindFirstChild("camera") == nil then
            return;
        end;

        workspace_CurrentCamera2.CFrame = CamRig.camera.CFrame;
    end);
end;

function u7.Cutscenes(p50) -- Line: 353
    -- upvalues: Trove (copy), u4 (ref), u2 (ref), LocalPlayer (copy), u7 (copy)
    local u51 = Trove.new();
    local _ = workspace.CurrentCamera;
    u4.Cutscene:Connect(function(p52, p53, p54) -- Line: 357
        -- upvalues: u2 (ref), LocalPlayer (ref), u7 (ref), u51 (copy)
        local v55 = tick();
        local v56 = 12;

        if p52 and typeof(p52) == "Instance" then
            v56 = p52.Style.Value == "Goat" and 9 or (p52.Style.Value == "Sniper" and 10 or (p52.Style.Value == "Star" and 7 or (p52.Style.Value == "Phantom" and 7 or v56)));
        end;

        u2.States.Ability = true;

        while v55 + (p53 or v56) > tick() and (LocalPlayer.Team == game.Teams.Visitor and not LocalPlayer.PlayerGui.Spectate.Enabled) do
            task.wait();
        end;

        while LocalPlayer.PlayerGui.PickTeam.Enabled do
            task.wait();
        end;

        if LocalPlayer.Team == game.Teams.Visitor and not LocalPlayer.PlayerGui.Spectate.Enabled or LocalPlayer.PlayerGui.PickTeam.Enabled then
            u2.States.Ability = false;

            return;
        end;

        u7:PlayCutscene(p53, p54, u51);
    end);
end;

function u7.KnitStart(u57) -- Line: 387
    -- upvalues: Knit (copy), u2 (ref), u3 (ref), u6 (ref), u5 (ref), u4 (ref), u8 (ref), LocalPlayer (copy), u9 (ref), RunService (copy), u1 (ref), Humanoid (ref), Visitor (copy), workspace_CurrentCamera (copy), Head (ref), CameraShaker (copy), ReplicatedStorage (copy), u10 (ref), HumanoidRootPart (ref), Attribute (ref)
    Knit.GetController("TelevisionCameraController");
    u2 = Knit.GetController("MovementController");
    u3 = Knit.GetController("AnimationController");
    u6 = Knit.GetController("BallController");
    u5 = Knit.GetController("Network");
    u4 = Knit.GetService("AbilityService");
    local Service = Knit.GetService("ScoreService");
    u8 = LocalPlayer.PlayerGui.Spectate;
    u9 = LocalPlayer.PlayerGui.PickTeam;
    RunService.Heartbeat:Connect(function(p58) -- Line: 402
        -- upvalues: u1 (ref), LocalPlayer (ref), Humanoid (ref), u9 (ref), Visitor (ref), u8 (ref), workspace_CurrentCamera (ref), Head (ref), u57 (copy)
        if u1 ~= LocalPlayer.Character then
            return;
        end;

        if Humanoid.Health <= 0 then
            return;
        end;

        if u9.Enabled then
            return;
        end;

        local math_min_ret = math.min(p58, 0.03333333333333333);
        local v59 = LocalPlayer.Team ~= Visitor;

        if not (v59 or u8.Enabled) then
            local _ = workspace_CurrentCamera.CameraSubject == Head;
        end;

        u57:HeadMovement(math_min_ret, v59);
        u57:FOV(math_min_ret, v59);
    end);
    local CFrame2 = workspace_CurrentCamera.CFrame;
    u57.CamShake = CameraShaker.new(Enum.RenderPriority.Last.Value, function(p60) -- Line: 420
        -- upvalues: CFrame2 (ref), LocalPlayer (ref), workspace_CurrentCamera (ref), u57 (copy)
        CFrame2 = nil;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            return;
        end;

        CFrame2 = workspace_CurrentCamera.CFrame;
        local v61 = workspace_CurrentCamera;
        v61.CFrame = v61.CFrame * p60;
        u57.ShakeCF = p60;
    end);
    RunService.Heartbeat:Connect(function() -- Line: 432
        -- upvalues: CFrame2 (ref), workspace_CurrentCamera (ref)
        if CFrame2 then
            workspace_CurrentCamera.CFrame = CFrame2;
        end;
    end);
    u57.CamShake:Start();
    Service.Scored:Connect(function(p62) -- Line: 444
        -- upvalues: ReplicatedStorage (ref), LocalPlayer (ref), u5 (ref)
        if ReplicatedStorage.Controllers.Device.Value == "Mobile" then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if p62 == LocalPlayer then
            if not u5.Player.Customization.Settings.EmotePopup then
                return;
            end;

            if ReplicatedStorage.Controllers.Device.Value == "Console" then
                LocalPlayer.PlayerGui.Misc.Emote.Text = "PRESS D-PAD LEFT TO EMOTE";
            else
                LocalPlayer.PlayerGui.Misc.Emote.Text = "PRESS X TO EMOTE";
            end;

            LocalPlayer.PlayerGui.Misc.Emote.Visible = true;
            task.wait(2.8);
            LocalPlayer.PlayerGui.Misc.Emote.Visible = false;
        end;
    end);
    ReplicatedStorage.GameValues.Scoring:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 462
        -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), u10 (ref), u57 (copy), workspace_CurrentCamera (ref), HumanoidRootPart (ref)
        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            return;
        end;

        if ReplicatedStorage.GameValues.Scoring.Value then
            u10 = u10 or u57.Shiftlock;
            task.wait(2.7);
            u57:SetShiftlock(false);

            return;
        end;

        for i = 1, 2 do
            task.wait();
            workspace_CurrentCamera.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 3, 6);
            local _ = i;
        end;

        u57:SetShiftlock(u10);
        u10 = false;
    end);
    ReplicatedStorage.GameValues.PositionReset:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 479
        -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), u10 (ref), u57 (copy), workspace_CurrentCamera (ref), HumanoidRootPart (ref)
        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if ReplicatedStorage.GameValues.PositionReset.Value then
            u10 = u10 or u57.Shiftlock;
            u57:SetShiftlock(false);

            return;
        end;

        for i = 1, 2 do
            task.wait();
            workspace_CurrentCamera.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 3, 6);
            local _ = i;
        end;

        u57:SetShiftlock(u10);
        u10 = false;
    end);
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 494
        -- upvalues: LocalPlayer (ref), u57 (copy)
        if LocalPlayer.Team == game.Teams.Visitor then
            u57:SetShiftlock(false);

            return;
        end;

        u57:SetShiftlock(true);
    end);
    LocalPlayer:GetAttributeChangedSignal("Focused"):Connect(function() -- Line: 502
        -- upvalues: Attribute (ref), LocalPlayer (ref)
        Attribute = LocalPlayer:GetAttribute("Focused");
    end);
    u57:Input();
    u57:Cutscenes();
end;

function u7.KnitInit(u63) -- Line: 510
    -- upvalues: LocalPlayer (copy), u1 (ref), Humanoid (ref), HumanoidRootPart (ref), Head (ref)
    u63.Shiftlock = false;
    u63.LockOn = false;
    LocalPlayer.CharacterAdded:Connect(function(p64) -- Line: 514
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref), Head (ref), u63 (copy)
        u1 = p64;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
        Head = u1:WaitForChild("Head");
        u63:SetShiftlock(false);
        u63:SetShiftlock(true);
        u63:SetShiftlock(false);
    end);
end;

return u7;