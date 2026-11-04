  

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
    -- upvalues: SpectatorController (copy), VfxManager (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy)
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
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0);
        v4.Parent = workspace.Debris;
        VfxManager.Emit(v4);
        table.insert(u2, v4);
    end;

    local function ScreenEffect() -- Line: 44
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 60, 100)
            }):Play();
            task.delay(0.1, function() -- Line: 48
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    task.wait(0.15);
    local v5 = script.Wind_Beams:Clone();
    v5.Parent = workspace.Debris;
    table.insert(u2, v5);
    local Weld = Instance.new("Weld");
    Weld.Part0 = HumanoidRootPart;
    Weld.Part1 = v5;
    Weld.C0 = CFrame.new(0, 0, -5) * CFrame.fromOrientation(1.5707963267948966, 3.141592653589793, 0);
    Weld.Parent = v5;
    VfxManager.Emit(v5);

    for _, descendant in pairs(v5:GetDescendants()) do
        if descendant:GetAttribute("EmitDuration") then
            descendant.Enabled = true;
            task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 71
                -- upvalues: descendant (copy), TweenService (ref)
                if descendant:IsA("Beam") then
                    TweenService:Create(descendant, TweenInfo.new(0.4), {
                        Width1 = 0
                    }):Play();
                    task.wait(0.4);
                end;

                descendant.Enabled = false;
            end);
        end;
    end;

    local v6 = script.Start:Clone();
    v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0);
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
    table.insert(u2, v6);
    ScreenEffect();
    task.wait(0.45);
    local v7 = script.End:Clone();
    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0);
    v7.Parent = workspace.Debris;
    VfxManager.Emit(v7);
    table.insert(u2, v7);
    task.wait(2);

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;