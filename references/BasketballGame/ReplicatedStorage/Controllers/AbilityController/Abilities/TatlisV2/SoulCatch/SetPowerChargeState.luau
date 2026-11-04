 
 

game:GetService("ReplicatedStorage");
local ContentProvider = game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local script_StarSpriteSheet = require(script.StarSpriteSheet);
local u1 = {
    Color3.fromRGB(0, 0, 0),
    Color3.fromRGB(38, 96, 190),
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(0, 255, 238),
    Color3.fromRGB(0, 123, 255)
};
local u2 = {
    Color3.fromRGB(98, 98, 111),
    Color3.fromRGB(0, 110, 255),
    Color3.fromRGB(0, 251, 255),
    Color3.fromRGB(255, 255, 255)
};
task.spawn(function() -- Line: 39
    -- upvalues: script_StarSpriteSheet (copy), ContentProvider (copy)
    local v3 = {};

    for _, v in ipairs(script_StarSpriteSheet) do
        table.insert(v3, "rbxassetid://" .. v);
    end;

    pcall(ContentProvider.PreloadAsync, ContentProvider, v3);
end);

local function applySwoop(p4: userdata, p5: number) -- Line: 49
    local math_clamp_ret = math.clamp(p5, 0, 1);

    if math_clamp_ret <= 0 then
        p4.Transparency = NumberSequence.new(1);

        return;
    end;

    if math_clamp_ret >= 1 then
        p4.Transparency = NumberSequence.new(0);

        return;
    end;

    local math_clamp_ret2 = math.clamp(math_clamp_ret - 0.06, 0.001, 0.998);
    local math_clamp_ret3 = math.clamp(math_clamp_ret + 0.06, math_clamp_ret2 + 0.001, 0.999);
    p4.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(math_clamp_ret2, 0),
        NumberSequenceKeypoint.new(math_clamp_ret3, 1),
        NumberSequenceKeypoint.new(1, 1)
    });
end;

local function tierColour(p6: number, p7: number) -- Line: 71
    -- upvalues: u2 (copy)
    local math_clamp_ret = math.clamp(p6, 0, p7);
    local math_floor_ret = math.floor(math_clamp_ret);
    local math_clamp_ret2 = math.clamp(math_floor_ret, 0, p7 - 1);

    return u2[math_clamp_ret2 + 1]:Lerp(u2[math_clamp_ret2 + 2], math_clamp_ret - math_clamp_ret2);
end;

local function randomInFrame() -- Line: 78
    local v8 = 0.08 + math.random() * 0.84;
    local v9 = 0.08 + math.random() * 0.84;

    return UDim2.fromScale(v8, v9);
end;

