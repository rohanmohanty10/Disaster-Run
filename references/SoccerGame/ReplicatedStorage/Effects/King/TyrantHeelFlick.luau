  

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
    -- upvalues: SpectatorController (copy), VfxManager (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), RunService (copy)
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

    local function CreateEffect(p3) -- Line: 34
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u2 (copy)
        local v4 = p3:Clone();
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
        v4.Parent = workspace.Debris;
        VfxManager.Emit(v4);
        table.insert(u2, v4);

        return v4;
    end;

    local function ScreenEffect() -- Line: 46
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 60, 100)
            }):Play();
            task.delay(0.1, function() -- Line: 50
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    local script_StartupSimple = script.StartupSimple;
    CFrame.new(0, -2.5, 0);
    local u5 = script_StartupSimple:Clone();
    u5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
    u5.Parent = workspace.Debris;
    VfxManager.Emit(u5);
    table.insert(u2, u5);
    RunService.Heartbeat:Connect(function() -- Line: 58
        -- upvalues: u5 (copy), HumanoidRootPart (copy)
        u5:PivotTo(HumanoidRootPart.CFrame);
    end);
    local v6 = script.StartupSimple:Clone();
    v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
    table.insert(u2, v6);
    task.wait(2);

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;