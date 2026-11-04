 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
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
        Sound = "LoadedDiceSFX",
        Parent = workspace
    });
    local JackpotAssets = ReplicatedStorage.Assets.UI.JackpotAssets;
    local u7 = JackpotAssets.Jackpot:Clone();
    u7.Parent = LocalPlayer.PlayerGui;
    local CanvasGroup = u7.Main.CanvasGroup;
    local Children = JackpotAssets.JackpotFrames:GetChildren();
    local u8 = { "Stun", "Pass" };
    local UIScale = CanvasGroup.UIScale;
    UIScale.Scale = 1.6;
    TweenService:Create(UIScale, TweenInfo.new(0.3), {
        Scale = 1.5
    }):Play();
    task.delay(0.3, function() -- Line: 42
        -- upvalues: TweenService (ref), UIScale (copy)
        TweenService:Create(UIScale, TweenInfo.new(0.2), {
            Scale = 1.3
        }):Play();
    end);
    local JackpotFrameM = CanvasGroup.JackpotFrameM;
    task.spawn(function() -- Line: 49
        -- upvalues: u6 (copy), Children (copy), JackpotFrameM (copy), TweenService (ref), u8 (copy), CanvasGroup (copy), JackpotAssets (copy)
        local v9 = tick();
        local v10 = 0;

        while v10 < 7 or u6.Rng == nil and (not u6.Done and tick() - v9 < 3) do
            v10 = v10 + 1;
            local v11 = Children[math.random(1, #Children)]:Clone();
            v11.Parent = JackpotFrameM;
            v11.Position = UDim2.fromScale(0.5, -1.5);
            v11.ImageColor3 = Color3.fromRGB(206, 206, 206);
            v11.UIScale.Scale = 0.9;
            local v12 = TweenService:Create(v11, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
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
        task.delay(0.3, function() -- Line: 83
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
        local v16 = TweenService:Create(u15, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
            Position = UDim2.fromScale(0.5, 0.5)
        });
        v16:Play();
        print(tick() - v9);
        v16.Completed:Wait();
        local v17 = tick() - v9;
        task.delay(2 - v17, function() -- Line: 104
            -- upvalues: TweenService (ref), u15 (copy)
            TweenService:Create(u15, TweenInfo.new(1), {
                ImageTransparency = 1,
                ImageColor3 = Color3.fromRGB(103, 103, 103)
            }):Play();
            task.wait(1);
            u15:Destroy();
        end);
    end);
    task.delay(4, function() -- Line: 111
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
end;

return function(u18) -- Line: 116, Name: LoadedDice
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), JackpotUI (copy), Effects (copy), RunService (copy), ReplicatedStorage (copy), Essentials (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u18.AbilityService;
    u3 = u18.Animations;
    u2 = u18.MovementController;
    u4 = u18.BallController;
    u5 = u18.CameraController;
    local Network = u18.Network;

    if u18.LoadedDiceRNG then
        if u18.LoadedDiceRNG == 1 then
            if not Network.CharValues.HasBall then
                u18:ResetCD(4);
                Effects:Popup("Must have the ball to use ability!");

                return;
            end;

            u2.States.Ability = true;
            u2.States.NoWalk = true;
            u2.States.Shooting = true;
            u18.AC:Add(task.delay(1.8, function() -- Line: 184
                -- upvalues: u2 (ref), u18 (copy)
                u2.States.Shooting = false;
                u2.States.Ability = false;
                u2.States.NoWalk = false;
                u18:ResetCopy();
                u18.AC:Clean();
            end));
            u3:StopAll();
            u3:PlayChar("Jackpot", `LuckyShot{Essentials:ReturnRorL(Network.CharValues)}`, Enum.AnimationPriority.Action3);
            u3:PlayBall("Jackpot", `LuckyShot{Essentials:ReturnRorL(Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
            LinearVelocity.MaxForce = (1 / 0);
            LinearVelocity.Parent = HumanoidRootPart;
            local Position = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position;
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));
            local LookVector = HumanoidRootPart.CFrame.LookVector;
            local u19 = -LookVector + Vector3.new(0, 0.05, 0);
            local u20 = 30;
            local u21 = 0.01;
            local u22 = 0.01;
            u18.AC:Connect(RunService.Heartbeat, function(p23) -- Line: 213
                -- upvalues: LinearVelocity (copy), u19 (ref), u21 (ref), u20 (ref), HumanoidRootPart (copy), Position (copy), u22 (ref)
                LinearVelocity.VectorVelocity = (u19 + Vector3.new(0, u21, 0)) * u20;
                u20 = u20 - p23 * 5;
                u21 = u21 - p23 * 5;
                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z)));

                if u20 <= 15 then
                    u20 = 15;
                end;

                if u21 <= u22 then
                    u21 = u22;
                end;
            end);
            u18.AC:Add(LinearVelocity);
            task.delay(0.55, function() -- Line: 224
                -- upvalues: u19 (ref), u20 (ref)
                u19 = u19 / 2 + Vector3.new(0, 0.5, 0);
                u20 = 30;
            end);
            task.delay(1, function() -- Line: 225
                -- upvalues: u19 (ref)
                u19 = u19 / 2;
            end);
            u18.AC:Connect(u1.Ability, function() -- Line: 227
                -- upvalues: u19 (ref), LookVector (copy), u21 (ref), u22 (ref), u20 (ref), u18 (copy), u2 (ref), ReplicatedStorage (ref), u4 (ref), LocalPlayer (ref)
                u19 = -LookVector;
                u21 = 0.25;
                u22 = -1;
                u20 = 50;
                task.delay(0.5, function() -- Line: 233
                    -- upvalues: u18 (ref), u2 (ref)
                    u18.AC:Clean();
                    u2.States.Shooting = false;
                    u2.States.Ability = false;
                    u2.States.NoWalk = false;
                end);
                local Value = ReplicatedStorage.Basketball.Value;
                Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
                local Position2 = Value.Position;
                local _ = (workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2).Magnitude;
                local v24 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - Position2;
                local math_log_ret = math.log(2.5 + v24.Magnitude * 0.045);
                Value.AssemblyLinearVelocity = v24 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);
            end);
        else
            if Network.CharValues.HasBall then
                u18:ResetCD(4);
                Effects:Popup("Not usable with ball!");

                return;
            end;

            if u4:GetCharacterPossessingBall() then
                u18:ResetCD(4);
                Effects:Popup("Ball must be in the air!");

                return;
            end;

            u18:ResetCopy();
            u18.AC:Connect(u1.Ability, function() -- Line: 268
                -- upvalues: Character (copy), ReplicatedStorage (ref), u4 (ref), u18 (copy), RunService (ref), HumanoidRootPart (copy)
                local u25 = Character;
                local Value = ReplicatedStorage.Basketball.Value;
                local ServerBallPosition = u4:GetServerBallPosition();
                local Unit = (u25.HumanoidRootPart.Position - ServerBallPosition).Unit;
                local _ = (u25.HumanoidRootPart.Position - ServerBallPosition).Magnitude;
                local u26 = ServerBallPosition;
                local Position = u25.HumanoidRootPart.Position;
                local Magnitude = (Position - u26).Magnitude;
                Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.Attachment0 = Value.Root;
                LinearVelocity.MaxForce = 40000;
                LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
                u18.AC:Add(LinearVelocity);
                u18.AC:Add(task.delay(0.15, function() -- Line: 292
                    -- upvalues: LinearVelocity (copy), Value (copy), Magnitude (ref), u18 (ref), RunService (ref), u26 (ref), u4 (ref), Position (ref), u25 (copy), HumanoidRootPart (ref), Character (ref)
                    LinearVelocity.Parent = Value;
                    local u27 = tick();
                    local u28 = false;
                    local u29 = 50;
                    u18.AC:Connect(RunService.Heartbeat, function(p30) -- Line: 299
                        -- upvalues: u26 (ref), u4 (ref), Position (ref), u25 (ref), Magnitude (ref), HumanoidRootPart (ref), u28 (ref), u18 (ref), Value (ref), LinearVelocity (ref), u27 (copy), Character (ref), u29 (ref)
                        u26 = u4:GetServerBallPosition();
                        Position = u25.HumanoidRootPart.Position;
                        Magnitude = (Position - u26).Magnitude;
                        local Magnitude2 = (HumanoidRootPart.Position - u26).Magnitude;

                        if Magnitude2 >= 20 then
                            u28 = true;
                        end;

                        if Magnitude2 <= 12 and u28 then
                            u18.AC:Clean();
                            Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                            return;
                        end;

                        if not u4:LocalPlayerIsBallNetworkOwner() then
                            u18.AC:Clean();

                            return;
                        end;

                        if u27 + 1 < tick() or Magnitude <= 10 and u25.HumanoidRootPart == HumanoidRootPart or (Value.Parent == nil or u4:GetPlayerPossessingBall()) then
                            u18.AC:Clean();
                            Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                            return;
                        end;

                        if u4:CharacterPossessesBall(Character) then
                            LinearVelocity.Parent = nil;
                        end;

                        LinearVelocity.Parent = Value;
                        LinearVelocity.VectorVelocity = ((u25.HumanoidRootPart.Position - u26).Unit + Vector3.new(0, 0, 0)) * (u29 * 1.8);
                    end);
                end));
            end);
        end;

        u1.Ability:Fire("LoadedDice", {
            TimeSent = workspace:GetServerTimeNow()
        });
        u18.LoadedDiceRNG = nil;
        u18.LoadedConnect:Disconnect();
        RunService.Heartbeat:Wait();
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Loaded Dice";

        return;
    end;

    local u31 = {};
    u18.AC:Connect(u1.Ability, function(p32) -- Line: 130
        -- upvalues: u31 (copy)
        if typeof(p32) == "table" and (p32.Roll == 1 or p32.Roll == 2) then
            u31.Rng = p32.Roll;
        end;
    end);
    u1.Ability:Fire("LoadedDice", {
        Roll = true,
        TimeSent = workspace:GetServerTimeNow()
    });
    JackpotUI(u31);
    local v33 = tick();

    repeat
        task.wait();
    until u31.Rng or tick() - v33 > 2;

    u31.Done = true;
    local Rng = u31.Rng;

    if Rng == nil then
        u18:ResetCD(4);

        return;
    end;

    u18.LoadedDiceRNG = Rng;
    local task_wait = task.wait;
    local v34 = 0.5 - (tick() - v33);
    task_wait((math.max(v34, 0)));
    u18:ResetCD(4);
    local u35 = { "Lucky Shot", "Lucky Pull" };
    Effects:Popup((`{u35[Rng]} ABILITY GRANTED`));
    local u36 = 1;
    local u37 = false;
    u18.LoadedConnect = RunService.Heartbeat:Connect(function(p38) -- Line: 165
        -- upvalues: ReplicatedStorage (ref), Network (copy), u18 (copy), LocalPlayer (ref), u36 (ref), u37 (ref), u35 (copy), Rng (copy)
        if ReplicatedStorage.GameValues.State.Value ~= "Playing" or not Network.CharValues.InAwakening then
            u18.LoadedDiceRNG = nil;
            u18.LoadedConnect:Disconnect();
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

            return;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u36;

        if u36 > 0.5 and not u37 then
            p38 = -p38 or p38;
        end;

        u36 = u36 + p38;

        if u36 <= 0.5 then
            u37 = true;
        end;

        if u36 >= 1 then
            u37 = false;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = u35[Rng];
    end);
end;