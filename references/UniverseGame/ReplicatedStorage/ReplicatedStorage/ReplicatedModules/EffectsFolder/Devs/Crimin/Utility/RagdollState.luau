  

 

local RunService = game:GetService("RunService");
local u1 = {
    Enum.HumanoidStateType.Running,
    Enum.HumanoidStateType.Climbing,
    Enum.HumanoidStateType.Jumping,
    Enum.HumanoidStateType.GettingUp
};
local u2 = {};

local function PrepareState(u3, p4) -- Line: 12
    -- upvalues: RunService (copy)
    u3.NextHumanoidState = p4;

    if not u3.PreAnimation then
        u3.PreAnimation = RunService.PreAnimation:Once(function() -- Line: 15
            -- upvalues: u3 (copy)
            u3.PreAnimation = nil;

            if u3.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
                u3.NextHumanoidState = nil;

                return;
            end;

            u3.Humanoid:ChangeState(u3.NextHumanoidState);
            u3.NextHumanoidState = nil;
        end);
    end;
end;

return function(u5, p6) -- Line: 27
    -- upvalues: u2 (copy), u1 (copy), RunService (copy)
    if not u5 then
        return;
    end;

    local Humanoid = u5:FindFirstChild("Humanoid");

    if not Humanoid then
        return;
    end;

    local u7 = u2[u5];

    if not u7 then
        u7 = {
            Humanoid = Humanoid,
            State = p6,
            AncestryChanged = u5.AncestryChanged:Connect(function(p8, p9) -- Line: 36
                -- upvalues: u5 (copy), u7 (ref), u2 (ref)
                if not u5:IsDescendantOf(workspace) then
                    u7.AncestryChanged:Disconnect();

                    if u7.StateChanged then
                        u7.StateChanged:Disconnect();
                    end;

                    u2[u5] = nil;
                end;
            end)
        };
        u2[u5] = u7;
    end;

    u7.State = p6;

    if p6 == "Normal" then
        if u7.StateChanged then
            u7.StateChanged:Disconnect();
        end;

        u7.StateChanged = Humanoid.StateChanged:Connect(function(p10, p11) -- Line: 52
            -- upvalues: u7 (ref), u1 (ref), RunService (ref)
            if p11 ~= Enum.HumanoidStateType.Dead then
                if not table.find(u1, p11) then
                    local u12 = u7;
                    u12.NextHumanoidState = Enum.HumanoidStateType.GettingUp;

                    if not u12.PreAnimation then
                        u12.PreAnimation = RunService.PreAnimation:Once(function() -- Line: 15
                            -- upvalues: u12 (copy)
                            u12.PreAnimation = nil;

                            if u12.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
                                u12.NextHumanoidState = nil;

                                return;
                            end;

                            u12.Humanoid:ChangeState(u12.NextHumanoidState);
                            u12.NextHumanoidState = nil;
                        end);
                    end;
                end;

                return;
            end;

            u7.StateChanged:Disconnect();
            u7.StateChanged = nil;
        end);
        local u13 = u7;
        u13.NextHumanoidState = Enum.HumanoidStateType.GettingUp;

        if not u13.PreAnimation then
            u13.PreAnimation = RunService.PreAnimation:Once(function() -- Line: 15
                -- upvalues: u13 (copy)
                u13.PreAnimation = nil;

                if u13.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
                    u13.NextHumanoidState = nil;

                    return;
                end;

                u13.Humanoid:ChangeState(u13.NextHumanoidState);
                u13.NextHumanoidState = nil;
            end);
        end;
    elseif p6 == "Ragdolled" then
        if u7.StateChanged then
            u7.StateChanged:Disconnect();
        end;

        u7.StateChanged = Humanoid.StateChanged:Connect(function(p14, p15) -- Line: 67
            -- upvalues: u7 (ref), RunService (ref)
            if p15 ~= Enum.HumanoidStateType.Dead then
                if p15 ~= Enum.HumanoidStateType.Physics then
                    local u16 = u7;
                    u16.NextHumanoidState = Enum.HumanoidStateType.Physics;

                    if not u16.PreAnimation then
                        u16.PreAnimation = RunService.PreAnimation:Once(function() -- Line: 15
                            -- upvalues: u16 (copy)
                            u16.PreAnimation = nil;

                            if u16.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
                                u16.NextHumanoidState = nil;

                                return;
                            end;

                            u16.Humanoid:ChangeState(u16.NextHumanoidState);
                            u16.NextHumanoidState = nil;
                        end);
                    end;
                end;

                return;
            end;

            u7.StateChanged:Disconnect();
            u7.StateChanged = nil;
        end);
        local u17 = u7;
        u17.NextHumanoidState = Enum.HumanoidStateType.Physics;

        if not u17.PreAnimation then
            u17.PreAnimation = RunService.PreAnimation:Once(function() -- Line: 15
                -- upvalues: u17 (copy)
                u17.PreAnimation = nil;

                if u17.Humanoid:GetState() == Enum.HumanoidStateType.Dead then
                    u17.NextHumanoidState = nil;

                    return;
                end;

                u17.Humanoid:ChangeState(u17.NextHumanoidState);
                u17.NextHumanoidState = nil;
            end);
        end;
    end;

    Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
end;