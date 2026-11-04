  

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
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), Essentials (copy), VfxManager (copy), Debris (copy), SoundManager (copy)
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

    local function CreateEffect(p3, p4, p5) -- Line: 44
        -- upvalues: HumanoidRootPart (copy), Essentials (ref), VfxManager (ref), u2 (copy), Debris (ref)
        local v6 = p3:Clone();
        v6.CFrame = HumanoidRootPart.CFrame * p4 or CFrame.identity;
        v6.Parent = workspace.Debris;

        if p5 then
            if p4 then
                Essentials:WeldOffset(p5, v6, p4);
            else
                Essentials:Weld(p5, v6);
            end;
        end;

        VfxManager.Emit(v6);
        table.insert(u2, v6);
        Debris:AddItem(v6, 2);
    end;

    SoundManager.SpawnSound("GingaStyle", 0.9, Char.HumanoidRootPart, 130, false);
    CreateEffect(script.Startup, CFrame.new(-0.399986267, -2.0999999, 0.300479889, -1, 0, 0, 0, 1, 0, 0, 0, -1));
    task.wait(0.15);
    CreateEffect(script.SprintStart, CFrame.new(-0.399986267, -2.0999999, -0.39951992, -1, 0, 0, 0, 1, 0, 0, 0, -1));
    CreateEffect(script.Dash, CFrame.new(-1.15531158, -1.67233658, -6.79631424, 0, 0, 1.00000072, 0, 1, 0, -1.00000072, 0, 0), HumanoidRootPart);
    task.delay(2, function() -- Line: 73
        -- upvalues: u2 (copy)
        for _, v in u2 do
            if v then
                v:Destroy();
            end;
        end;
    end);
end;