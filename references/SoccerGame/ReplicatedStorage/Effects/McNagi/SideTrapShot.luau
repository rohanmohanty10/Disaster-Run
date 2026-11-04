  

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
    -- upvalues: SpectatorController (copy), SoundManager (copy), VfxManager (copy), Debris (copy), ReplicatedStorage (copy), CameraController (copy), TweenService (copy), Lighting (copy)
    local Char = p1.Char;
    local LocalPlayer = game.Players.LocalPlayer;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("McNagiSideTrapShot", 0.9, Char.HumanoidRootPart, 130, false);
    task.delay(0.13333333333333333, function() -- Line: 17
        -- upvalues: Char (copy), VfxManager (ref), Debris (ref)
        local v2 = script.TrapDash:Clone();
        v2.CFrame = Char.HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0);
        v2.Parent = workspace.Debris;
        VfxManager.Emit(v2);
        Debris:AddItem(v2, 5);
    end);
    task.delay(0.7999999999999999, function() -- Line: 25
        -- upvalues: ReplicatedStorage (ref), VfxManager (ref), Debris (ref), Char (copy), LocalPlayer (copy), CameraController (ref), TweenService (ref), Lighting (ref)
        local v3 = script.TrapKick:Clone();
        v3.CFrame = ReplicatedStorage.Football.Value.BallAnims.BALL.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
        v3.Parent = workspace.Debris;
        VfxManager.Emit(v3);
        Debris:AddItem(v3, 5);

        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            CameraController:Shake("Hit");
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.new(1, 0.298039, 0.309804)
            }):Play();
            task.delay(0.1, function() -- Line: 35
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end);
end;