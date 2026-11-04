  

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
local createAfterImage = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.EmitModule);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy), createAfterImage (copy)
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

    local function CreateEffect(p3) -- Line: 45
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u2 (copy)
        local v4 = p3:Clone();
        v4.CFrame = HumanoidRootPart.CFrame;
        v4.Parent = workspace.Debris;
        VfxManager.Emit(v4);
        table.insert(u2, v4);
    end;

    local v5 = script.Startup:Clone();
    v5.CFrame = HumanoidRootPart.CFrame;
    v5.Parent = workspace.Debris;
    VfxManager.Emit(v5);
    table.insert(u2, v5);
    createAfterImage(Char, {
        FillColor = Color3.new(0.917678, 0.517754, 0.327581),
        OutlineColor = Color3.new(0.911864, 0.737301, 0.64184)
    });
    task.wait(0.5);
    local v6 = script.Hit:Clone();
    v6.CFrame = HumanoidRootPart.CFrame;
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
    table.insert(u2, v6);
    createAfterImage(Char, {
        FillColor = Color3.new(0.917678, 0.517754, 0.327581),
        OutlineColor = Color3.new(0.911864, 0.737301, 0.64184)
    });
    task.wait(2);

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;