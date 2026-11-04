  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
game:GetService("PathfindingService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local CameraShaker = require(ReplicatedStorage.Shared.CameraShaker);
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
local Popup = require(ReplicatedStorage.Shared.Popup);
local TeamColors = require(ReplicatedStorage.Shared.TeamColors);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local workspace_CurrentCamera = workspace.CurrentCamera;
tick();
local u2 = {
    Name = "CameraController",
    BlockRotation = false,
    FOVBonus = 0
};
local Mouse = LocalPlayer:GetMouse();
Mouse.Icon = "";
local u5 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p3) -- Line: 37
    -- upvalues: workspace_CurrentCamera (copy)
    local v4 = workspace_CurrentCamera;
    v4.CFrame = v4.CFrame * p3;
end);

function u2.SetShiftlock(u6, p7) -- Line: 41
    -- upvalues: Mouse (copy), LocalPlayer (copy), Humanoid (ref), RunService (copy), HumanoidRootPart (ref), UserInputService (copy)
    local Shiftlock = u6.Shiftlock;
    u6.Shiftlock = p7;

    if u6.Shiftlock then
        if Shiftlock then
            return;
        end;

        Mouse.Icon = "http://www.roblox.com/asset/?id=569021388";
        LocalPlayer.PlayerGui.Misc.Cursor.Visible = true;
        Humanoid.AutoRotate = false;
        RunService:BindToRenderStep("ShiftLock", Enum.RenderPriority.Character.Value, function() -- Line: 54
            -- upvalues: HumanoidRootPart (ref), u6 (copy), LocalPlayer (ref), UserInputService (ref)
            if HumanoidRootPart.AssemblyRootPart ~= HumanoidRootPart then
                return;
            end;

            if u6.Cutscene then
                return;
            end;

            if u6.BlockRotation then
                return;
            end;

            if HumanoidRootPart.Parent:FindFirstChild("EmoteWeld", true) then
                return;
            end;

            if LocalPlayer:GetAttribute("TeamEmoting") then
                return;
            end;

            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
            LocalPlayer.PlayerGui.Misc.CURSOR.Visible = false;
            local _, v8 = workspace.CurrentCamera.CFrame.Rotation:ToEulerAnglesYXZ();
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame:Lerp(CFrame.new(HumanoidRootPart.Position) * CFrame.Angles(0, v8, 0), 0.1);
        end);

        return;
    end;

    LocalPlayer.PlayerGui.Misc.CURSOR.Visible = true;
    LocalPlayer.PlayerGui.Misc.Cursor.Visible = false;
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    Humanoid.AutoRotate = true;
    Mouse.Icon = "";
    RunService:UnbindFromRenderStep("ShiftLock");
end;

function u2.HeadMovement(p9, p10) -- Line: 76
    -- upvalues: u1 (ref), LocalPlayer (copy), Humanoid (ref), HumanoidRootPart (ref)
    if p9.ScoredGoal then
        return;
    end;

    if p9.Cutscene then
        return;
    end;

    if u1 ~= LocalPlayer.Character then
        return;
    end;

    if Humanoid.Health <= 0 then
        return;
    end;

    if p9.BallController.HoldingShoot then
        return;
    end;

    if u1:FindFirstChild("Head") == nil then
        return;
    end;

    local Position = HumanoidRootPart.CFrame:ToObjectSpace(u1.Head.CFrame).Position;
    local Magnitude = Position.Magnitude;

    if Magnitude ~= Magnitude then
        return;
    end;

    if LocalPlayer:FindFirstChild("PlayerStats") and (LocalPlayer.PlayerStats.Style.Value == "Loki" and (p9.StatesController.States.Running and Humanoid.MoveDirection.Magnitude > 0)) then
        Position = Position + Vector3.new(0, 0.75, 0);
    end;

    local v11 = Position * (p9.HeadMovementMultiplier or Vector3.new(1, 1, 1));
    local v12 = 1 - math.pow(0.3, p10 * 5);
    Humanoid.CameraOffset = Humanoid.CameraOffset:Lerp(v11 - Vector3.new(0, 0.1, 0), v12);
end;

function u2.Shake(p13, p14) -- Line: 105
end;

function u2.Shake2(p15, p16) -- Line: 112
    -- upvalues: CameraShaker (copy), u5 (copy)
    if CameraShaker.Presets[p16] then
        u5:Start();
        u5:Shake(CameraShaker.Presets[p16]);
    end;
