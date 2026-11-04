  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SpectatorController (copy), SoundManager (copy), VfxManager (copy), TweenService (copy), Debris (copy), CameraController (copy), Lighting (copy)
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

    if p1.State ~= "Start" then
        if p1.State == "Shot" then
            local v2 = script.New.ReoKick:Clone();
            v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -2);
            v2.Parent = workspace.Debris;
            VfxManager.Emit(v2);
            task.wait(2);
            v2:Destroy();
        end;

        return;
    end;

    Char:FindFirstChild("Football");
    Char:FindFirstChild("BALL", true);
    SoundManager.SpawnSound("ReoElastico", 0.7, workspace, 150);
    task.wait(0.15);
    local v3 = script.New.Debree:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    local u4 = script.New.Dashes:Clone();
    u4:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    u4.Parent = workspace.Debris;
    VfxManager.Emit(u4);

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("Beam") then
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Width0 = Width0
            }):Play();
            TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Width0 = Width1
            }):Play();
        end;
    end;

    task.delay(0.25, function() -- Line: 62
        -- upvalues: u4 (copy), TweenService (ref), VfxManager (ref)
        for _, descendant in u4:GetDescendants() do
            if descendant:IsA("Beam") then
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Width0 = 0
                }):Play();
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Width0 = 0
                }):Play();
            end;
        end;

        VfxManager.Enable(u4, false);
    end);
    task.wait(0.5);
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -1, 0) * CFrame.Angles(0, 3.141592653589793, 0);
    VfxManager.Emit(v3);
    local v5 = script.New["Charmelaon Dash"]:Clone();
    v5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0, -5));
    v5.Parent = workspace.Debris;
    VfxManager.Emit(v5);
    Debris:AddItem(v5, 2);
    CameraController:Shake("Hit");
    TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
        TintColor = Color3.new(0.584314, 0.419608, 1)
    }):Play();
    task.delay(0.2, function() -- Line: 102
        -- upvalues: TweenService (ref), Lighting (ref)
        TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.8), {
            TintColor = Color3.new(1, 1, 1)
        }):Play();
    end);
    task.wait(2);
    u4:Destroy();
    v5:Destroy();
    v3:Destroy();
end;