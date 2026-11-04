  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), SoundManager (copy), VfxManager (copy)
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

    local v2 = {};

    local function ScreenEffect() -- Line: 34
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 181, 120)
            }):Play();
            task.delay(0.1, function() -- Line: 38
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    SoundManager.SpawnSound("Laboba2", 0.7, Char.HumanoidRootPart, 130, false);
    local v3 = script.Startup:Clone();
    v3.CFrame = HumanoidRootPart.CFrame;
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    table.insert(v2, v3);
    task.wait(0.1);
    ScreenEffect();
    task.wait(0.45);
    local v4 = script.Emit1:Clone();
    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0);
    v4.Parent = workspace.Debris;
    VfxManager.Emit(v4);
    table.insert(v2, v4);
    ScreenEffect();
    task.wait(0.35);
    local v5 = script.EndEmit:Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.8, 0);
    v5.Parent = workspace.Debris;
    VfxManager.Emit(v5);
    table.insert(v2, v5);
    ScreenEffect();
    task.wait(3);

    for _, v in pairs(v2) do
        v:Destroy();
    end;
end;