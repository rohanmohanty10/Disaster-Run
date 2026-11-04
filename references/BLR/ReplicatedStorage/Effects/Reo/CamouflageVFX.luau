  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local createAfterImage = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SpectatorController (copy), SoundManager (copy), LocalPlayer (copy), Essentials (copy), CameraController (copy), TweenService (copy), Lighting (copy), createAfterImage (copy), AbilityBalancing (copy), VfxManager (copy), Debris (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if p1.State == "Start" then
        local Football = Char:FindFirstChild("Football");
        local BALL = Char:FindFirstChild("BALL", true);
        SoundManager.SpawnSound("CamouflageReo", 0.7, HumanoidRootPart, 130, false);

        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            Char.Archivable = true;
            Essentials:HideCharacter(Char, { Football, BALL });
            CameraController:Shake("Hit");
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.new(0.584314, 0.419608, 1)
            }):Play();
            task.delay(0.8, function() -- Line: 45
                -- upvalues: Essentials (ref), Char (copy), Football (copy), BALL (copy), TweenService (ref), Lighting (ref)
                Essentials:UnhideCharacter(Char, { Football, BALL });
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.4), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);

            for i = 1, 3 do
                task.wait(0.2);
                createAfterImage(Char, {
                    FillColor = Color3.new(0.682353, 0.556863, 1),
                    OutlineColor = Color3.new(0.537255, 0.352941, 1)
                });
                local Unit = (HumanoidRootPart.CFrame.LookVector + (i == 2 and HumanoidRootPart.CFrame.RightVector or (i == 3 and Vector3.new(0, 0, 0) or -HumanoidRootPart.CFrame.RightVector)) / 2).Unit;
                local Unit2 = Vector3.new(Unit.X, -1, Unit.Z).Unit;
                local CFrame_new_ret = CFrame.new(HumanoidRootPart.Position + Unit2 * (AbilityBalancing.Camouflage.TravelDistance / 2), HumanoidRootPart.Position + Unit2 * AbilityBalancing.Camouflage.TravelDistance);
                local v2 = script.New.Debree:Clone();
                v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1, 0) * CFrame.Angles(0, 3.141592653589793, 0);
                v2.Parent = workspace.Debris;
                VfxManager.Emit(v2);
                Debris:AddItem(v2, 2);
                local v3 = script.Dash:Clone();
                v3:PivotTo(CFrame_new_ret * CFrame.Angles(0, 1.5707963267948966, 0));
                v3.Parent = workspace.Debris;
                VfxManager.Emit(v3);
                Debris:AddItem(v3, 2);
                local _ = i;
            end;
        end;
    end;
end;