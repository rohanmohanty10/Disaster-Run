 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 19, Name: LuckyBounce
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), Essentials (copy), CameraShaker (copy), ReplicatedStorage (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.CameraController;
    local Network = u6.Network;

    if u6.LuckyBounce then
        u6.AC:Clean();
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        u6.LuckyBounce = false;
        u6:ResetCopy();
        local LookingAt = u6.Pass.LookingAt;

        if not LookingAt then
            local v7 = 9999;
            LookingAt = nil;

            for _, v in LocalPlayer.Team:GetPlayers() do
                if v ~= LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") then
                    local Magnitude = (v.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude;

                    if Magnitude < v7 then
                        LookingAt = v.Character;
                        v7 = Magnitude;
                    end;
                end;
            end;

            if not LookingAt then
                Effects:Popup("No player found to pass to!");

                return;
            end;
        end;

        u2.States.Ability = true;
        task.delay(0.5, function() -- Line: 59
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        u3:StopAll();
        u3:PlayChar("Jackpot", `LuckyBouncePass{Essentials:ReturnRorL(u6.Network.CharValues)}`, Enum.AnimationPriority.Action3);
        u3:PlayBall("Jackpot", `LuckyBouncePass{Essentials:ReturnRorL(u6.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
        u6.AC:Connect(u1.Ability, function(p8) -- Line: 67
            -- upvalues: u5 (ref), CameraShaker (ref), LookingAt (ref), ReplicatedStorage (ref), u4 (ref), u6 (copy), LocalPlayer (ref), RunService (ref), HumanoidRootPart (copy), Character (copy)
            u5.CamShake:Shake(CameraShaker.Presets.Dunk);
            local u9 = LookingAt;
            local Value = ReplicatedStorage.Basketball.Value;
            Value.CFrame = u4:GetLastCharacterToPossessBall().PlrBall.Anims.BALL.CFrame;
            local Unit = (u9.HumanoidRootPart.Position - Value.Position).Unit;
            local _ = (u9.HumanoidRootPart.Position - Value.Position).Magnitude;
            local Position = Value.Position;
            local Position2 = u9.HumanoidRootPart.Position;
            local Magnitude = (Position2 - Position).Magnitude;
            Value.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = Value.Root;
            LinearVelocity.MaxForce = 40000;
            LinearVelocity.VectorVelocity = (Unit + Vector3.new(0, 0.62, 0)) * Magnitude;
            u6.AC:Add(LinearVelocity);
            u6.AC:Add(task.delay(0.15, function() -- Line: 94
                -- upvalues: LocalPlayer (ref), LinearVelocity (copy), Value (copy), Magnitude (ref), u6 (ref), RunService (ref), Position (ref), u4 (ref), Position2 (ref), u9 (copy), HumanoidRootPart (ref), Character (ref)
                LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Lucky Bounce";
                LinearVelocity.Parent = Value;
                local u10 = tick();
                local u11 = false;
                local u12 = 75;
                u6.AC:Connect(RunService.Heartbeat, function(p13) -- Line: 102
                    -- upvalues: Position (ref), u4 (ref), Position2 (ref), u9 (ref), Magnitude (ref), HumanoidRootPart (ref), u11 (ref), u6 (ref), Value (ref), LinearVelocity (ref), u10 (copy), Character (ref), u12 (ref)
                    Position = u4:GetServerBallPosition();
                    Position2 = u9.HumanoidRootPart.Position;
                    Magnitude = (Position2 - Position).Magnitude;
                    local v14 = HumanoidRootPart.Position - Position;
                    local v15 = v14:Dot(v14);

                    if v15 >= 400 then
                        u11 = true;
                    end;

                    if u11 and v15 <= 144 then
                        u6.AC:Clean();
                        Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                        return;
                    end;

                    if not u4:LocalPlayerIsBallNetworkOwner() then
                        u6.AC:Clean();

                        return;
                    end;

                    if not (u9 and (u10 + 1.5 >= tick() and (Magnitude > 10 or u9.HumanoidRootPart ~= HumanoidRootPart)) and (Value.Parent ~= nil and (workspace:FindFirstChild(u9.Name) and not u4:GetPlayerPossessingBall()))) then
                        u6.AC:Clean();
                        Value.AssemblyLinearVelocity = LinearVelocity.VectorVelocity;

                        return;
                    end;

                    if u4:CharacterPossessesBall(Character) then
                        LinearVelocity.Parent = nil;
                    end;

                    LinearVelocity.Parent = Value;
                    LinearVelocity.VectorVelocity = ((u9.HumanoidRootPart.Position - Position).Unit + Vector3.new(0, 0, 0)) * (u12 * 1.8);
                end);
            end));
        end);
        u1.Ability:Fire("LuckyBounce", {
            TimeSent = workspace:GetServerTimeNow(),
            ToPass = LookingAt
        });

        return;
    end;

    local v16 = u6:CheckInfront(27.5);

    if v16 == nil then
        u6:ResetCD(1);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    u6:ResetCD(1);
    LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Lucky Pass";
    u2.States.Ability = true;
    u6.AC:Add(task.delay(0.6, function() -- Line: 167
        -- upvalues: u2 (ref), u6 (copy)
        u2.States.Ability = false;
        u6.LuckyBounce = true;
    end));
    u6.AC:Add(task.delay(1.5, function() -- Line: 170
        -- upvalues: u6 (copy), LocalPlayer (ref)
        u6.LuckyBounce = false;

        if not (workspace:GetAttribute("NoAbilityCooldowns") or (LocalPlayer:GetAttribute("NoAbilityCooldowns") or LocalPlayer.Style.Value == "Copycat" and LocalPlayer:GetAttribute("TrueCopycat")) or LocalPlayer.Style.Value == "Thief" and u6.TotalTheft) then
            u6.CDS[1] = tick() + 65;
        end;

        u6.AC:Clean();
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;
        u6:ResetCopy();
    end));
    local u17 = 1;
    local u18 = false;
    u6.AC:Connect(RunService.Heartbeat, function(p19) -- Line: 186
        -- upvalues: Network (copy), LocalPlayer (ref), HumanoidRootPart (copy), u17 (ref), u18 (ref)
        if not Network.CharValues.HasBall then
            LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = 1;

            return;
        end;

        local _ = (HumanoidRootPart.Position - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position).Magnitude;
        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.Flash.BackgroundTransparency = u17;

        if u17 > 0.5 and not u18 then
            p19 = -p19 or p19;
        end;

        u17 = u17 + p19;

        if u17 <= 0.5 then
            u18 = true;
        end;

        if u17 >= 1 then
            u18 = false;
        end;

        LocalPlayer.PlayerGui.InGame.BG.Bottom.Ability1.AbilityName.Text = "Lucky Pass";
    end);
    u3:StopAll();
    u3:PlayChar("Jackpot", `LuckyBounce{Essentials:ReturnRorL(u6.Network.CharValues)}`, Enum.AnimationPriority.Action3);
    u3:PlayBall("Jackpot", `LuckyBounce{Essentials:ReturnRorL(u6.Network.CharValues)}Ball`, Enum.AnimationPriority.Action3);
    u1.Ability:Fire("LuckyBounce", {
        TimeSent = workspace:GetServerTimeNow(),
        OtherChar = v16
    });
end;