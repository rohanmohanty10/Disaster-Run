  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), VfxManager (copy), Lighting (copy), TweenService (copy), SoundManager (copy), Debris (copy)
    local Char = p1.Char;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local u2 = script.Dribble:Clone();
    u2:PivotTo(Char.HumanoidRootPart.CFrame);
    u2.Parent = workspace.Debris;
    local v3 = game["Run Service"].Heartbeat:Connect(function() -- Line: 24
        -- upvalues: u2 (copy), Char (copy)
        u2:PivotTo(Char.HumanoidRootPart.CFrame);
    end);
    VfxManager.Emit(u2);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");

    if ColorCorrection then
        TweenService:Create(ColorCorrection, TweenInfo.new(0.2), {
            TintColor = Color3.new(1, 0.411765, 0.411765)
        }):Play();
    end;

    if p1.OffBall then
        SoundManager.SpawnSound("Chop Feast", 0.7, Char.Torso, 150);
        task.wait(0.5);
        task.delay(0.35, function() -- Line: 38
            -- upvalues: Char (copy), VfxManager (ref), Debris (ref)
            local v4 = script.Shoot:Clone();
            v4.CFrame = Char.HumanoidRootPart.CFrame;
            v4.Parent = workspace.Debris;
            VfxManager.Emit(v4);
            Debris:AddItem(v4, 2);
        end);
    else
        SoundManager.SpawnSound("Chop Dribble", 0.7, Char.Torso, 150);
        task.wait(1);
    end;

    local ColorCorrection2 = Lighting:FindFirstChild("ColorCorrection");

    if ColorCorrection2 then
        TweenService:Create(ColorCorrection2, TweenInfo.new(0.3), {
            TintColor = Color3.new(1, 1, 1)
        }):Play();
    end;

    VfxManager.Enable(u2, false);
    task.wait(2);
    u2:Destroy();
    v3:Disconnect();
end;