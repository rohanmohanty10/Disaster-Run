  

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

    local function CreateEffect(p2, p3, p4) -- Line: 44
        -- upvalues: HumanoidRootPart (copy), Essentials (ref), VfxManager (ref), Debris (ref)
        local v5 = p2:Clone();
        v5.CFrame = HumanoidRootPart.CFrame * p3 or CFrame.identity;
        v5.Parent = workspace.Debris;

        if p4 then
            if p3 then
                Essentials:WeldOffset(p4, v5, p3);
            else
                Essentials:Weld(p4, v5);
            end;
        end;

        VfxManager.Emit(v5);
        Debris:AddItem(v5, 2);
    end;

    SoundManager.SpawnSound("GingaStyle", 0.9, Char.HumanoidRootPart, 130, false);
    CreateEffect(script.Part, CFrame.new(0.0899523348, -2.19000006, -1.94304895, 1, 0, 0, 0, 1, 0, 0, 0, 1));
end;