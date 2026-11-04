  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local _ = Players.LocalPlayer;

local function getRelativeOffset(p1, p2) -- Line: 20
    return p1:ToObjectSpace(p2);
end;

return function(p3) -- Line: 24
    -- upvalues: SpectatorController (copy), Debris (copy), EmitModule (copy)
    local Char = p3.Char;

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

    local v4 = script.StartUpEmit:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(
        0.268997192,
        -1.05757976,
        0.958911896,
        0.040637739,
        0,
        -0.999174118,
        0,
        1,
        0,
        0.999174118,
        0,
        0.0406377502
    ));
    v4.Parent = workspace.Debris;
    Debris:AddItem(v4, 2);
    EmitModule.emit(v4);
    task.wait(0.4);
    local v5 = script.StartDash:Clone();
    v5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(
        0.268997192,
        -1.05757976,
        0.958911896,
        0.040637739,
        0,
        -0.999174118,
        0,
        1,
        0,
        0.999174118,
        0,
        0.0406377502
    ));
    v5.Parent = workspace.Debris;
    Debris:AddItem(v5, 2);
    EmitModule.emit(v5);
    task.wait(0.08);
    local v6 = script.StartDash:Clone();
    v6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(
        -0.312255859,
        -0.457579851,
        31.5015621,
        0.040637739,
        0,
        -0.999174118,
        0,
        1,
        0,
        0.999174118,
        0,
        0.0406377502
    ));
    v6.Parent = workspace.Debris;
    Debris:AddItem(v6, 2);
    EmitModule.emit(v6);
end;