end;

function u2.KnitStart(u17) -- Line: 119
    -- upvalues: KnitClient (copy), ReplicatedStorage (copy), workspace_CurrentCamera (copy), LocalPlayer (copy), UserInputService (copy), Popup (copy), RunService (copy), Mouse (copy), Players (copy), TeamColors (copy), HumanoidRootPart (ref), u5 (copy), CameraShaker (copy), TweenService (copy), Debris (copy), Humanoid (ref), u1 (ref), u2 (copy)
    u17.GoalService = KnitClient.GetService("GoalService");
    u17.BallController = KnitClient.GetController("BallController");
    u17.EmoteController = KnitClient.GetController("EmoteController");
    u17.SpectatorController = KnitClient.GetController("SpectatorController");
    u17.StatesController = KnitClient.GetController("StatesController");
    u17.WindVfx = ReplicatedStorage.Assets.Vfx.Wind:Clone();
    u17.WindVfx.Parent = workspace_CurrentCamera;
    u17.WindVfx.CFrame = workspace_CurrentCamera.CFrame;
    u17.BaseTrove:Connect(LocalPlayer:GetPropertyChangedSignal("Team"), function() -- Line: 131
        -- upvalues: LocalPlayer (ref), u17 (copy)
        if LocalPlayer.Team == game.Teams.Visitor then
            u17:SetShiftlock(false);

            return;
        end;

        u17:SetShiftlock(true);
    end);
    u17.BaseTrove:Connect(LocalPlayer.PlayerGui:WaitForChild("Mobile"):WaitForChild("NoBall"):WaitForChild("Shiftlock").MouseButton1Click, function() -- Line: 139
        -- upvalues: u17 (copy)
        u17:SetShiftlock(not u17.Shiftlock);
    end);
    u17.BaseTrove:Connect(LocalPlayer.PlayerGui:WaitForChild("Mobile"):WaitForChild("Ball"):WaitForChild("Shiftlock").MouseButton1Click, function() -- Line: 142
        -- upvalues: u17 (copy)
        u17:SetShiftlock(not u17.Shiftlock);
    end);
    u17.BaseTrove:Connect(ReplicatedStorage:WaitForChild("GameValues"):WaitForChild("State"):GetPropertyChangedSignal("Value"), function() -- Line: 146
        -- upvalues: ReplicatedStorage (ref), u17 (copy), LocalPlayer (ref), workspace_CurrentCamera (ref), UserInputService (ref), Popup (ref)
        if ReplicatedStorage.GameValues.State.Value == "StartingCutscene" or ReplicatedStorage.GameValues.State.Value == "Ending" then
            if ReplicatedStorage.GameValues.State.Value == "Ending" then
                if LocalPlayer.Team == game.Teams.Visitor and not u17.SpectatorController.IsSpectating then
                    return;
                end;

                LocalPlayer.PlayerGui.HUD.Enabled = false;
                LocalPlayer.PlayerGui.InGameUI.Enabled = false;
                LocalPlayer.PlayerGui.Spectate.Enabled = false;
                u17.Cutscene = true;
                workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                Popup.BlackoutLocal(LocalPlayer, "End1", "End2");
                Popup.BlackoutLocal(LocalPlayer, "End1", "End2", true);
                local u18 = game:GetService("TweenService"):Create(game.SoundService.SoundGroup.OST, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Volume = 0.3
                });
                u18:Play();
                local u19 = game:GetService("TweenService"):Create(game.SoundService.SoundGroup.Stadium, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Volume = 0
                });
                u19:Play();
                task.delay(ReplicatedStorage.GameValues.EndingDuration.Value - 0.5, function() -- Line: 188
                    -- upvalues: u18 (copy), u19 (copy), Popup (ref), LocalPlayer (ref)
                    u18:Destroy();
                    u19:Destroy();
                    Popup.BlackoutLocal(LocalPlayer, "End5", "End6");
                    Popup.BlackoutLocal(LocalPlayer, "End5", "End6", true);
                end);
            end;
        else
            u17.Cutscene = false;

            if LocalPlayer.PlayerGui.Style.Enabled == false and (LocalPlayer.PlayerGui.Customization.Enabled == false and (LocalPlayer.PlayerGui.Flow.Enabled == false and not (LocalPlayer:GetAttribute("RankedPickPhase") or LocalPlayer:GetAttribute("RankedPostMatch")))) then
                workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

                if LocalPlayer.Team == game.Teams.Visitor and not u17.SpectatorController.IsSpectating then
                    LocalPlayer.PlayerGui.InGameUI.Enabled = false;

                    return;
                end;

                if u17.SpectatorController.IsSpectating then
                    LocalPlayer.PlayerGui.Spectate.Enabled = true;

                    return;
                end;

                if UserInputService.TouchEnabled then
                    LocalPlayer.PlayerGui.Mobile.Enabled = true;
                end;

                LocalPlayer.PlayerGui.HUD.Enabled = false;
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;
        end;
    end);
    local u20 = false;
    local u21 = nil;
    local u22 = nil;
    local u23 = 0;
    local u24 = nil;
    u17.BaseTrove:Connect(RunService.RenderStepped, function(p25) -- Line: 206
        -- upvalues: u17 (copy), workspace_CurrentCamera (ref), u24 (ref), LocalPlayer (ref), RunService (ref), UserInputService (ref), Mouse (ref), ReplicatedStorage (ref), u20 (ref), u22 (ref), Players (ref), u21 (ref), TeamColors (ref), u23 (ref), HumanoidRootPart (ref)
        u17.WindVfx.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -4);

        if not u24 then
            u24 = LocalPlayer:FindFirstChild("PlayerGui");
            local v26 = u24 and u24:FindFirstChild("Misc");
            u24 = v26;
        end;

        if not u24 then
            return;
        end;

        if RunService:IsStudio() then
            u24.CURSOR.Position = UDim2.new(-1000, 0);
            UserInputService.MouseIconEnabled = true;
        else
            u24.CURSOR.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y + 60);
            local CURSOR = u24.CURSOR;
            CURSOR.Rotation = CURSOR.Rotation + 50 * p25;
            UserInputService.MouseIconEnabled = false;
        end;

        if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
            u24.CURSOR.Visible = false;
        end;

        if ReplicatedStorage.Football.Value then
            if ReplicatedStorage.Football.Value.Parent == game.Workspace or not ReplicatedStorage.Football.Value:FindFirstChild("Char") then
                u23 = 0;
                u20 = false;

                if u21 then
                    u21:Destroy();
                end;
            elseif ReplicatedStorage.Football.Value.Char.Value == nil then
                u20 = false;
            else
                if u20 == false or u22 ~= Players:FindFirstChild(ReplicatedStorage.Football.Value.Char.Value.Name) then
                    if u21 then
                        u21:Destroy();
                    end;

                    u22 = Players:FindFirstChild(ReplicatedStorage.Football.Value.Char.Value.Name);
                    u20 = true;
                    u21 = ReplicatedStorage.Assets.Misc.Ring:Clone();
                    u21.Archivable = false;
                    u21.Parent = ReplicatedStorage.Football.Value.Char.Value;
                    u21.CFrame = ReplicatedStorage.Football.Value.Char.Value.HumanoidRootPart.CFrame * CFrame.new(0, -3.1, 0);

                    if u22 then
                        u21.Color = TeamColors[u22.Team.Name][ReplicatedStorage.GameValues[u22.Team.Name .. "Index"].Value];
                    end;
                elseif u21 then
                    local Position = ReplicatedStorage.Football.Value.Char.Value.HumanoidRootPart.Position;
                    u21.CFrame = CFrame.new(Position.X, 8.25, Position.Z) * CFrame.fromEulerAnglesXYZ(0, math.rad(u23), 0);
                    u23 = u23 - 1;
                end;

                if u21 and u21.Parent then
                    if ReplicatedStorage.GameValues.AwakeningCutscene.Value then
                        u21.Transparency = 1;
                    else
                        u21.Transparency = 0;
                    end;
                end;
            end;
        end;

        if ReplicatedStorage.GameValues.State.Value ~= "StartingCutscene" then
            if not LocalPlayer.PlayerGui.PostMatch.Enabled then
                if ReplicatedStorage.GameValues.State.Value == "Ending" then
                    if LocalPlayer.Team == game.Teams.Visitor and not u17.SpectatorController.IsSpectating then
                        return;
                    end;

                    if LocalPlayer.PlayerGui.Style.Enabled then
                        return;
                    end;

                    if LocalPlayer.PlayerGui.Flow.Enabled then
                        return;
                    end;

                    if LocalPlayer.PlayerGui.Customization.Enabled then
                        return;
                    end;

                    if workspace:FindFirstChild("Podium") == nil then
                        return;
                    end;

                    LocalPlayer.PlayerGui.Mobile.Enabled = false;
                    LocalPlayer.PlayerGui.HUD.Enabled = false;
                    LocalPlayer.PlayerGui.InGameUI.Enabled = false;
                    LocalPlayer.PlayerGui.Spectate.Enabled = false;
                    u17.Cutscene = true;
                    workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                    workspace_CurrentCamera.CFrame = workspace.Podium.Cam.camera.CFrame;
                end;

                return;
            end;

            LocalPlayer.PlayerGui.HUD.Enabled = false;
            workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            workspace_CurrentCamera.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0.5, -7) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);

            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor and not u17.SpectatorController.IsSpectating then
            return;
        end;

        if LocalPlayer.PlayerGui.Style.Enabled then
            return;
        end;

        if LocalPlayer.PlayerGui.Flow.Enabled then
            return;
        end;

        if LocalPlayer.PlayerGui.Customization.Enabled then
            return;
        end;

        LocalPlayer.PlayerGui.Mobile.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.InGameUI.Enabled = false;
        LocalPlayer.PlayerGui.Spectate.Enabled = false;
        u17.Cutscene = true;
    end);
    u17.BaseTrove:Connect(UserInputService.InputBegan, function(p27, p28) -- Line: 322
        -- upvalues: LocalPlayer (ref), u17 (copy)
        if p28 then
            return;
        end;

        if LocalPlayer.PlayerGui.Style.Enabled or (LocalPlayer.PlayerGui.Flow.Enabled or LocalPlayer.PlayerGui.Customization.Enabled) then
            return;
        end;

        if p27.KeyCode == Enum.KeyCode.LeftControl or p27.KeyCode == Enum.KeyCode.DPadLeft then
            u17:SetShiftlock(not u17.Shiftlock);
        end;
    end);
    u17.BaseTrove:Connect(u17.GoalService.ScoredGoal, function(u29, u30) -- Line: 330
        -- upvalues: LocalPlayer (ref), u17 (copy), RunService (ref), u5 (ref), CameraShaker (ref), TweenService (ref), Debris (ref), Popup (ref), UserInputService (ref), ReplicatedStorage (ref), Players (ref), workspace_CurrentCamera (ref), HumanoidRootPart (ref), Humanoid (ref)
        print("here");

        if LocalPlayer.Team == game.Teams.Visitor and not u17.SpectatorController.IsSpectating then
            if u30 then
                table.clear(u30);
            end;

            return;
        end;

        local RebellionPlayback = u17.RebellionPlayback;

        while RebellionPlayback and not RebellionPlayback.Finished do
            RunService.Heartbeat:Wait();
        end;

        if LocalPlayer.Team == game.Teams.Visitor and not u17.SpectatorController.IsSpectating then
            if u30 then
                table.clear(u30);
            end;

            return;
        end;

        print("Goal scored here");
        u17.ScoredGoal = true;
        u17.CharOfScored = u29;
        u5:Start();
        u5:Shake(CameraShaker.Presets.Explosion);
        local Blur = game.Lighting:FindFirstChild("Blur");

        if Blur and Blur:IsA("BlurEffect") then
            Blur.Size = 0;
            local v31 = TweenService:Create(Blur, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, true), {
                Size = 10
            });
            v31:Play();
            Debris:AddItem(v31, 1);
        end;

        local Bloom = game.Lighting:FindFirstChild("Bloom");

        if Bloom and Bloom:IsA("BloomEffect") then
            Bloom.Intensity = 0.35;
            Bloom.Threshold = 2;
            local v32 = TweenService:Create(Bloom, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, true), {
                Intensity = 1,
                Threshold = 0.2
            });
            v32:Play();
            Debris:AddItem(v32, 1);
        end;

        local u33 = nil;
        local Shiftlock = u17.Shiftlock;
        u17:SetShiftlock(false);
        task.delay(2.25, function() -- Line: 372
            -- upvalues: Popup (ref), LocalPlayer (ref), u29 (copy), UserInputService (ref), u30 (ref), ReplicatedStorage (ref), RunService (ref), Players (ref), TweenService (ref), Debris (ref), workspace_CurrentCamera (ref), u33 (ref)
            Popup.Blackframe(LocalPlayer);
            task.wait(0.5);
            Popup.BlackoutLocalSemi(LocalPlayer, "Frame1", "Frame2");

            if LocalPlayer.Character == u29 then
                if UserInputService.TouchEnabled then
                    LocalPlayer.PlayerGui.Misc.EmoteTouch.Visible = true;
                elseif UserInputService.GamepadEnabled then
                    LocalPlayer.PlayerGui.Misc.EmotesGamepad.Visible = true;
                else
                    LocalPlayer.PlayerGui.Misc.EmotePc.Visible = true;
                end;
            end;

            LocalPlayer.PlayerGui.InGameUI.Enabled = false;
            LocalPlayer.PlayerGui.Spectate.Enabled = false;
            LocalPlayer.PlayerGui.InGameUI.KeybindsPC.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.KeybindsConsole.Visible = false;
            LocalPlayer.PlayerGui.Mobile.Enabled = false;
            task.spawn(function() -- Line: 424
                -- upvalues: u30 (ref), LocalPlayer (ref), ReplicatedStorage (ref), RunService (ref), Players (ref), TweenService (ref), Debris (ref)
                if u30 then
                    if LocalPlayer.PlayerGui.Misc:FindFirstChild("Card") then
                        LocalPlayer.PlayerGui.Misc.Card:Destroy();
                    end;

                    local u34 = ReplicatedStorage.Assets.Customization.Cards[u30.Card]:Clone();
                    u34.Parent = LocalPlayer.PlayerGui.Misc;
                    u34.Name = "Card";

                    if ReplicatedStorage.Assets.Customization.Cards[u30.Card]:GetAttribute("Rainbow") then
                        local u35 = nil;
                        u35 = RunService.RenderStepped:Connect(function() -- Line: 435
                            -- upvalues: u34 (copy), u35 (ref)
                            if not u34 then
                                u35:Disconnect();

                                return;
                            end;

                            local v36 = tick() % 10 / 10;
                            u34.ImageColor3 = Color3.fromHSV(v36, 0.8, 1);
                        end);
                    end;

                    task.spawn(function() -- Line: 446
                        -- upvalues: Players (ref), u30 (ref), LocalPlayer (ref)
                        local UserThumbnailAsync = Players:GetUserThumbnailAsync(u30.Plr.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420);
                        LocalPlayer.PlayerGui.Misc.Card.PlayerProfile.Image = UserThumbnailAsync;
                    end);
                    LocalPlayer.PlayerGui.Misc.Card.Pos.Text = u30.Pos;
                    LocalPlayer.PlayerGui.Misc.Card.Goals.Text = tostring(u30.Goals);
                    LocalPlayer.PlayerGui.Misc.Card.Assists.Text = tostring(u30.Assists);
                    LocalPlayer.PlayerGui.Misc.Card.Saves.Text = tostring(u30.Saves);
                    LocalPlayer.PlayerGui.Misc.Card.Plr.Text = u30.Plr.Name;
                    LocalPlayer.PlayerGui.Misc.Card.OVR.Text = tostring(u30.OVR);
                end;

                LocalPlayer.PlayerGui.Misc.Card.Position = UDim2.new(-0.5, 0, 0.5, 0);
                LocalPlayer.PlayerGui.Misc.Card.Visible = true;
                local v37 = TweenService:Create(LocalPlayer.PlayerGui.Misc.Card, TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.13, 0, 0.5, 0)
                });
                v37:Play();
                Debris:AddItem(v37, 0.25);
                local Children = LocalPlayer.PlayerGui.Misc.Card:GetChildren();

                for _, v in pairs(Children) do
                    if v:IsA("TextLabel") then
                        v.TextColor3 = Color3.new(0, 0, 0);
                        local v38 = TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            TextColor3 = Color3.new(1, 1, 1)
                        });
                        v38:Play();
                        Debris:AddItem(v38, 0.5);
                    elseif v:IsA("ImageLabel") then
                        v.ImageColor3 = Color3.new(0, 0, 0);
                        local v39 = TweenService:Create(v, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            ImageColor3 = Color3.new(1, 1, 1)
                        });
                        v39:Play();
                        Debris:AddItem(v39, 0.5);
                    end;
                end;

                table.clear(Children);
            end);
            workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            local _ = game.Workspace.CurrentCamera.FieldOfView;
            u33 = RunService.RenderStepped:Connect(function(p40) -- Line: 496
                -- upvalues: u29 (ref), LocalPlayer (ref), workspace_CurrentCamera (ref)
                if u29 == nil then
                    return;
                end;

                if u29:FindFirstChild("HumanoidRootPart") == nil then
                    return;
                end;

                if not u29:GetAttribute("EmoteCutscene") then
                    workspace_CurrentCamera.CFrame = u29.HumanoidRootPart.CFrame * CFrame.new(0, 0, -u29.HumanoidRootPart.Size.X * 3.5) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);

                    return;
                end;

                LocalPlayer.PlayerGui.Misc.Card.Visible = false;
                LocalPlayer.PlayerGui.Misc.EmoteTouch.Visible = false;
                LocalPlayer.PlayerGui.Misc.EmotesGamepad.Visible = false;
                LocalPlayer.PlayerGui.Misc.EmotePc.Visible = false;
            end);
        end);
        task.wait(6);
        local v41 = u29 and (not u29:GetAttribute("EmoteCancelled") and (u29:GetAttribute("LastCutsceneEmote") or 0) + 6 > workspace:GetServerTimeNow()) and 9 or 1;
        task.wait(v41);
        Popup.BlackoutLocal(LocalPlayer, "FrameClose", "FrameClose2");
        Popup.BlackoutLocal(LocalPlayer, "FrameClose", "FrameClose2", true);
        task.wait(0.5);
        LocalPlayer.PlayerGui.Misc.EmoteTouch.Visible = false;
        LocalPlayer.PlayerGui.Misc.EmotePc.Visible = false;
        LocalPlayer.PlayerGui.Misc.EmotesGamepad.Visible = false;

        if LocalPlayer.Team ~= game.Teams.Visitor then
            LocalPlayer.PlayerGui.InGameUI.Enabled = true;
        end;

        if u17.SpectatorController.IsSpectating then
            LocalPlayer.PlayerGui.Spectate.Enabled = true;
        end;

        Popup.BlackoutLocalSemi(LocalPlayer, "Frame1", "Frame2", true);
        task.wait(0.5);
        u5:Stop();
        u17.ScoredGoal = false;
        u17.CharOfScored = nil;

        if u33 then
            u33:Disconnect();
        end;

        workspace_CurrentCamera.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2, -5);
        workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;
        workspace_CurrentCamera.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2, -5);

        if UserInputService.KeyboardEnabled then
            LocalPlayer.PlayerGui.InGameUI.KeybindsPC.Visible = true;
            LocalPlayer.PlayerGui.InGameUI.KeybindsConsole.Visible = false;
            LocalPlayer.PlayerGui.Mobile.Enabled = false;
        elseif UserInputService.GamepadEnabled then
            LocalPlayer.PlayerGui.InGameUI.KeybindsPC.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.KeybindsConsole.Visible = true;
            LocalPlayer.PlayerGui.Mobile.Enabled = false;
        elseif UserInputService.TouchEnabled then
            LocalPlayer.PlayerGui.InGameUI.KeybindsPC.Visible = false;
            LocalPlayer.PlayerGui.InGameUI.KeybindsConsole.Visible = false;
            LocalPlayer.PlayerGui.Mobile.Enabled = true;
        end;

        LocalPlayer.PlayerGui.Misc.Card.Visible = false;
        LocalPlayer.PlayerGui.EmoteWheel.Enabled = false;
        task.spawn(function() -- Line: 582
        end);

        if u30 then
            table.clear(u30);
            u30 = nil;
        end;

        task.delay(0.5, function() -- Line: 591
            -- upvalues: workspace_CurrentCamera (ref), HumanoidRootPart (ref), u17 (ref), Shiftlock (copy)
            workspace_CurrentCamera.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2, -5);
            u17:SetShiftlock(Shiftlock);
        end);

        if u17.SpectatorController.IsSpectating then
            u17.SpectatorController:Spectate(u17.SpectatorController.SpectatingTarget);
        else
            workspace_CurrentCamera.CameraSubject = Humanoid;
        end;
    end);
    u17.BaseTrove:Connect(RunService.RenderStepped, function(p42) -- Line: 604
        -- upvalues: u17 (copy), LocalPlayer (ref), UserInputService (ref), u1 (ref), HumanoidRootPart (ref), workspace_CurrentCamera (ref), Humanoid (ref), u2 (ref), TweenService (ref), Debris (ref)
        if u17.Cutscene then
            u17:CancelFOVTween();
        end;

        if u17.Cutscene and not LocalPlayer:GetAttribute("ForceCursor") then
            if UserInputService.MouseIconEnabled then
                UserInputService.MouseIconEnabled = false;
            end;

            LocalPlayer.PlayerGui.Misc.Cursor.Visible = false;
            LocalPlayer.PlayerGui.Misc.CURSOR.Visible = false;

            return;
        end;

        UserInputService.MouseIconEnabled = true;

        if u17.Shiftlock then
            LocalPlayer.PlayerGui.Misc.Cursor.Visible = true;
            LocalPlayer.PlayerGui.Misc.CURSOR.Visible = false;
        else
            LocalPlayer.PlayerGui.Misc.Cursor.Visible = false;
            LocalPlayer.PlayerGui.Misc.CURSOR.Visible = true;
        end;

        if u17.Cutscene and LocalPlayer:GetAttribute("ForceCursor") then
            return;
        end;

        if u1:FindFirstChild("Values") == nil then
            return;
        end;

        u17:HeadMovement(p42);
        local Magnitude = (HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude;

        if u1:FindFirstChild("newTraject") then
            u1.newTraject.CanCollide = false;
            u1.newTraject.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + workspace_CurrentCamera.CFrame.LookVector * 10) * CFrame.new(0, 0, -10);
        end;

        local v43 = 55 + Humanoid.WalkSpeed;

        if u1.Values.Sliding.Value then
            u17.WindVfx.Attachment.vfx.Rate = 150;
            u17.WindVfx.Attachment.vfx.Acceleration = Vector3.new(0, 0, 30);
            u17.WindVfx.Attachment.vfx.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255));
        else
            u17.WindVfx.Attachment.vfx.Rate = (HumanoidRootPart.AssemblyLinearVelocity.Magnitude - 22) * 3;
            u17.WindVfx.Attachment.vfx.Acceleration = Vector3.new(0, 0, (HumanoidRootPart.AssemblyLinearVelocity.Magnitude - 16) * 4);

            if LocalPlayer:FindFirstChild("PlayerStats") and LocalPlayer:FindFirstChild("PlayerStats").Style.Value == "Loki" then
                local math_map_ret = math.map(Magnitude, 30, 37.5, 0, 1);
                local math_clamp_ret = math.clamp(math_map_ret, 0, 1);
                u17.WindVfx.Attachment.vfx.Color = ColorSequence.new(Color3.new(1, 1, 1):Lerp(Color3.fromRGB(255, 89, 12), math_clamp_ret), Color3.new(1, 1, 1):Lerp(Color3.fromRGB(70, 26, 14), math_clamp_ret));
                local vfx = u17.WindVfx.Attachment.vfx;
                vfx.Rate = vfx.Rate + math_clamp_ret * 30;
                v43 = v43 + math_clamp_ret * 20;
            else
                u17.WindVfx.Attachment.vfx.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255));
            end;
        end;

        local v44 = v43 + u2.FOVBonus;
        u17:CancelFOVTween();
        local v45 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
            FieldOfView = v44
        });
        u17._fovTween = v45;
        v45:Play();
        Debris:AddItem(v45, 0.3);
    end);
end;

function u2.CancelFOVTween(p46) -- Line: 687
    local _fovTween = p46._fovTween;

    if not _fovTween then
        return;
    end;

    p46._fovTween = nil;
    pcall(function() -- Line: 694
        -- upvalues: _fovTween (copy)
        _fovTween:Cancel();
    end);
end;

function u2.BeginCutscene(p47) -- Line: 699
    p47.Cutscene = true;
    p47:CancelFOVTween();
end;

function u2.EndCutscene(p48) -- Line: 704
    p48:CancelFOVTween();
    p48.Cutscene = false;
end;

function u2.KnitInit(u49) -- Line: 709
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
    u49.BaseTrove = Trove.new();
    u49.Shiftlock = false;
    u49.Cutscene = false;
    u49._fovTween = nil;
    u49.HeadMovementMultiplier = Vector3.new(1, 1, 1);
    u49.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p50) -- Line: 716
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
        u1 = p50;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u49.BaseTrove:Connect(game.Players.PlayerRemoving, function(p51) -- Line: 723
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), Humanoid (ref), u49 (copy)
        if p51 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u49.BaseTrove:Destroy();
        end;
    end);
end;

return KnitClient.CreateController(u2);