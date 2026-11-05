  

 

local Set_Transparency = require(script.Parent:WaitForChild("Set_Transparency"));
local u1 = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);

return function(p2, p3, p4) -- Line: 5
    -- upvalues: Set_Transparency (copy), u1 (copy)
    if p3[1] == nil then
        return;
    end;

    local Model = Instance.new("Model");
    Model.Name = "Limb";
    local v5 = p4 or {};
    local Origin = v5.Origin;
    local Time = v5.Time;
    local Humanoid = Instance.new("Humanoid");
    Humanoid.BreakJointsOnDeath = false;
    Humanoid.RequiresNeck = false;
    Humanoid.Name = "FakeHumanoid";
    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    Humanoid.Parent = Model;
    Humanoid:ChangeState(Enum.HumanoidStateType.Physics);

    for _, child in pairs(p2:GetChildren()) do
        if child:IsA("Shirt") or child:IsA("Pants") then
            child:Clone().Parent = Model;
        end;
    end;

    local v6 = nil;

    for _, v in pairs(p3) do
        local v7 = v:Clone();
        v7:BreakJoints();

        for _, child in pairs(v7:GetChildren()) do
            if child:IsA("Motor6D") or child:IsA("BallSocketConstraint") then
                child:Destroy();
            end;
        end;

        v7.Velocity = v7.Velocity / 4;
        v7.CanCollide = true;
        v7.CanQuery = false;
        v7.CanTouch = false;

        for _, v2 in pairs({ v7, unpack(v7:GetDescendants()) }) do
            if v2:IsA("BasePart") then
                local v8 = v2:GetAttribute("_OriginalTransparency");

                if v8 then
                    v2.Transparency = v8;
                end;
            end;
        end;

        v7.Parent = Model;

        if not Model.PrimaryPart then
            Model.PrimaryPart = v7;
        end;

        if v6 then
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = v6;
            WeldConstraint.Part1 = v7;
            WeldConstraint.Parent = v6;
        end;

        v6 = v7;
    end;

    for _, descendant in pairs(Model:GetDescendants()) do
        if descendant:IsA("BasePart") then
            game:GetService("PhysicsService"):SetPartCollisionGroup(descendant, "FX");
        end;
    end;

    if Origin then
        Model:PivotTo(Origin);
    else
        Model:PivotTo(p3[1].CFrame);
    end;

    Model.Parent = workspace.Effects;

    if Time ~= false then
        task.delay(Time or 5, function() -- Line: 89
            -- upvalues: Set_Transparency (ref), Model (copy), u1 (ref)
            Set_Transparency(Model, 1, u1, function() -- Line: 90
                -- upvalues: Model (ref)
                Model:Destroy();
            end);
        end);
    end;
end;