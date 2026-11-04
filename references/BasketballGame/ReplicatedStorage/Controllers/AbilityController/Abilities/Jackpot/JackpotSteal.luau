 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

local function JackpotUI(u6) -- Line: 20
    -- upvalues: SfxManager (copy), ReplicatedStorage (copy), LocalPlayer (copy), TweenService (copy)
    SfxManager:playSound({
        Sound = "JackpotSFX",
        Parent = workspace
    });
    local JackpotAssets = ReplicatedStorage.Assets.UI.JackpotAssets;
    local u7 = JackpotAssets.Jackpot:Clone();
    u7.Parent = LocalPlayer.PlayerGui;
    local CanvasGroup = u7.Main.CanvasGroup;
    local Children = JackpotAssets.JackpotFrames:GetChildren();
    local UIScale = CanvasGroup.UIScale;
    UIScale.Scale = 1.6;
    TweenService:Create(UIScale, TweenInfo.new(0.3), {
        Scale = 1.5
    }):Play();
    task.delay(0.3, function() -- Line: 43
        -- upvalues: TweenService (ref), UIScale (copy)
        TweenService:Create(UIScale, TweenInfo.new(0.2), {
            Scale = 1.3
        }):Play();
        task.wait(0.3);
        TweenService:Create(UIScale, TweenInfo.new(0.2), {
            Scale = 1.1
        }):Play();
    end);
    local u8 = { "Stun", "Dash", "Pass" };

    for i = 1, 3 do
        local JackpotFrameM = CanvasGroup.JackpotFrameM;

        if i == 1 then
            JackpotFrameM = CanvasGroup.JackpotFrameL;
        elseif i == 2 then
            JackpotFrameM = CanvasGroup.JackpotFrameR;
        end;

        task.spawn(function() -- Line: 58
            -- upvalues: i (copy), u6 (copy), Children (copy), JackpotFrameM (ref), TweenService (ref), u8 (copy), CanvasGroup (copy), JackpotAssets (copy)
            local v9 = tick();
            local v10 = 0;

            while v10 < (i == 3 and 3 or 6) or u6.Rng == nil and (not u6.Done and tick() - v9 < 3) do
                v10 = v10 + 1;
                local v11 = Children[math.random(1, #Children)]:Clone();
                v11.Parent = JackpotFrameM;
                v11.Position = UDim2.fromScale(0.5, -1.5);
                v11.ImageColor3 = Color3.fromRGB(206, 206, 206);
                v11.UIScale.Scale = 0.9;
                local v12 = TweenService:Create(v11, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                    Position = UDim2.fromScale(0.5, 1.5)
                });
                v12:Play();
                v12.Completed:Wait();
                v11:Destroy();
            end;

            local v13 = u8[u6.Rng];

            if v13 == nil then
                TweenService:Create(CanvasGroup, TweenInfo.new(0.3), {
                    GroupTransparency = 1
                }):Play();

                return;
            end;

            local u14 = JackpotAssets.BackDrop:Clone();
            u14.Parent = JackpotFrameM;
            u14.ImageTransparency = 1;
            u14.UIScale.Scale = 1.1;
            local Size = u14.Size;
            TweenService:Create(u14.UIScale, TweenInfo.new(0.4), {
                Scale = 1
            }):Play();
            TweenService:Create(u14, TweenInfo.new(0.3), {
                ImageTransparency = 0.67,
                Size = UDim2.fromScale(Size.X.Scale / 1.6, Size.Y.Scale)
            }):Play();
            task.delay(0.3, function() -- Line: 94
                -- upvalues: TweenService (ref), u14 (copy)
                TweenService:Create(u14, TweenInfo.new(0.3), {
                    ImageTransparency = 1
                }):Play();
                task.wait(0.3);
                u14:Destroy();
            end);
            local u15 = JackpotAssets.JackpotFrames:FindFirstChild(v13):Clone();
            u15.Parent = JackpotFrameM;
            u15.Position = UDim2.fromScale(0.5, -1.5);
            u15.UIScale.Scale = 1.2;
            TweenService:Create(u15.UIScale, TweenInfo.new(0.3), {
                Scale = 1
            }):Play();
            local v16 = TweenService:Create(u15, TweenInfo.new(0.13, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
                Position = UDim2.fromScale(0.5, 0.5)
            });
            v16:Play();
            v16.Completed:Wait();
            local v17 = tick() - v9;
            task.delay(2 - v17, function() -- Line: 113
                -- upvalues: TweenService (ref), u15 (copy)
                TweenService:Create(u15, TweenInfo.new(1), {
                    ImageTransparency = 1,
                    ImageColor3 = Color3.fromRGB(103, 103, 103)
                }):Play();
                task.wait(1);
                u15:Destroy();
            end);
        end);
        local _ = i;
    end;

    task.delay(4, function() -- Line: 121
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
end;

return function(u18) -- Line: 126, Name: JackpotSteal
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Essentials (copy), CameraShaker (copy), ReplicatedStorage (copy), RunService (copy), Effects (copy), TweenService (copy), JackpotUI (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u18.AbilityService;
    u3 = u18.Animations;
    u2 = u18.MovementController;
    u4 = u18.BallController;
    u5 = u18.CameraController;
    local Network = u18.Network;

    if u18.JackpotRNG then
        if LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief" then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u18.TotalTheft) then
                u18.CDS[1] = tick() + 65;
            end;
        else
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.Flash.BackgroundTransparency = 1;
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2.AbilityName.Text = "Jackpot Steal";

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u18.TotalTheft) then
                u18:ResetCD(1);
            end;
        end;

        u18:ResetCopy();

        if not Network.CharValues.HasBall then
            u18.JackpotRNG = nil;

            return;
        end;

        if u18.JackpotRNG[1] == 3 then
            local LookingAt = u18.Pass.LookingAt;

            if not LookingAt then
                local v19 = 9999;
                LookingAt = nil;

                for _, v in LocalPlayer.Team:GetPlayers() do
                    if v ~= LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") then
                        local Magnitude = (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

                        if Magnitude < v19 then
                            LookingAt = v.Character;
                            v19 = Magnitude;
                        end;
                    end;
                end;
            end;

            if not LookingAt then
                u18.JackpotRNG = nil;
                Effects:Popup("No player found to pass to.");

                return;
            end;

            u2.States.Ability = true;
            task.delay(0.5, function() -- Line: 180
                -- upvalues: u2 (ref)
                u2.States.Ability = false;
            end);
            u3:StopAll();
            u3:PlayChar("Jackpot", `JackpotStealPass{Essentials:ReturnRorL(u18.Network.CharValues)}`, Enum.AnimationPriority.Action3);
            u3:PlayBall("Jackpot", `JackpotStealPass{Essentials:ReturnRorL(u18.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
            u18.AC:Connect(u1.Ability, function(p20) -- Line: 188
                -- upvalues: u5 (ref), CameraShaker (ref), LookingAt (ref), ReplicatedStorage (ref), u4 (ref), u18 (copy), RunService (ref), HumanoidRootPart (copy), Character (copy)
                u5.CamShake:Shake(CameraShaker.Presets.Dunk);
                local u21 = LookingAt;
                local Value = ReplicatedStorage.Basketball.Value;
                Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                local Unit = (u21.HumanoidRootPart.Position - Value.Position).Unit;
                local _ = (u21.HumanoidRootPart.Position - Value.Position).Magnitude;
                local Position = Value.Position;
                local Position2 = u21.HumanoidRootPart.Position;
                local Magnitude = (Position2 - Position).Magnitude;
                Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.Attachment0 = Value.Root;
                LinearVelocity.MaxForce = 40000;
                LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
                u18.AC:Add(LinearVelocity);
                u18.AC:Add(task.delay(0.15, function() -- Line: 215
                    -- upvalues: LinearVelocity (copy), Value (copy), Magnitude (ref), u18 (ref), RunService (ref), Position (ref), u4 (ref), Position2 (ref), u21 (copy), HumanoidRootPart (ref), Character (ref)
                    LinearVelocity.Parent = Value;
                    local u22 = tick();
                    local u23 = false;
                    local u24 = 75;
                    u18.AC:Connect(RunService.Heartbeat, function(p25) -- Line: 221
                        -- upvalues: Position (ref), u4 (ref), Position2 (ref), u21 (ref), Magnitude (ref), HumanoidRootPart (ref), u23 (ref), u18 (ref), Value (ref), LinearVelocity (ref), u22 (copy), Character (ref), u24 (ref)
                        Position = u4:GetServerBallPosition();
                        Position2 = u21.HumanoidRootPart.Position;
                        Magnitude = (Position2 - Position).Magnitude;
                        local Magnitude2 = (HumanoidRootPart.Position - Position).Magnitude;

                        if Magnitude2 >= 20 then
                            u23 = true;
                        end;

                        if Magnitude2 <= 12 and u23 then
                            u18.AC:Clean();
                            Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                            return;
                        end;

                        if not u4:LocalPlayerIsBallNetworkOwner() then
                            u18.AC:Clean();

                            return;
                        end;

                        if u22 + 1.5 < tick() or Magnitude <= 10 and u21.HumanoidRootPart == HumanoidRootPart or (Value.Parent == nil or u4:GetPlayerPossessingBall()) then
                            u18.AC:Clean();
                            Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                            return;
                        end;

                        if u4:CharacterPossessesBall(Character) then
                            LinearVelocity.Parent = nil;
                        end;

                        LinearVelocity.Parent = Value;
                        LinearVelocity.VectorVelocity = ((u21.HumanoidRootPart.Position - Position).Unit + Vector3.new(0, 0, 0)) * (u24 * 1.8);
                    end);
                end));
            end);
        elseif u18.JackpotRNG[1] == 2 then
            u3:StopAll();
            u3:PlayChar("Jackpot", "JackpotStealForward", Enum.AnimationPriority.Action3);
            u3:PlayBall("Jackpot", "JackpotStealForwardBall", Enum.AnimationPriority.Action3);
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.Parent = HumanoidRootPart;
            task.delay(0.75, function() -- Line: 279
                -- upvalues: LinearVelocity (copy)
                LinearVelocity:Destroy();
            end);
            LinearVelocity.VectorVelocity = HumanoidRootPart.CFrame.LookVector * 80;
            task.spawn(function() -- Line: 282
                -- upvalues: u2 (ref), TweenService (ref)
                u2.States.Ability = true;
                local workspace_CurrentCamera = workspace.CurrentCamera;
                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    FieldOfView = 90
                }):Play();
                task.delay(0.4, function() -- Line: 286
                    -- upvalues: TweenService (ref), workspace_CurrentCamera (copy), u2 (ref)
                    TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2), {
                        FieldOfView = 70
                    }):Play();
                    task.wait(0.2);
                    u2.States.Ability = false;
                end);
            end);
        end;

        u1.Ability:Fire("JackpotSteal", {
            TimeSent = workspace:GetServerTimeNow(),
            JackpotRNG = u18.JackpotRNG
        });
        u18.JackpotRNG = nil;

        return;
    end;

    if Network.CharValues.HasBall then
        u18:ResetCD(2);
        Effects:Popup("Not usable with ball!");

        return;
    end;

    local PlayerPossessingBall = u4:GetPlayerPossessingBall();

    if PlayerPossessingBall and PlayerPossessingBall.Team == LocalPlayer.Team then
        u18:ResetCD(2);
        Effects:Popup("Can\'t steal from teammate!");

        return;
    end;

    local u26 = PlayerPossessingBall and PlayerPossessingBall.Character;
    local v27 = u4:GetServerBallPosition() - HumanoidRootPart.Position;

    if v27:Dot(v27) > 1444 then
        u18:ResetCD(2);
        Effects:Popup("Ball must be close to you!");

        return;
    end;

    task.spawn(function() -- Line: 320
        -- upvalues: u2 (ref), TweenService (ref)
        u2.States.Ability = true;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FieldOfView = 30
        }):Play();
        task.delay(0.32, function() -- Line: 325
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy), u2 (ref)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                FieldOfView = 90
            }):Play();
            task.wait(0.16);
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                FieldOfView = 70
            }):Play();
            task.wait(0.16);
            u2.States.Ability = false;
        end);
    end);
    u18.JackpotRNG = nil;
    u3:StopAll();
    local v28 = u3:PlayChar("Jackpot", "JackpotSteal", Enum.AnimationPriority.Action3, true);
    local v29 = u3:PlayBall("Jackpot", "JackpotStealBall", Enum.AnimationPriority.Action3, true);
    v28:AdjustSpeed(1.25);
    v29:AdjustSpeed(1.25);
    local u30 = {};
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    u18.AC:Add(task.delay(0.5599999999999999, function() -- Line: 349
        -- upvalues: u30 (copy), u2 (ref), Effects (ref), u18 (copy)
        u30.Done = true;
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        Effects:Popup("STEAL FAILED! NO ABILITY GRANTED.", 1, Color3.new(1, 0.254902, 0.254902));
        u18:ResetCopy();
    end));
    JackpotUI(u30);
    u1.Ability:Fire("JackpotSteal", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = u26
    });
    u18.AC:Connect(u1.Ability, function(u31) -- Line: 363
        -- upvalues: u18 (copy), u30 (copy), Effects (ref), u26 (copy), u2 (ref), LocalPlayer (ref), RunService (ref), Network (copy), HumanoidRootPart (copy)
        u18.AC:Clean();
        u30.Rng = u31;
        task.wait(0.2);
        Effects:Popup("STEAL SUCCESSFUL! NEW ABILITY GRANTED", 1, Color3.new(1, 0.843137, 0.52549));
        u18.JackpotRNG = { u31, u26 };
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u18:ResetCD(2);
        local u32 = { "Lucky Stun", "Lucky Dash", "Lucky Pass" };
        local u33 = (LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief") and LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1 or LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability2;
        local u34 = 1;
        local u35 = false;
        u18.AC:Connect(RunService.Heartbeat, function(p36) -- Line: 389
            -- upvalues: Network (ref), u33 (copy), HumanoidRootPart (ref), LocalPlayer (ref), u34 (ref), u35 (ref), u32 (copy), u31 (copy)
            if not Network.CharValues.HasBall then
                u33.Flash.BackgroundTransparency = 1;

                return;
            end;

            local _ = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;
            u33.Flash.BackgroundTransparency = u34;

            if u34 > 0.5 and not u35 then
                p36 = -p36 or p36;
            end;

            u34 = u34 + p36;

            if u34 <= 0.5 then
                u35 = true;
            end;

            if u34 >= 1 then
                u35 = false;
            end;

            u33.AbilityName.Text = u32[u31];
        end);
        u18.AC:Add(task.delay(3.5, function() -- Line: 404
            -- upvalues: u18 (ref), LocalPlayer (ref), u33 (copy)
            u18.JackpotRNG = nil;

            if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u18.TotalTheft) then
                if LocalPlayer.Style.Value == "Copycat" or LocalPlayer.Style.Value == "Thief" then
                    u18.CDS[1] = tick() + 65;
                else
                    u18.CDS[2] = tick() + 65;
                end;
            end;

            u18.AC:Clean();
            u33.Flash.BackgroundTransparency = 1;
            u18:ResetCopy();
        end));
        local v37 = tick();

        repeat
            task.wait();
        until u18.JackpotRNG == nil or tick() - v37 > 3.5;

        if u18.JackpotRNG ~= nil then
            return;
        end;

        u18.JackpotRNG = nil;
        u33.Flash.BackgroundTransparency = 1;
    end);
end;