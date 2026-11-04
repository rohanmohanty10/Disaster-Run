  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("StarterGui");
local WanoDashUtil = require(ReplicatedStorage.Modules.WanoDashUtil);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local Popup = require(ReplicatedStorage.Shared.Popup);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return function(u1, p2, p3) -- Line: 11
    -- upvalues: Popup (copy), Essentials (copy), CameraController (copy), WanoDashUtil (copy), ReplicatedStorage (copy)
    if p3.Values.HasBall.Value then
        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local OuterCHOP = workspace.Debris:FindFirstChild("OuterCHOP");

    if OuterCHOP then
        OuterCHOP:Destroy();
    end;

    local LookVector = HumanoidRootPart.CFrame.LookVector;
    local v4 = nil;

    for _, v in game.Players:GetPlayers() do
        if v ~= p2 and (v.Character and (v.Character.Values.HasBall.Value and not v.Character.Values.Dribbling.Value)) then
            local v5 = v.Character:FindFirstChild("HumanoidRootPart").Position - HumanoidRootPart.Position;

            if v5.Magnitude >= 15 and (v5.Magnitude <= 25 and LookVector:Dot(v5.Unit) > 0.5) then
                v4 = v.Character;
                break;
            end;
        end;
    end;

    local v6;

    if v4 then
        v6 = v4;
    else
        v6 = workspace:FindFirstChild("PassRig");

        if v6 and v6:GetAttribute("IsTrainingDummy") then
            local HumanoidRootPart2 = v6:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart2 then
                local Values = v6:FindFirstChild("Values");

                if Values then
                    Values = Values:FindFirstChild("HasBall");
                end;

                if Values and Values.Value then
                    local v7 = HumanoidRootPart2.Position - HumanoidRootPart.Position;

                    if v7.Magnitude >= 15 and v7.Magnitude <= 25 then
                        if LookVector:Dot(v7.Unit) <= 0.5 then
                            v6 = v4;
                        end;
                    else
                        v6 = v4;
                    end;
                else
                    v6 = v4;
                end;
            else
                v6 = v4;
            end;
        else
            v6 = v4;
        end;
    end;

    if not (not v6 or v6.Values.Goalie.Value and v6.Values.IsInPenalty.Value or v6.Values.InCutscene.Value) then
        u1:AbilityCooldown("2", 40);
        u1.StatesController.States.Ability = true;
        u1.ABC:Add(function() -- Line: 87
            -- upvalues: u1 (copy)
            u1.StatesController.States.Ability = false;
        end);
        u1.AbilityService.Ability:Fire("ChopFeast", {
            Target = v6
        });
        local RightVector = HumanoidRootPart.CFrame.RightVector;
        local v8 = { (HumanoidRootPart.CFrame.LookVector * 0.6 - RightVector * 1).Unit, (RightVector * 0.6).Unit, (v6.HumanoidRootPart.Position - HumanoidRootPart.Position).Unit };
        local v9 = { 304, 304, 304 };
        local v10 = { "KingChop2", "KingChop3", "KingChop2" };
        local v11 = { 0.15, 0.15, 0.15 };

        for i, v in v8 do
            u1.Animations:StopAnims();
            u1.Animations.Abilities[v10[i]].Priority = Enum.AnimationPriority.Action4;
            u1.Animations.Abilities[v10[i]]:Play();
            CameraController:Shake("Hit");

            if i < #v8 then
                WanoDashUtil.DashAdvancedLinear({
                    ResidualFrac = 0.3,
                    BlendStart = 0.75,
                    DelayBetween = 0,
                    MaxAxesForce = Vector3.new(100000, 0, 100000),
                    LvName = "StealLV",
                    Character = p3,
                    Directions = { v },
                    Duration = v11[i],
                    Power = v9[i]
                });
            else
                local math_clamp_ret = math.clamp((v6.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude, 0, 50);
                WanoDashUtil.DashAlignPosition({
                    Responsiveness = 200,
                    MaxForce = 100000,
                    DelayBetween = 0,
                    Character = p3,
                    Directions = { CFrame.new(HumanoidRootPart.Position, v6.HumanoidRootPart.Position).LookVector },
                    Duration = v11[i],
                    EasingStyle = Enum.EasingStyle.Quad,
                    EasingDirection = Enum.EasingDirection.Out,
                    Distance = math_clamp_ret
                });
            end;

            task.wait(0.05);
        end;

        u1.ABC:Connect(u1.AbilityService.Ability, function(p12) -- Line: 144
            -- upvalues: u1 (copy), ReplicatedStorage (ref)
            if p12 then
                p12.AssemblyLinearVelocity = (workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.18, 0)) * 160;
                u1.BallController:DragBall(ReplicatedStorage.Football.Value);
            end;

            u1.ABC:Clean();
        end);
        u1.ABC:Add(task.delay(3, function() -- Line: 154
            -- upvalues: u1 (copy)
            u1.ABC:Clean();
        end));

        return;
    end;

    Popup.Popup(p2, "Enemy must be within target area and must have ball!");
    local Part = Instance.new("Part");
    Part.Name = "OuterCHOP";
    Part.Material = Enum.Material.SmoothPlastic;
    Part.Size = Vector3.new(10, 2, 10);
    Part.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2, -20);
    Part.Color = Color3.fromRGB(0, 255, 0);
    Part.Transparency = 0.5;
    Part.Anchored = false;
    Part.CanCollide = false;
    Part.Massless = true;
    Part.Parent = workspace.Debris;
    Essentials:Weld(Part, p3.HumanoidRootPart);
    task.delay(0.5, function() -- Line: 78
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;