  

 

game:GetService("TweenService");
local u1 = game.ReplicatedStorage["Client Assets"];
local u2 = Random.new();
local u3 = {};

return function(u4) -- Line: 8
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    local Origin = u4.Origin;
    local u5 = u4.Offset or CFrame.identity;
    local Duration = u4.Duration;
    local Frequency = u4.Frequency;
    local u6 = u4.Scale or NumberRange.new(3, 5);
    local u7 = u4.Size or Vector3.new(12.5, 5, 12.5);
    local u8 = u4.Transparency or 0.5;
    local Id = u4.Id;
    local u9 = u4.TweenData or { 0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out };
    local u10 = u4.Orientation or 720;

    if u3[Id] then
        u3[Id] = nil;

        return;
    end;

    if not Origin then
        return;
    end;

    local u11;

    if typeof(u6) == "NumberRange" then
        u11 = u6.Min or u6;
    else
        u11 = u6;
    end;

    if typeof(u6) == "NumberRange" then
        u6 = u6.Max or u6;
    end;

    local u12;

    if typeof(u10) == "NumberRange" then
        u12 = u10.Min or u10;
    else
        u12 = u10;
    end;

    if typeof(u10) == "NumberRange" then
        u10 = u10.Max or u10;
    end;

    local function Effect() -- Line: 35
        -- upvalues: Origin (copy), u1 (ref), u5 (copy), u8 (copy), u2 (ref), u4 (copy), u12 (copy), u10 (copy), u9 (copy), u7 (copy), u11 (copy), u6 (copy)
        local v13 = typeof(Origin) == "Instance" and (Origin:IsA("BasePart") and Origin.CFrame) or Origin;
        local u14 = u1.Kuro.Swirl:Clone();
        u14.CFrame = v13 * u5 * CFrame.Angles(0, 3.141592653589793, 0);
        u14.Size = Vector3.new(0, 0, 0);
        u14.Transparency = u8;
        local Orientation = u14.Orientation;
        local v15 = u2:NextNumber(-360, 360);
        u14.Orientation = Orientation + Vector3.new(0, v15, 0);

        if u4.RandomOrientation then
            local Orientation2 = u14.Orientation;
            local v16 = u2:NextNumber(-360, 360);
            u14.Orientation = Orientation2 + Vector3.new(v16, 0, u2:NextNumber(-360, 360));
        end;

        u14.Parent = workspace.Effects;
        local v17 = u2:NextNumber(u12, u10);
        local v18 = Vector3.new(0, v17, 0);

        if u4.RandomOrientation then
            local v19 = u2:NextNumber(u12, u10);
            v18 = v18 + Vector3.new(v19, 0, u2:NextNumber(u12, u10));
        end;

        local v20 = game:GetService("TweenService"):Create(u14, TweenInfo.new(table.unpack(u9)), {
            Transparency = 1,
            Size = u7 * u2:NextNumber(u11, u6),
            Orientation = u14.Orientation + v18
        });
        v20:Play();
        v20.Completed:Connect(function() -- Line: 63
            -- upvalues: u14 (copy)
            u14:Destroy();
        end);
    end;

    Effect();

    if Frequency then
        if Id then
            u3[Id] = true;
        end;

        local v21 = os.clock();

        while os.clock() - v21 < Duration and (not Id or u3[Id]) do
            task.wait(Frequency);
            Effect();
        end;
    end;
end;