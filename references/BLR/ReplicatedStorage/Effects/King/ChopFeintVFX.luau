  

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
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 17
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

    print(p1.State);

    if p1.State == "Start" then
        local Dir = p1.Dir;
        print("Start");
        SoundManager.SpawnSound("Lion Chop Feint", 0.7, Char.Torso, 150);
        local v4 = script.StartBurst:Clone();
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.9, 0);
        v4.Parent = v3;
        VfxManager.Emit(v4);
        Debris:AddItem(v4, 1);
        task.wait(0.2);
        local v5 = script.KingFloor:Clone();
        v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.9, 0);
        v5.Parent = v3;
        VfxManager.Emit(v5);
        Debris:AddItem(v5, 1);
        task.wait(0.2);

        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            CameraController:Shake("Hit");
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.new(1, 0.411765, 0.411765)
            }):Play();
            task.delay(0.1, function() -- Line: 67
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;

        local u6 = script.FeintDash:Clone();
        u6:PivotTo(CFrame.new(HumanoidRootPart.Position, Dir));
        u6.Parent = v3;
        local v7 = RunService.Heartbeat:Connect(function() -- Line: 76
            -- upvalues: u6 (copy), HumanoidRootPart (copy), Dir (copy)
            u6:PivotTo(CFrame.new(HumanoidRootPart.Position, Dir));
        end);
        task.wait(0.4);
        v7:Disconnect();
        VfxManager.Enable(u6, false);
        Debris:AddItem(u6, 2);
    end;
end;