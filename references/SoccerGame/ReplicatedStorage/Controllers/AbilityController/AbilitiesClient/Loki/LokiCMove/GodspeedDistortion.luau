  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.FilterDescendantsInstances = {
    workspace.Field,
    workspace.Colliders,
    workspace.Goals,
    workspace.SmallSquare
};

return function(u1, u2, u3, u4) -- Line: 25
    -- upvalues: AbilityUtils (copy), TweenService (copy), ReplicatedStorage2 (copy), AbilityBalancing (copy), RaycastParams_new_ret (copy)
    if not u2.Character.Values.HasBall.Value then
        return;
    end;

    local v5 = u2.PlayerStats.InAwakening.Value == true;
    local u6 = v5 and 125 or 100;
    AbilityUtils.clearMovers(u3);
    u1.StatesController.States.Ability = true;
    u1.StatesController.OwnWalkState = true;
    u1.ABC:Add(function() -- Line: 35
        -- upvalues: u1 (copy), u4 (copy), u2 (copy), TweenService (ref), u3 (copy)
        u1.StatesController.States.Ability = false;
        u1.StatesController.OwnWalkState = false;

        if u1.LokiDashCharges == nil and (not u4 and (u1.GearShift and u2.PlayerStats.InAwakening.Value)) then
            u1.Camera.Cutscene = true;
            u1.StatesController.OwnWalkState = true;
            TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.6), {
                FieldOfView = 20
            }):Play();
            task.delay(0.6, function() -- Line: 48
                -- upvalues: u1 (ref), u3 (ref), u2 (ref)
                u1.Camera.Cutscene = false;
                u1.StatesController.OwnWalkState = false;
                u1.LokiBlackFlash = true;
                u3:SetAttribute("LokiBlackFlash", true);
                local v7 = u2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("2");

                if v7 then
                    local UIScale = v7:FindFirstChild("UIScale");
                    UIScale.Scale = 1.25;
                    v7.ImageColor3 = Color3.fromRGB(255, 0, 0);
                    u1.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Scale = 1
                    });
                    u1.UITween1:Play();
                    u1.UITween2 = game:GetService("TweenService"):Create(v7, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageColor3 = Color3.fromRGB(255, 255, 255)
                    });
                    u1.UITween2:Play();
                    task.delay(0.5, function() -- Line: 68
                        -- upvalues: u3 (ref), u1 (ref)
                        u3:SetAttribute("LokiBlackFlash", nil);
                        u1.UITween2 = nil;
                        u1.UITween1 = nil;
                        u1.LokiBlackFlash = nil;
                    end);
                end;
            end);

            if u1.LokiDashCharges == nil and u2.PlayerStats.InAwakening.Value then
                u3:SetAttribute("GodspeedShot", true);
                local _ = u2.PlayerStats.Style.Value;
                local v8 = u2.PlayerGui.InGameUI.Bottom.Abilities:FindFirstChild("1");

                if v8 then
                    local UIScale = v8:FindFirstChild("UIScale");
                    UIScale.Scale = 1.25;
                    v8.ImageColor3 = Color3.fromRGB(255, 0, 0);
                    u1.UITween1 = game:GetService("TweenService"):Create(UIScale, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Scale = 1
                    });
                    u1.UITween1:Play();
                    u1.UITween2 = game:GetService("TweenService"):Create(v8, TweenInfo.new(0.85, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        ImageColor3 = Color3.fromRGB(255, 255, 255)
                    });
                    u1.UITween2:Play();
                    task.delay(2, function() -- Line: 96
                        -- upvalues: u1 (ref), u3 (ref)
                        u1.UITween2 = nil;
                        u1.UITween1 = nil;
                        u1:AbilityCooldown("1", 10);

                        if not u3:GetAttribute("GodspeedShot") then
                            return;
                        end;

                        u3:SetAttribute("GodspeedShot", nil);
                    end);
                end;
            end;
        end;
    end);
    u1.Animations:StopAnims();
    u1.Animations.Abilities.GodspeedDistortion.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.GodspeedDistortion:Play();
    u1.AbilityService.Ability:Fire("GodspeedDistortion", {
        Type = "Start"
    });
    local CFrame = u3.HumanoidRootPart.CFrame;

    if u1.GearShift then
        u1.Animations.Abilities.GodspeedDistortion.TimePosition = 0.5;
        task.delay(0.5, function() -- Line: 136
            -- upvalues: u1 (copy)
            u1.ABC:Clean();
        end);
    else
        task.wait(0.2);
        CFrame = u3.HumanoidRootPart.CFrame;
        u1.ABC:Connect(u1.AbilityService.Ability, function(p9) -- Line: 123
            -- upvalues: u1 (copy), CFrame (ref), u6 (copy)
            u1.ABC:Clean();
            p9.AssemblyLinearVelocity = (CFrame.LookVector + Vector3.new(0, 0.1, 0)) * u6;
            u1.BallController:DragBall(p9);
        end);
        u1.AbilityService.Ability:Fire("GodspeedDistortion", {
            Type = "Kick"
        });
        task.wait(0.3);
    end;

    if ReplicatedStorage2.Football.Value.OnPlayer.Value and not u1.GearShift then
        return;
    end;

    u1.AbilityService.Ability:Fire("GodspeedDistortion", {
        Type = "Teleport",
        StartCF = CFrame
    });
    local HumanoidRootPart = u3.HumanoidRootPart;
    local AlignPosition = Instance.new("AlignPosition");
    AlignPosition.Attachment0 = u3.HumanoidRootPart.RootAttachment;
    AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment;
    AlignPosition.Responsiveness = 200;
    AlignPosition.MaxForce = 40000;
    AlignPosition.Parent = u3.HumanoidRootPart;
    AlignPosition.Position = u3.HumanoidRootPart.Position;
    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    local Range = AbilityBalancing.GodspeedDistortion.Range;

    if v5 then
        Range = Range * 1.35 or Range;
    end;

    local v10 = HumanoidRootPart.Position + Unit * Range;
    local Position = HumanoidRootPart.Position;
    local v11 = v10 - Position;
    local v12 = workspace:Raycast(Position, v11, RaycastParams_new_ret);

    if v12 then
        v10 = v12.Position - v11.Unit * 2;
    end;

    local Vector3_new_ret = Vector3.new(v10.X, HumanoidRootPart.Position.Y, v10.Z);
    TweenService:Create(AlignPosition, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = Vector3_new_ret
    }):Play();
    task.wait(0.25);
    AlignPosition:Destroy();
end;