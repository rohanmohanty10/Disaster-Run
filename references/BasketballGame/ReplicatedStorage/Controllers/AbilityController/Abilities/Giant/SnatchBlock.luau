 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p6) -- Line: 21, Name: SnatchBlock
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), RunService (copy), Effects (copy), TweenService (copy), Essentials (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local Attribute = LocalPlayer:GetAttribute("TrueGiant");
    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u5 = p6.Network;

    if u5.CharValues.HasBall then
        local v7 = p6:CheckInfront(30);

        if v7 == nil and RunService:IsStudio() then
            v7 = workspace.DefenseRig;
        end;

        if not v7 then
            p6:ResetCD(2);
            Effects:Popup("Someone must be infront of you!");

            return;
        end;

        u2.States.Ability = true;
        task.delay(0.5, function() -- Line: 41
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
        end);
        task.spawn(function() -- Line: 45
            -- upvalues: TweenService (ref)
            local workspace_CurrentCamera = workspace.CurrentCamera;
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
                FieldOfView = 100
            }):Play();
            task.delay(0.3, function() -- Line: 49
                -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
                TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
                    FieldOfView = 70
                }):Play();
            end);
        end);
        u3:StopAll();
        u3:PlayChar("Giant", `Charge{Essentials:ReturnRorL(u5.CharValues)}`, Enum.AnimationPriority.Action3);
        u3:PlayBall("Giant", `Charge{Essentials:ReturnRorL(u5.CharValues)}Ball`, Enum.AnimationPriority.Action3);
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
        LinearVelocity.MaxForce = 40000;
        LinearVelocity.Parent = HumanoidRootPart;
        task.delay(0.1, function() -- Line: 63
            -- upvalues: LinearVelocity (copy)
            LinearVelocity:Destroy();
        end);
        local Position = v7.HumanoidRootPart.Position;
        LinearVelocity.VectorVelocity = (Vector3.new(Position.X, HumanoidRootPart.Position.Y, Position.Z) - HumanoidRootPart.Position).Unit * 150;
        u1.Ability:Fire("SnatchBlock", {
            TimeSent = workspace:GetServerTimeNow(),
            Other = v7
        });

        return;
    end;

    if u5.Gamemode == "Match-2v2" and (p6.Pass.BarrierWasOn and p6.Pass.BarrierWasOn + 0.5 > tick()) then
        p6:ResetCD(2);

        return;
    end;

    if not Attribute and u5.CharValues.Blocked + 2 > tick() then
        p6:ResetCD(2);
        Effects:Popup("Can\'t use after block!");

        return;
    end;

    u2.States.Ability = true;
    u2.Boost = Attribute and 50 or 25;
    task.delay(1, function() -- Line: 77
        -- upvalues: u2 (ref)
        u2.Boost = 0;
        u2.States.Ability = false;
    end);
    u3:StopAll();
    u3:PlayChar("Giant", "Ability2", Enum.AnimationPriority.Action3);
    task.spawn(function() -- Line: 82
        -- upvalues: TweenService (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
            FieldOfView = 100
        }):Play();
        task.delay(0.3, function() -- Line: 86
            -- upvalues: TweenService (ref), workspace_CurrentCamera (copy)
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
                FieldOfView = 70
            }):Play();
        end);
    end);
    local LinearVelocity = Instance.new("LinearVelocity");
    LinearVelocity.Attachment0 = HumanoidRootPart.RootAttachment;
    LinearVelocity.MaxForce = 40000;
    LinearVelocity.Parent = HumanoidRootPart;
    task.delay(0.05, function() -- Line: 95
        -- upvalues: LinearVelocity (copy)
        LinearVelocity:Destroy();
    end);
    local ServerBallPosition = u4:GetServerBallPosition();
    local Vector3_new_ret = Vector3.new(ServerBallPosition.X, HumanoidRootPart.Position.Y, ServerBallPosition.Z);
    local v8;

    if Vector3_new_ret:FuzzyEq(HumanoidRootPart.Position) then
        v8 = Vector3.new();
    else
        v8 = (Vector3_new_ret - HumanoidRootPart.Position).Unit;
    end;

    LinearVelocity.VectorVelocity = (HumanoidRootPart.CFrame.LookVector / 2 + Vector3.new(0, 1, 0) + v8) * 45;
    u1.Ability:Fire("SnatchBlock", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;