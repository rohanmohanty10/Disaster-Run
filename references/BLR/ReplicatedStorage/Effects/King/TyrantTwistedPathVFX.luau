  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 20
    -- upvalues: SpectatorController (copy), EmitModule (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), RunService (copy)
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

    local function CreateEffect(p3, p4) -- Line: 35
        -- upvalues: HumanoidRootPart (copy), EmitModule (ref), u2 (copy)
        local v5 = p3:Clone();
        v5:PivotTo(HumanoidRootPart.CFrame * (p4 or CFrame.new(0, 0, 0)));
        v5.Parent = workspace.Debris;
        EmitModule.emit(v5);
        table.insert(u2, v5);

        return v5;
    end;

    local function ScreenEffect() -- Line: 47
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 60, 100)
            }):Play();
            task.delay(0.1, function() -- Line: 51
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    CreateEffect(script.Startup, CFrame.new(0, -2.5, 0));
    local u6 = CreateEffect(script.dashpart.shotcharge.StartupSimple);
    local v7 = RunService.Heartbeat:Connect(function() -- Line: 61
        -- upvalues: u6 (copy), HumanoidRootPart (copy)
        u6:PivotTo(HumanoidRootPart.CFrame);
    end);
    task.wait(0.8);
    CreateEffect(script.Startup, CFrame.new(0, -2.5, 0));
    local u8 = CreateEffect(script.dashpart2.shotcharge.StartupSimple);
    RunService.Heartbeat:Connect(function() -- Line: 71
        -- upvalues: u8 (copy), HumanoidRootPart (copy)
        u8:PivotTo(HumanoidRootPart.CFrame);
    end);
    task.wait(2);
    v7:Disconnect();

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;