  

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
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy), SoundManager (copy)
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

    local u2 = {};

    local function ScreenEffect() -- Line: 34
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 60, 100)
            }):Play();
            task.delay(0.1, function() -- Line: 38
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    local function CreateEffect(p3, p4) -- Line: 44
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u2 (copy)
        local v5 = p3:Clone();
        v5:PivotTo(HumanoidRootPart.CFrame * p4);
        v5.Parent = workspace.Debris;
        VfxManager.Emit(v5);
        table.insert(u2, v5);
    end;

    local script_Startup = script.Startup;
    local CFrame_new_ret = CFrame.new(0, -1.8, 0);
    local v6 = script_Startup:Clone();
    v6:PivotTo(HumanoidRootPart.CFrame * CFrame_new_ret);
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
    table.insert(u2, v6);
    task.wait(0.266);
    SoundManager.SpawnSound("reverse 2 stage shot", 0.9, Char.HumanoidRootPart, 130, false);
    local script_ShootEmit = script.ShootEmit;
    local CFrame_new_ret2 = CFrame.new(0, -1.8, -3);
    local v7 = script_ShootEmit:Clone();
    v7:PivotTo(HumanoidRootPart.CFrame * CFrame_new_ret2);
    v7.Parent = workspace.Debris;
    VfxManager.Emit(v7);
    table.insert(u2, v7);
    task.wait(2);

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;