  

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

    if not Char:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    local u2 = {};

    local function ScreenEffect() -- Line: 36
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 60, 100)
            }):Play();
            task.delay(0.1, function() -- Line: 40
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    if p1.Type == "Aura" then
        local v3 = script.Aura.Attachment:Clone();
        v3.Parent = Char["Right Arm"];
        table.insert(u2, v3);
        VfxManager.Emit(v3);
        task.wait(0.4);
        local v4 = script.Intercept:Clone();
        v4.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(4, 0, 0);
        v4.Parent = workspace.Debris;
        VfxManager.Emit(v4);
        table.insert(u2, v4);
        ScreenEffect();
    elseif p1.Type == "Hit" then
        local target = p1.target;

        local function CreateEffect(p5, p6) -- Line: 67
            -- upvalues: target (copy), VfxManager (ref), u2 (copy)
            local v7 = p5:Clone();
            v7.CFrame = target.HumanoidRootPart.CFrame * p6;
            v7.Parent = workspace.Debris;
            VfxManager.Emit(v7);
            table.insert(u2, v7);
        end;

        task.wait(0.1);
        local script_Fall = script.Fall;
        local CFrame_new_ret = CFrame.new(0, -2.5, 0);
        local v8 = script_Fall:Clone();
        v8.CFrame = target.HumanoidRootPart.CFrame * CFrame_new_ret;
        v8.Parent = workspace.Debris;
        VfxManager.Emit(v8);
        table.insert(u2, v8);
    end;

    task.wait(1);

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;