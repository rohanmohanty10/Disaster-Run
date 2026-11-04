  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
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
    -- upvalues: SpectatorController (copy), SoundManager (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy), RunService (copy)
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

    SoundManager.SpawnSound("SkyArcPass", 0.7, Char.HumanoidRootPart, 130, false);
    local _ = p1.DartboardLens;
    local v2 = {};

    local function ScreenEffect() -- Line: 39
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 235, 83)
            }):Play();
            task.delay(0.1, function() -- Line: 43
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    local v3 = script.Kick5:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.55, -1.3);
    v3.Parent = workspace.Debris;
    table.insert(v2, v3);
    VfxManager.Emit(v3);
    task.wait(0.4);
    local u4 = script.Charge:Clone();
    u4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.55, -1.3);
    u4.Parent = workspace.Debris;
    table.insert(v2, u4);
    VfxManager.Enable(u4, true);
    local v5 = RunService.Heartbeat:Connect(function() -- Line: 65
        -- upvalues: u4 (copy), HumanoidRootPart (copy)
        u4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.55, -1.3);
    end);
    task.wait(0.55);
    v5:Disconnect();
    VfxManager.Enable(u4, false);
    ScreenEffect();
    local v6 = script.Shot:Clone();
    v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.55, -1.3);
    v6.Parent = workspace.Debris;
    table.insert(v2, v6);
    VfxManager.Emit(v6);
    task.wait(3);

    for _, v in pairs(v2) do
        v:Destroy();
    end;
end;