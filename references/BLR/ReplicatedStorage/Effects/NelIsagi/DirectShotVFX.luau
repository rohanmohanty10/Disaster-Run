  

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
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy)
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

    local _ = p1.DartboardLens;
    local v2 = {};

    local function ScreenEffect() -- Line: 37
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(162, 173, 252)
            }):Play();
            task.delay(0.1, function() -- Line: 41
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    ScreenEffect();
    local Folder = Instance.new("Folder");
    Folder.Name = "NELIsagiHighlight";
    Folder.Parent = Char;
    local v3 = script.StartUpEmit:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -1.08, 0));
    v3.Parent = workspace.Debris;
    table.insert(v2, v3);
    VfxManager.Emit(v3);
    task.wait(0.55);
    ScreenEffect();
    local v4 = script.ShotEmit:Clone();
    v4:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0));
    v4.Parent = workspace.Debris;
    table.insert(v2, v4);
    VfxManager.Emit(v4);
    Folder:Destroy();
    task.wait(3);

    for _, v in pairs(v2) do
        v:Destroy();
    end;
end;