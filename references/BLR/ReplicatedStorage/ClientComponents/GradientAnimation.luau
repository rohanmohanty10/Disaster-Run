  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Component = require(ReplicatedStorage.Packages.Component);
local Trove = require(ReplicatedStorage.Packages.Trove);

local function GetTimeAlphaLinear() -- Line: 8
    local v1 = time() * 1.5 % 2 / 2;

    if v1 > 0.5 then
        v1 = 1 - v1;
    end;

    return v1 * 2;
end;

local v2 = Component.new({
    Tag = "GradientAnimation"
});

local function animationModes(p3: any, p4: any, u5: userdata) -- Line: 23
    -- upvalues: RunService (copy)
    if not u5:IsA("UIGradient") then
        u5 = u5:FindFirstChildWhichIsA("UIGradient");

        if not u5 then
            warn("Missing UIGradient on", u5);

            return;
        end;
    end;

    if p4 == "Rainbow" then
        local u6 = 0;
        local u7 = {};
        local u8 = 0;
        p3:Add(RunService.Heartbeat:Connect(function(p9) -- Line: 38
            -- upvalues: u8 (ref), u6 (ref), u7 (ref), u5 (ref)
            if math.fmod(u8, 2) == 0 then
                for i = 0, 8 do
                    local Color3_fromRGB_ret = Color3.fromRGB(math.sin(0.2617993877991494 * i + u6) * 127 + 128, math.sin(0.2617993877991494 * i + 2.0943951023931953 + u6) * 127 + 128, math.sin(0.2617993877991494 * i + 4.1887902047863905 + u6) * 127 + 128);
                    table.insert(u7, i + 1, ColorSequenceKeypoint.new(i / 8, Color3_fromRGB_ret));
                    local _ = i;
                end;

                u5.Color = ColorSequence.new(u7);
                u7 = {};
                u6 = u6 + p9 * 9;

                if u6 >= 6.283185307179586 then
                    u6 = 0;
                end;
            end;

            if u8 >= 1000 then
                u8 = 0;
            end;

            u8 = u8 + 1;
        end));
    elseif p4 == "Loki" then
        local u10 = 0;
        local u11 = {};
        local u12 = 0;
        p3:Add(RunService.Heartbeat:Connect(function(p13) -- Line: 64
            -- upvalues: u12 (ref), u10 (ref), u11 (ref), u5 (ref)
            if math.fmod(u12, 2) == 0 then
                for i = 0, 8 do
                    local Color3_fromRGB_ret = Color3.fromRGB(math.sin(0.2617993877991494 * i + u10) * 127 + 128, math.sin(0.2617993877991494 * i + 2.0943951023931953 + u10) * 127 + 128, math.sin(0.2617993877991494 * i + 4.1887902047863905 + u10) * 127 + 128);
                    table.insert(u11, i + 1, ColorSequenceKeypoint.new(i / 8, Color3_fromRGB_ret));
                    local _ = i;
                end;

                u5.Color = ColorSequence.new(u11);
                u11 = {};
                u10 = u10 + p13 * 9;

                if u10 >= 6.283185307179586 then
                    u10 = 0;
                end;
            end;

            if u12 >= 1000 then
                u12 = 0;
            end;

            u12 = u12 + 1;
        end));
    else
        u5.Color = ColorSequence.new(Color3.new(1, 1, 1));
    end;
end;

function v2.Construct(u14) -- Line: 90
    -- upvalues: Trove (copy), animationModes (copy)
    u14.Trove = Trove.new();
    local Instance = u14.Instance;
    local Attribute = Instance:GetAttribute("AnimationMode");
    Instance:GetAttributeChangedSignal("AnimationMode"):Connect(function() -- Line: 96
        -- upvalues: u14 (copy), Instance (copy), animationModes (ref)
        u14.Trove:Destroy();
        local Attribute2 = Instance:GetAttribute("AnimationMode");
        animationModes(u14.Trove, Attribute2, Instance);
    end);
    animationModes(u14.Trove, Attribute, Instance);
end;

function v2.Stop(p15) -- Line: 108
    p15.Trove:Destroy();
end;

return v2;