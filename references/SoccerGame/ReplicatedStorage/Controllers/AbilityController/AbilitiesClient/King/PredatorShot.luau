  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);

return function(u1, p2, p3) -- Line: 19, Name: KingsImpact
    -- upvalues: AbilityUtils (copy), TweenService (copy), Debris (copy), AbilityBalancing (copy), ReplicatedStorage (copy)
    if p3.Values.HasBall.Value == false then
        return;
    end;

    if not AbilityUtils.rules.grounded() then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    local u4 = false;
    local v5 = p2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");
    local UIScale = v5:FindFirstChild("UIScale");
    v5.ImageColor3 = Color3.fromRGB(255, 255, 255);
    UIScale.Scale = 1;
    p3:SetAttribute("KingsDribbleShot", nil);
    u1.KingsDribbleShot = nil;
    u1.Camera.Cutscene = true;
    TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(1.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        FieldOfView = 105
    }):Play();
    local v6 = TweenService:Create(p3.Humanoid, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CameraOffset = Vector3.new(2, 2, -1)
    });
    v6:Play();
    Debris:AddItem(v6, 0.8);
    u1:AbilityCooldown("2", 50);
    u1.StatesController.States.Ability = true;
    u1.Animations:StopAnims();
    u1.Animations.Abilities.KingsImpact.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.KingsImpact:Play();

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.AbilityService.Ability:Fire("KingsDribble", {
        Action = "Shoot"
    });
    local u7 = nil;
    u1.ABC:Add(task.delay(2, function() -- Line: 64
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end));
    u1.ABC:Add(function() -- Line: 68
        -- upvalues: u4 (ref), u1 (copy)
        u4 = true;
        u1.StatesController.States.Ability = false;
        u1.Camera.Cutscene = false;
    end);
    u1.ABC:Connect(u1.AbilityService.Ability, function(p8) -- Line: 74
        -- upvalues: u7 (ref), TweenService (ref), Debris (ref), AbilityBalancing (ref), u1 (copy), ReplicatedStorage (ref)
        u7 = p8 or workspace:WaitForChild("Football", 1);
        game.Lighting.ColorCorrection.Contrast = -10;
        game.Lighting.ColorCorrection.Saturation = -1;
        task.delay(0.05, function() -- Line: 80
            game.Lighting.ColorCorrection.Contrast = 10;
            game.Lighting.ColorCorrection.Saturation = -1;
        end);
        task.delay(0.1, function() -- Line: 85
            game.Lighting.ColorCorrection.Contrast = 0.15;
            game.Lighting.ColorCorrection.Saturation = 0.5;
        end);
        task.delay(0.25, function() -- Line: 90
            -- upvalues: TweenService (ref), Debris (ref)
            local v9 = TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                FieldOfView = 70
            });
            v9:Play();
            Debris:AddItem(v9, 0.7);
        end);
        u7.AssemblyLinearVelocity = (game.Workspace.CurrentCamera.CFrame.LookVector + AbilityBalancing.PredatorShot.ShotTiltVector) * AbilityBalancing.PredatorShot.ShotPower;
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        task.wait(0.5);
        u1.ABC:Clean();
    end);
end;