local function spawnStar(p10: userdata, p11: userdata) -- Line: 85
    -- upvalues: script_StarSpriteSheet (copy), u1 (copy)
    local u12 = p11:Clone();
    u12.Image = "rbxassetid://" .. script_StarSpriteSheet[1];
    u12.ImageColor3 = u1[math.random(1, #u1)];
    u12.AnchorPoint = Vector2.new(0.5, 0.5);
    local v13 = 0.08 + math.random() * 0.84;
    local v14 = 0.08 + math.random() * 0.84;
    u12.Position = UDim2.fromScale(v13, v14);
    u12.Rotation = math.random(0, 359);
    local v15 = math.random() < 0.5 and -2 or 0;
    u12.ZIndex = p10.ZIndex + v15;
    u12.Visible = true;
    u12.Parent = p10;
    task.spawn(function() -- Line: 100
        -- upvalues: script_StarSpriteSheet (ref), u12 (copy)
        for i = 1, #script_StarSpriteSheet do
            if not u12.Parent then
                return;
            end;

            u12.Image = "rbxassetid://" .. script_StarSpriteSheet[i];
            task.wait(0.05555555555555555);
            local _ = i;
        end;

        u12:Destroy();
    end);
end;

local function getOrCreateUIScale(p16: userdata) -- Line: 114
    local v17 = p16:FindFirstChildWhichIsA("UIScale");

    if not v17 then
        v17 = Instance.new("UIScale");
        v17.Parent = p16;
    end;

    return v17;
end;

local u18 = setmetatable({}, {
    __mode = "k"
});

return function(u19: userdata, p20: number) -- Line: 127, Name: SetPowerChargeStage
    -- upvalues: u18 (copy), RunService (copy), applySwoop (copy), u2 (copy), spawnStar (copy)
    local Frame = u19:WaitForChild("Container"):WaitForChild("Frame");
    local u21 = u18[u19];

    if not u21 then
        local v22 = { Frame:WaitForChild("FillStepOne"), Frame:WaitForChild("FillStepTwo"), (Frame:WaitForChild("FillStepThree")) };
        local v23 = {};

        for i, v in ipairs(v22) do
            v23[i] = v:WaitForChild("UIGradient");
        end;

        local StarTemplate = Frame:WaitForChild("StarTemplate");
        StarTemplate.Visible = false;
        local PowerTextLabel = Frame:WaitForChild("PowerTextLabel");
        local v24 = PowerTextLabel:FindFirstChildWhichIsA("UIScale");

        if not v24 then
            v24 = Instance.new("UIScale");
            v24.Parent = PowerTextLabel;
        end;

        u21 = {
            Charge = 0,
            TargetTier = 0,
            ShakeClock = 0,
            PulseClock = 0,
            StarClock = 0,
            LastPercent = -1,
            frame = Frame,
            Steps = v22,
            Gradients = v23,
            StarTemplate = StarTemplate,
            PowerText = PowerTextLabel,
            TextScale = v24,
            Tiers = #v22,
            BasePosition = Frame.Position
        };
        u21.RenderConnection = RunService.RenderStepped:Connect(function(p25) -- Line: 169
            -- upvalues: u21 (ref), applySwoop (ref), u2 (ref), spawnStar (ref)
            local v26 = u21;
            v26.Charge = v26.Charge + (u21.TargetTier - u21.Charge) * math.min(p25 * 5.5, 1);

            if math.abs(u21.TargetTier - u21.Charge) < 0.001 then
                u21.Charge = u21.TargetTier;
            end;

            local v27 = u21.Charge / u21.Tiers;

            for i, v in ipairs(u21.Steps) do
                local v28 = i / u21.Tiers;
                v.Visible = (i - 1) / u21.Tiers < v27;
                applySwoop(u21.Gradients[i], (math.clamp(v27, 0, v28)));
            end;

            local math_floor_ret = math.floor(v27 * 100 + 0.5);

            if math_floor_ret ~= u21.LastPercent then
                u21.PowerText.Text = string.format("%d%%", math_floor_ret);

                if math_floor_ret % 10 == 0 and u21.LastPercent < math_floor_ret then
                    u21.TextScale.Scale = 1.35;
                end;

                u21.LastPercent = math_floor_ret;
            end;

            local PowerText = u21.PowerText;
            local Tiers = u21.Tiers;
            local math_clamp_ret = math.clamp(u21.Charge, 0, Tiers);
            local math_floor_ret2 = math.floor(math_clamp_ret);
            local math_clamp_ret2 = math.clamp(math_floor_ret2, 0, Tiers - 1);
            PowerText.TextColor3 = u2[math_clamp_ret2 + 1]:Lerp(u2[math_clamp_ret2 + 2], math_clamp_ret - math_clamp_ret2);
            local v29 = v27 * 1.5;
            local v30 = v29 * v29 * v29;

            if v30 > 0.01 then
                local v31 = u21;
                v31.PulseClock = v31.PulseClock + p25;
                local math_sin_ret = math.sin(u21.PulseClock * 3.141592653589793 * (3.5 + 6.5 * v27));
                local v32 = math.abs(math_sin_ret) * 0.35 + 0.65;
                local v33 = 5.5 * v30 * v32;
                local v34 = u21;
                v34.ShakeClock = v34.ShakeClock + p25 * (44 + 60 * v27);
                local v35 = math.noise(u21.ShakeClock, 0, 0) * v33;
                local v36 = math.noise(0, u21.ShakeClock, 0) * v33;
                u21.frame.Position = u21.BasePosition + UDim2.fromOffset(v35, v36);
                local math_max_ret = math.max(0.22 / v30, 0.012);
                local v37 = math.clamp(v30 / 3.375, 0, 1) * 2;
                local v38 = math.floor(v37) + 1;
                local v39 = u21;
                v39.StarClock = v39.StarClock + p25;

                while math_max_ret <= u21.StarClock do
                    local v40 = u21;
                    v40.StarClock = v40.StarClock - math_max_ret;

                    for i = 1, v38 do
                        spawnStar(u21.frame, u21.StarTemplate);
                        local _ = i;
                    end;
                end;

                local TextScale = u21.TextScale;
                local Scale = u21.TextScale.Scale;
                local v41 = math.min(v30, 2) * 0.12 * v32 + 1;
                TextScale.Scale = math.max(Scale, v41);
            else
                u21.PulseClock = 0;
                u21.StarClock = 0;
                u21.frame.Position = u21.BasePosition;
            end;

            local TextScale = u21.TextScale;
            TextScale.Scale = TextScale.Scale + (1 - u21.TextScale.Scale) * math.min(p25 * 14, 1);
        end);
        u19.Destroying:Connect(function() -- Line: 238
            -- upvalues: u21 (ref), u18 (ref), u19 (copy)
            if u21.RenderConnection then
                u21.RenderConnection:Disconnect();
                u21.RenderConnection = nil;
            end;

            u18[u19] = nil;
        end);
        u18[u19] = u21;
    end;

    u21.TargetTier = math.clamp(p20, 0, u21.Tiers);
end;