  

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
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy)
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

    local function CreateEffect(p3) -- Line: 44
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u2 (copy)
        local v4 = p3:Clone();
        v4.CFrame = HumanoidRootPart.CFrame;
        v4.Parent = workspace.Debris;
        VfxManager.Emit(v4);
        table.insert(u2, v4);
    end;

    local function CreateTrail(p5) -- Line: 54
        -- upvalues: VfxManager (ref), u2 (copy)
        local v6 = script.Main:Clone();
        v6.Parent = p5;
        VfxManager.Emit(v6);
        table.insert(u2, v6);
    end;

    print("Here");
    local v7 = script.StartupSimple:Clone();
    v7.CFrame = HumanoidRootPart.CFrame;
    v7.Parent = workspace.Debris;
    VfxManager.Emit(v7);
    table.insert(u2, v7);
    local v8 = Char["Right Arm"];
    local v9 = script.Main:Clone();
    v9.Parent = v8;
    VfxManager.Emit(v9);
    table.insert(u2, v9);
    local v10 = Char["Left Arm"];
    local v11 = script.Main:Clone();
    v11.Parent = v10;
    VfxManager.Emit(v11);
    table.insert(u2, v11);
    local v12 = Char["Right Leg"];
    local v13 = script.Main:Clone();
    v13.Parent = v12;
    VfxManager.Emit(v13);
    table.insert(u2, v13);
    local v14 = Char["Left Leg"];
    local v15 = script.Main:Clone();
    v15.Parent = v14;
    VfxManager.Emit(v15);
    table.insert(u2, v15);
    task.wait(0.5);
    local v16 = script.StartupSimple:Clone();
    v16.CFrame = HumanoidRootPart.CFrame;
    v16.Parent = workspace.Debris;
    VfxManager.Emit(v16);
    table.insert(u2, v16);
    task.wait(3);

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;