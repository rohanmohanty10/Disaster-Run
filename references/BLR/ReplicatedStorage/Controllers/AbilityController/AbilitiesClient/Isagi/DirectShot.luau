  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local DirectShot = require(ReplicatedStorage.AbilityBalancing).DirectShot;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function(u1, p2, p3) -- Line: 19, Name: DirectShot
    -- upvalues: Players (copy), ReplicatedStorage (copy), DirectShot (copy), TweenService (copy), Debris (copy), workspace_CurrentCamera (copy)
    if p2:GetAttribute("CRRequest") ~= "IsagiBachiraCR" then
        if u1.AbilityOne > tick() then
            return;
        end;

        if p3.Values.HasBall.Value == false then
            return;
        end;

        if u1.ABC then
            u1.ABC:Clean();
        end;

        if p2.PlayerStats.InAwakening.Value then
            u1:AbilityCooldown("1", 15);
        else
            u1:AbilityCooldown("1", DirectShot.Cooldown);
        end;

        u1.Camera.Cutscene = true;
        local v4 = TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            FieldOfView = 95
        });
        v4:Play();
        Debris:AddItem(v4, 0.5);
        u1.StatesController.States.Ability = true;
        u1.Animations:StopAnims();
        u1.Animations.Abilities.DirectShot.Priority = Enum.AnimationPriority.Action4;
        u1.Animations.Abilities.DirectShot:Play();
        u1.Animations.Ball.DirectShot:Play();
        u1.AbilityService.Ability:Fire("DirectShot");
        local v5 = TweenService:Create(p3.Humanoid, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CameraOffset = Vector3.new(2, 2, -1)
        });
        v5:Play();
        Debris:AddItem(v5, 0.8);
        task.delay(0.835, function() -- Line: 125
            -- upvalues: u1 (copy), TweenService (ref), Debris (ref)
            game.Lighting.ColorCorrection.Contrast = -10;
            game.Lighting.ColorCorrection.Saturation = -1;
            task.delay(0.05, function() -- Line: 130
                game.Lighting.ColorCorrection.Contrast = 10;
                game.Lighting.ColorCorrection.Saturation = -1;
            end);
            task.delay(0.1, function() -- Line: 135
                game.Lighting.ColorCorrection.Contrast = 0.25;
                game.Lighting.ColorCorrection.Saturation = 0.5;
            end);
            task.delay(0.25, function() -- Line: 140
                -- upvalues: u1 (ref), TweenService (ref), Debris (ref)
                u1.StatesController.States.Ability = false;
                u1.Camera.Cutscene = false;
                local v6 = TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    FieldOfView = 70
                });
                v6:Play();
                Debris:AddItem(v6, 0.7);
            end);
        end);
        u1.ABC:Connect(u1.AbilityService.Ability, function(p7, p8) -- Line: 151
            -- upvalues: u1 (copy), workspace_CurrentCamera (ref), DirectShot (ref)
            u1.ABC:Clean();
            u1.StatesController.States.Ability = false;
            p7.AssemblyLinearVelocity = (workspace_CurrentCamera.CFrame.LookVector + DirectShot.ShotTiltVector) * DirectShot.ShotPower;
            u1.BallController:DragBall(p7);
        end);

        return;
    end;

    local Attribute = p2:GetAttribute("CRRequestToken");
    local Attribute2 = p2:GetAttribute("CRSender");
    local PlayerStats = p2:FindFirstChild("PlayerStats");
    local v9;

    if PlayerStats then
        v9 = PlayerStats:FindFirstChild("Style");
    else
        v9 = PlayerStats;
    end;

    if PlayerStats then
        PlayerStats = PlayerStats:FindFirstChild("InAwakening");
    end;

    local v10;

    if p3 then
        v10 = p3:FindFirstChildOfClass("Humanoid");
    else
        v10 = p3;
    end;

    local v11;

    if p3 then
        v11 = p3:FindFirstChild("Values");
    else
        v11 = p3;
    end;

    local v12;

    if v11 then
        v12 = v11:FindFirstChild("HasBall");
    else
        v12 = v11;
    end;

    if v11 then
        v11 = v11:FindFirstChild("InCutscene");
    end;

    local v13;

    if typeof(Attribute2) == "number" then
        v13 = Players:GetPlayerByUserId(Attribute2) or nil;
    else
        v13 = nil;
    end;

    local v14;

    if v13 then
        v14 = v13.Character;
    else
        v14 = v13;
    end;

    local v15;

    if v14 then
        v15 = v14:FindFirstChildOfClass("Humanoid");
    else
        v15 = v14;
    end;

    local v16;

    if v13 then
        v16 = v13:FindFirstChild("PlayerStats");
    else
        v16 = v13;
    end;

    local v17;

    if v16 then
        v17 = v16:FindFirstChild("Style");
    else
        v17 = v16;
    end;

    if v16 then
        v16 = v16:FindFirstChild("InAwakening");
    end;

    local Value = ReplicatedStorage.Football.Value;
    local v18;

    if Value then
        v18 = Value:FindFirstChild("Char");
    else
        v18 = Value;
    end;

    local v19;

    if Value then
        v19 = Value:FindFirstChild("OnPlayer");
    else
        v19 = Value;
    end;

    local v20;

    if Value then
        v20 = Value:GetAttribute("IsagiBachiraCRDeadline");
    else
        v20 = Value;
    end;

    if typeof(Attribute) ~= "string" or not (v13 and (v13 ~= p2 and (p2.Team and (v13.Team == p2.Team and (p2.Character == p3 and (v10 and (v10.Health > 0 and (v9 and (v9.Value == "Isagi" and (PlayerStats and (PlayerStats.Value and (not p2:GetAttribute("IsagiBachiraCRUsed") and (v12 and (not v12.Value and (v11 and (not v11.Value and (v14 and (v13.Character == v14 and (Players:GetPlayerFromCharacter(v14) == v13 and (v15 and (v15.Health > 0 and (v17 and (v17.Value == "Bachira" and (v16 and (not v16.Value and (Value and (Value.Parent == workspace and (Value:GetAttribute("IsagiBachiraCRToken") == Attribute and (typeof(v20) == "number" and (v20 >= workspace:GetServerTimeNow() and (v18 and (v18.Value == v14 and (v19 and not v19.Value))))))))))))))))))))))))))))))))) then
        return;
    end;

    local v21 = u1.UngroupedAbilities and u1.UngroupedAbilities.IsagiBachiraCRReceiver;

    if v21 then
        v21(u1, p2, p3, v14, Attribute);
    end;
end;