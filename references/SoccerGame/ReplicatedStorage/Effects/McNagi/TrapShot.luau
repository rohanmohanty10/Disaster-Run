  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), SoundManager (copy), ReplicatedStorage (copy), VfxManager (copy), Debris (copy), CameraController (copy), TweenService (copy), Lighting (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    SoundManager.SpawnSound("McNagiTrapShot", 0.7, Char.HumanoidRootPart, 130, false);
    local LocalPlayer = game.Players.LocalPlayer;
    task.wait(0.75);
    local v2 = script.TrapKick:Clone();
    v2.CFrame = ReplicatedStorage.Football.Value.BallAnims.BALL.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 12);

    if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
        CameraController:Shake("Hit");
        TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
            TintColor = Color3.new(1, 0.298039, 0.309804)
        }):Play();
        task.delay(0.1, function() -- Line: 29
            -- upvalues: TweenService (ref), Lighting (ref)
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                TintColor = Color3.new(1, 1, 1)
            }):Play();
        end);
    end;
end;