 

 

local u1 = {};
local u2 = { { 0, -23.2023 }, { 0.0263158, -23.8203 }, { 0.0526316, -24.3125 }, { 0.0789474, -24.7376 }, { 0.1052632, -24.8749 }, { 0.131579, -23.8196 }, { 0.1578947, -19.3039 }, { 0.1842105, -5.9943 }, { 0.2105263, 27.6341 }, { 0.2368421, 82.9123 }, { 0.2631579, 132.0323 }, { 0.2894737, 159.1408 }, { 0.3157895, 165.5134 }, { 0.3421053, 163.3501 }, { 0.3684211, 158.9437 }, { 0.3947368, 155.0231 }, { 0.4210527, 151.7035 }, { 0.4473684, 149.1205 }, { 0.4736842, 147.37 }, { 0.5, 146.4846 }, { 0.5263158, 147.4136 }, { 0.5526316, 152.0685 }, { 0.5789474, 157.6169 }, { 0.6052632, 159.5907 }, { 0.631579, 17.2384 }, { 0.6578947, -20.4119 }, { 0.6842105, -41.8735 }, { 0.7105263, -59.2729 }, { 0.7368421, -61.4298 }, { 0.7631579, -51.9283 }, { 0.7894737, -42.4804 }, { 0.8157895, -36.581 }, { 0.8421053, -34.3622 }, { 0.8684211, -35.484 }, { 0.8947368, -39.4032 }, { 0.9210526, -45.0567 }, { 0.9473685, -48.2368 }, { 0.9736842, -48.2466 }, { 1, -48.2575 } };

function u1.angle(p3) -- Line: 45
    -- upvalues: u2 (copy)
    local math_clamp_ret = math.clamp(p3 or 0, 0, 1);
    local v4 = u2[1];

    for i = 2, #u2 do
        local v5 = u2[i];

        if math_clamp_ret <= v5[1] then
            return math.rad(v4[2] + (v5[2] - v4[2]) * ((math_clamp_ret - v4[1]) / (v5[1] - v4[1])));
        end;

        v4 = v5;
        local _ = i;
    end;

    return math.rad(v4[2]);
end;

function u1.new(p6) -- Line: 58
    if p6:GetAttribute("WeaponStyle") ~= "Scythe" then
        return nil;
    end;

    local Handle = p6:FindFirstChild("Handle");
    local Blade = p6:FindFirstChild("Blade");

    if Handle then
        Handle = Handle:FindFirstChild("BladeWeld");
    end;

    if Blade then
        Blade = Blade:FindFirstChild("GripPoint");
    end;

    if not (Handle and (Handle:IsA("Weld") and (Blade and Blade:IsA("Attachment")))) then
        return nil;
    end;

    local C0 = Handle.C0;

    return {
        weld = Handle,
        recoveryLift = p6:GetAttribute("DiveRecoveryLiftDegrees"),
        recoveryTurn = p6:GetAttribute("DiveRecoveryTurnDegrees"),
        base = C0,
        gripInHandle = C0 * Handle.C1:Inverse() * Blade.CFrame,
        gripInverse = Blade.CFrame:Inverse(),
        c1 = Handle.C1
    };
end;

function u1.restore(p7) -- Line: 69
    if p7 and p7.weld.Parent then
        p7.weld.C0 = p7.base;
    end;
end;

function u1.apply(p8, p9, p10) -- Line: 72
    -- upvalues: u1 (copy)
    if not (p8 and p8.weld.Parent) then
        return;
    end;

    local math_clamp_ret = math.clamp(p10 or 0, 0, 1);

    if math_clamp_ret < 0.001 then
        u1.restore(p8);

        return;
    end;

    local v11;

    if type(p8.recoveryLift) == "number" then
        local math_clamp_ret2 = math.clamp(((p9 or 0) - 0.5) / 0.25, 0, 1);
        local v12 = math_clamp_ret2 * math_clamp_ret2 * (3 - math_clamp_ret2 * 2) * math_clamp_ret;
        v11 = math.rad(p8.recoveryLift) * v12;
        local _ = math.rad(p8.recoveryTurn or 0) * v12;
    else
        v11 = 0;
    end;

    p8.weld.C0 = p8.gripInHandle * CFrame.Angles(0, 0, u1.angle(p9) * math_clamp_ret) * CFrame.Angles(v11, 0, 0) * p8.gripInverse * p8.c1;
end;

return table.freeze(u1);