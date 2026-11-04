  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 18
    -- upvalues: SpectatorController (copy), SoundManager (copy), VfxManager (copy), Debris (copy), LocalPlayer (copy), CameraController (copy), TweenService (copy), Lighting (copy), RunService (copy)
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

    local v2 = script.Name .. " VFX " .. Char.Name;
    local v3 = workspace.Debris:FindFirstChild(v2);

    if not v3 then
        v3 = Instance.new("Folder");
        v3.Name = v2;
        v3.Parent = workspace.Debris;
    end;

    if p1.State ~= "Start" then
        if p1.State == "Dash" then
            local Pos = p1.Pos;

            if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                CameraController:Shake("Hit");
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                    TintColor = Color3.new(1, 0.411765, 0.411765)
                }):Play();
                task.delay(0.1, function() -- Line: 62
                    -- upvalues: TweenService (ref), Lighting (ref)
                    TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                        TintColor = Color3.new(1, 1, 1)
                    }):Play();
                end);
            end;

            local u4 = script.FeintDash:Clone();
            u4:PivotTo(CFrame.new(HumanoidRootPart.Position, Pos));
            u4.Parent = v3;
            local v5 = RunService.Heartbeat:Connect(function() -- Line: 71
                -- upvalues: u4 (copy), HumanoidRootPart (copy), Pos (copy)
                u4:PivotTo(CFrame.new(HumanoidRootPart.Position, Pos));
            end);
            task.wait(0.4);
            v5:Disconnect();
            VfxManager.Enable(u4, false);
            Debris:AddItem(u4, 2);
        end;

        return;
    end;

    local _ = p1.Dir;
    SoundManager.SpawnSound("Lion Steal", 0.7, Char.Torso, 150);
    print("starting");
    local v6 = script.KingFloor:Clone();
    v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.9, 0);
    v6.Parent = v3;
    VfxManager.Emit(v6);
    Debris:AddItem(v6, 1);
end;