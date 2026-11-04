  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy), EmitModule (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if not Char:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    local u2 = {};

    local function ScreenEffect() -- Line: 35
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 60, 100)
            }):Play();
            task.delay(0.1, function() -- Line: 39
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    local function CreateEffect(p3, p4) -- Line: 45
        -- upvalues: Char (copy), VfxManager (ref), u2 (copy)
        local v5 = p3:Clone();
        v5.CFrame = Char.HumanoidRootPart.CFrame * p4;
        v5.Parent = workspace.Debris;
        VfxManager.Emit(v5);
        table.insert(u2, v5);
    end;

    task.wait(0.4);
    local v6 = script.Highlight:Clone();
    v6.Parent = Char;
    EmitModule.emit(v6);
    local script_Hit4Emit = script.Hit4Emit;
    local CFrame_new_ret = CFrame.new(0, -2.5, 0);
    local v7 = script_Hit4Emit:Clone();
    v7.CFrame = Char.HumanoidRootPart.CFrame * CFrame_new_ret;
    v7.Parent = workspace.Debris;
    VfxManager.Emit(v7);
    table.insert(u2, v7);
    task.wait(1);
    v6:Destroy();

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;