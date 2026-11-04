  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local FindCurveDirection = require(ReplicatedStorage2.Shared.utils.FindCurveDirection);

return function(u1, p2, p3) -- Line: 21, Name: Surpass
    -- upvalues: Popup (copy), FindCurveDirection (copy), AbilityUtils (copy), RunService (copy), ReplicatedStorage (copy), Players (copy), AbilityBalancing (copy)
    if u1.AbilityThree > tick() then
        return;
    end;

    if u1.AbilityUsed > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    if not p2.PlayerStats.InAwakening.Value then
        if not p3.Values.HasBall.Value then
            return Popup.Popup(p2, "You need the ball!");
        end;

        local v4;

        if p3 then
            v4 = p3:FindFirstChild("HumanoidRootPart");
        else
            v4 = p3;
        end;

        if not v4 then
            return;
        end;

        u1.StatesController.States.Ability = true;
        u1:AbilityCooldown("3", 60);
        u1.Animations:StopAnims();
        local v5 = FindCurveDirection(p2) * 40;
        local Humanoid = p3:FindFirstChild("Humanoid");

        if v4.CFrame:VectorToObjectSpace(Humanoid.MoveDirection).X > 0 then
            u1.Animations.Abilities.BeautifulShotR.Priority = Enum.AnimationPriority.Action4;
            u1.Animations.Abilities.BeautifulShotR:Play();
            u1.Animations.Ball.BeautifulShotR.Priority = Enum.AnimationPriority.Action4;
            u1.Animations.Ball.BeautifulShotR:Play();
        else
            v5 = -v5;
            u1.Animations.Abilities.BeautifulShotL.Priority = Enum.AnimationPriority.Action4;
            u1.Animations.Abilities.BeautifulShotL:Play();
            u1.Animations.Ball.BeautifulShotL.Priority = Enum.AnimationPriority.Action4;
            u1.Animations.Ball.BeautifulShotL:Play();
        end;

        local v6 = p3.HumanoidRootPart.Position + Vector3.new(v5.X, 0, v5.Z);
        AbilityUtils.FastDashTo(p3, v6, -2, 1);
        u1.AbilityService.Ability:Fire("Surpass", { "BeautifulShot" });
        u1.ABC:Connect(u1.AbilityService.Ability, function(u7, u8) -- Line: 67
            -- upvalues: u1 (copy), RunService (ref), ReplicatedStorage (ref)
            u1.StatesController.States.Ability = false;
            u7.AssemblyLinearVelocity = (game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0) + u8 / 2) * 108;
            task.delay(0.1, function() -- Line: 74
                -- upvalues: u1 (ref), RunService (ref), u7 (copy), u8 (copy)
                local u9 = -43;
                u1.ABC:Connect(RunService.Heartbeat, function(p10) -- Line: 77
                    -- upvalues: u9 (ref), u1 (ref), u7 (ref), u8 (ref)
                    u9 = u9 + 35 * p10;

                    if u9 >= -25 then
                        u1.ABC:Clean();
                    end;

                    u7.AssemblyLinearVelocity = u7.AssemblyLinearVelocity:Lerp(u7.AssemblyLinearVelocity + u8 * u9, 6 * p10);
                end);
            end);
            u1.BallController:DragBall(ReplicatedStorage.Football.Value);
        end);
        task.delay(2.5, function() -- Line: 88
            -- upvalues: u1 (copy)
            u1.StatesController.States.Ability = false;

            if u1.ABC then
                u1.ABC:Clean();
            end;
        end);

        return;
    end;

    if not p2.PlayerStats.InAwakening.Value then
        return;
    end;

    if not p2.Character.Values.HasBall.Value then
        return Popup.Popup(p2, "You must have the ball!");
    end;

    print("woahhh");
    local Players2 = Players:GetPlayers();
    local v11 = {};
    local v12 = 25;
    local v13 = nil;

    for _, v in pairs(Players2) do
        if v.Team ~= game.Teams.Visitor and (v.Character:FindFirstChild("HumanoidRootPart") ~= nil and (v.Team ~= p2.Team and not (v.Character.Values.Goalie.Value and v.Character.Values.IsInPenalty.Value))) then
            local v14 = p3.HumanoidRootPart.CFrame.LookVector:Dot((v.Character.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Unit);
            local math_acos_ret = math.acos(v14);

            if math_acos_ret < 1.5707963267948966 or math_acos_ret < 1.9039955476301778 then
                table.insert(v11, v.Character);
            end;
        end;
    end;

    local PassRig = workspace:FindFirstChild("PassRig");

    if PassRig and (PassRig:GetAttribute("IsTrainingDummy") and PassRig:FindFirstChild("HumanoidRootPart")) then
        table.insert(v11, PassRig);
    end;

    for _, v in pairs(v11) do
        local Magnitude = (v.HumanoidRootPart.Position - p3.HumanoidRootPart.Position).Magnitude;

        if Magnitude < v12 then
            v13 = v;
            v12 = Magnitude;
        end;
    end;

    table.clear(v11);
    table.clear(Players2);

    if v13 == nil then
        Popup.Popup(p2, "Another player must be infront of you!");

        return;
    end;

    local Surpass = AbilityBalancing.Surpass;
    local LookVector = workspace.CurrentCamera.CFrame.LookVector;
    u1:AbilityCooldown("3", Surpass.Cooldown);
    u1.AbilityService.Ability:Fire("Surpass", { "Surpass", v13 });
    AbilityUtils.clientCutsceneSkill(u1, Surpass, 21.1, nil, true, LookVector);
end;