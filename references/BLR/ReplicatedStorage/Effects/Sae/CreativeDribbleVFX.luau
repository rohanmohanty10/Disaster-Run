  

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

    local function CreateSaeTouch() -- Line: 34
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u2 (copy)
        local v3 = script.SaeTouch:Clone();
        v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, -1);
        v3.Parent = workspace.Debris;
        VfxManager.Emit(v3);
        table.insert(u2, v3);
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

    local function CreateEffect(p4) -- Line: 54
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u2 (copy)
        local v5 = p4:Clone();
        v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0);
        v5.Parent = workspace.Debris;
        VfxManager.Emit(v5);
        table.insert(u2, v5);
    end;

    local v6 = script.SaeBallTrail:Clone();
    v6.Parent = workspace.Debris;
    table.insert(u2, v6);
    local Weld = Instance.new("Weld");
    Weld.Part0 = HumanoidRootPart;
    Weld.Part1 = v6;
    Weld.Parent = v6;
    VfxManager.Enable(v6, true);
    task.wait(0.1);
    local v7 = script.Start:Clone();
    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0);
    v7.Parent = workspace.Debris;
    VfxManager.Emit(v7);
    table.insert(u2, v7);
    ScreenEffect();
    local v8 = script.Start:Clone();
    v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0);
    v8.Parent = workspace.Debris;
    VfxManager.Emit(v8);
    table.insert(u2, v8);
    task.wait(0.3);
    ScreenEffect();
    local v9 = script.Start:Clone();
    v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0);
    v9.Parent = workspace.Debris;
    VfxManager.Emit(v9);
    table.insert(u2, v9);
    task.wait(0.6);

    if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
        TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
            TintColor = Color3.fromRGB(255, 60, 100)
        }):Play();
        task.delay(0.4, function() -- Line: 95
            -- upvalues: TweenService (ref), Lighting (ref)
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                TintColor = Color3.new(1, 1, 1)
            }):Play();
        end);
    end;

    local v10 = script.End:Clone();
    v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0);
    v10.Parent = workspace.Debris;
    VfxManager.Emit(v10);
    table.insert(u2, v10);
    VfxManager.Enable(v6, false);
    local v11 = script.SaeTouch:Clone();
    v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, -1);
    v11.Parent = workspace.Debris;
    VfxManager.Emit(v11);
    table.insert(u2, v11);
    local v12 = script.Wind_Beams:Clone();
    v12.Parent = workspace.Debris;
    local Weld2 = Instance.new("Weld");
    Weld2.Part0 = HumanoidRootPart;
    Weld2.Part1 = v12;
    Weld2.C0 = CFrame.new(0, 0, -5) * CFrame.fromOrientation(1.5707963267948966, 3.141592653589793, 0);
    table.insert(u2, v12);
    Weld2.Parent = v12;
    VfxManager.Emit(v12);

    for _, descendant in pairs(v12:GetDescendants()) do
        if descendant:GetAttribute("EmitDuration") then
            descendant.Enabled = true;
            task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 121
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

    task.wait(0.4);
    local v13 = script.End:Clone();
    v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0);
    v13.Parent = workspace.Debris;
    VfxManager.Emit(v13);
    table.insert(u2, v13);
    task.wait(2);

    for _, v in pairs(u2) do
        v:Destroy();
    end;
end;