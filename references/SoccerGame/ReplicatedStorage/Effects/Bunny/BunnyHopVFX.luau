  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
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
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy), RunService (copy)
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
                TintColor = Color3.fromRGB(255, 92, 95)
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
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
        v4.Parent = workspace.Debris;
        VfxManager.Emit(v4);
        table.insert(u2, v4);
    end;

    local v5 = script.StartupEmit:Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
    v5.Parent = workspace.Debris;
    VfxManager.Emit(v5);
    table.insert(u2, v5);
    task.wait(0.4);
    ScreenEffect();
    local v6 = script.DashEmit1:Clone();
    v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
    table.insert(u2, v6);
    local u7 = script.EnableDash:Clone();
    u7.Parent = workspace.Debris;
    table.insert(u2, u7);
    VfxManager.Enable(u7, true);
    local v8 = RunService.Heartbeat:Connect(function() -- Line: 68
        -- upvalues: u7 (copy), Char (copy)
        u7.CFrame = Char.HumanoidRootPart.CFrame;
    end);
    task.wait(3.2);
    VfxManager.Enable(u7, false);
    v8:Disconnect();
    local v9 = script.EndDash:Clone();
    v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
    v9.Parent = workspace.Debris;
    VfxManager.Emit(v9);
    table.insert(u2, v9);
    task.wait(1);

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;