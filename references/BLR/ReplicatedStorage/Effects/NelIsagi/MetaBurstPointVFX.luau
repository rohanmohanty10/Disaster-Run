  

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

    local function ScreenEffect() -- Line: 34
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(162, 173, 252)
            }):Play();
            task.delay(0.1, function() -- Line: 38
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    if p1.Type == "Emit" then
        local v2 = script["emit if successful"]:Clone();
        v2:PivotTo(HumanoidRootPart.CFrame);
        v2.Parent = workspace.Debris;
        VfxManager.Emit(v2);
        task.wait(2);
        v2:Destroy();

        return;
    end;

    local v3 = os.clock() + 3;
    local Folder = Instance.new("Folder");
    Folder.Name = "NELIsagiHighlight";
    Folder.Parent = Char;
    Folder:Destroy();
    local u4 = script["too much fun making ts"]:Clone();
    u4.Parent = workspace.Debris;
    VfxManager.Enable(u4, true);
    local v5 = RunService.Heartbeat:Connect(function() -- Line: 69
        -- upvalues: u4 (copy), HumanoidRootPart (copy)
        u4:PivotTo(HumanoidRootPart.CFrame);
    end);

    repeat
        task.wait();
    until Char.Values.Sliding.Value == false or v3 <= os.clock();

    Folder:Destroy();
    v5:Disconnect();
    u4:Destroy();
end;