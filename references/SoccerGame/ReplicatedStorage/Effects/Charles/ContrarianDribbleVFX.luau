  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
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
    -- upvalues: SpectatorController (copy), SoundManager (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy)
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

    SoundManager.SpawnSound("ContrarianDribble", 0.7, Char.HumanoidRootPart, 130, false);
    local v2 = p1.DartboardLens and 1.5 or 1;
    local u3 = {};

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

    local function CreateEffect(p4, p5) -- Line: 49
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u3 (copy)
        local v6 = p4:Clone();
        v6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.6, 0) * CFrame.Angles(0, math.rad(p5 or 0), 0));
        v6.Parent = workspace.Debris;
        VfxManager.Emit(v6);
        table.insert(u3, v6);
    end;

    local v7 = script.charlesballvfx:Clone();
    v7.Parent = workspace.Debris;
    table.insert(u3, v7);
    local Weld = Instance.new("Weld");
    Weld.Part0 = Char.Torso;
    Weld.Part1 = v7;
    Weld.Parent = v7;
    VfxManager.Enable(v7, true);
    task.wait(0.247 / v2);
    ScreenEffect();
    CreateEffect(script.charlespassvfx);
    CreateEffect(script.charlesdribbleenablefx, 45);
    task.wait(0.475 / v2);
    ScreenEffect();
    CreateEffect(script.charlespassvfx);
    CreateEffect(script.charlesdribbleenablefx, -45);
    task.wait(0.666 / v2);
    ScreenEffect();
    CreateEffect(script.charlespassvfx);
    CreateEffect(script.charlesdribbleenablefx, 0);
    task.wait(0.533 / v2);
    CreateEffect(script.charlesdribbleemit4);
    VfxManager.Enable(v7, false);
    task.wait(3);

    for _, v in pairs(u3) do
        v:Destroy();
    end;
end;