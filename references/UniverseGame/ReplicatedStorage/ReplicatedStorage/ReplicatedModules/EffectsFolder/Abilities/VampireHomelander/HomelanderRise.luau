  

 

local TweenService = game:GetService("TweenService");

local function WaitForAttribute(u1, u2, p3) -- Line: 5
    local u4 = coroutine.running();
    local v5 = u1:GetAttribute(u2);

    if v5 ~= nil then
        return v5;
    end;

    local v7 = u1:GetAttributeChangedSignal(u2):Connect(function() -- Line: 13
        -- upvalues: u1 (copy), u2 (copy), u4 (copy)
        local v6 = u1:GetAttribute(u2);

        if v6 ~= nil then
            task.spawn(u4, true, v6);
        end;
    end);
    local v8;

    if type(p3) == "number" and p3 <= (1 / 0) then
        v8 = task.delay(p3, function() -- Line: 22
            -- upvalues: u4 (copy)
            task.spawn(u4, false, nil);
        end);
    else
        v8 = nil;
    end;

    local v9, v10 = coroutine.yield();
    v7:Disconnect();

    if v9 ~= false then
        task.cancel(v8);
    end;

    return v10;
end;

return function(u11) -- Line: 37
    -- upvalues: WaitForAttribute (copy), TweenService (copy)
    if u11 == nil then
        return;
    end;

    local HumanoidRootPart = u11:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil then
        return;
    end;

    local RootJoint = HumanoidRootPart:FindFirstChild("RootJoint");

    if RootJoint == nil then
        return;
    end;

    local u12 = WaitForAttribute(u11, "Posing", 0.2);

    if u12 == nil then
        return;
    end;

    local u13 = (math.random() - 0.5) * 10000;
    local u14 = (math.random() - 0.5) * 10000;
    local u15 = (math.random() - 0.5) * 10000;
    local u16 = (math.random() - 0.5) * 10000;
    local u17 = 0;
    local u25 = game.RunService.PreSimulation:Connect(function(p18) -- Line: 55
        -- upvalues: u17 (ref), TweenService (ref), RootJoint (copy), u13 (copy), u14 (copy), u15 (copy), u16 (copy)
        u17 = u17 + p18;

        if u17 < 6.5 then
            local v19 = TweenService:GetValue(math.min(u17 / 6.5, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0);
            RootJoint.Transform = RootJoint.Transform + Vector3.new(0, 0, 15 * v19);

            return;
        end;

        local v20 = u17 - 6.5;
        local v21 = math.min(v20 / 2, 1);
        local Transform = RootJoint.Transform;
        local v22 = math.noise(v20 * 0.5, u13, u14) * v21 * 0.45;
        local v23 = math.noise(v20 * 0.5, u15, u16) * v21 * 0.45;
        local v24 = math.sin(v20 * -0.45) * v21 + 15;
        RootJoint.Transform = Transform + Vector3.new(v22, v23, v24);
    end);
    local u26 = nil;
    u26 = u11:GetAttributeChangedSignal("Posing"):Connect(function() -- Line: 78
        -- upvalues: u11 (copy), u12 (copy), u25 (copy), u26 (ref)
        if u11:GetAttribute(u12) == nil then
            u25:Disconnect();
            u26:Disconnect();
        end;
    end);
end;