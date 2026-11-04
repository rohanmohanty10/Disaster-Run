 

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Registry = require(script.Parent.Registry);
local u1 = {};
u1.__index = u1;
local u2 = {
    Tick = { 10128760939, 0.12, 1.3 },
    Open = { 10128766965, 0.3, 0.8 },
    Reward = { 82803453482376, 0.42, 1 }
};

function u1.new(p3) -- Line: 24
    -- upvalues: Registry (copy), u1 (copy)
    local v4 = {
        generation = 0,
        options = p3,
        container = p3.container,
        template = Registry.template(p3.container, "LaneTemplate"),
        gap = p3.container:FindFirstChildWhichIsA("UIListLayout").Padding.Scale,
        lanes = {},
        tweens = {},
        sounds = {},
        timers = {}
    };

    return setmetatable(v4, u1);
end;

function u1.clear(p5) -- Line: 39
    for _, v in p5.lanes do
        v.frame:Destroy();
    end;

    table.clear(p5.lanes);
    p5.container.Visible = false;
end;

function u1.cancel(p6) -- Line: 47
    p6.generation = p6.generation + 1;

    if p6.connection then
        p6.connection:Disconnect();
        p6.connection = nil;
    end;

    for _, v in p6.tweens do
        v:Cancel();
    end;

    for _, v in p6.sounds do
        v:Destroy();
    end;

    for i in p6.timers do
        task.cancel(i);
    end;

    table.clear(p6.tweens);
    table.clear(p6.sounds);
    table.clear(p6.timers);
    p6:clear();
end;

function u1.later(u7, p8, u9, u10) -- Line: 68
    local u11 = nil;
    u11 = task.delay(p8, function() -- Line: 70
        -- upvalues: u7 (copy), u11 (ref), u9 (copy), u10 (copy)
        u7.timers[u11] = nil;

        if u9 == u7.generation then
            u10();
        end;
    end);
    u7.timers[u11] = true;
end;

function u1.sound(p12, p13) -- Line: 79
    -- upvalues: u2 (copy), SoundService (copy)
    local v14 = u2[p13];
    local Sound = Instance.new("Sound");
    Sound.Name = "CrateLanes" .. p13;
    Sound.SoundId = "rbxassetid://" .. v14[1];
    Sound.Volume = v14[2];
    Sound.PlaybackSpeed = v14[3];
    Sound.Parent = SoundService;
    table.insert(p12.sounds, Sound);

    return Sound;
end;

function u1.play(u15, p16, u17) -- Line: 93
    -- upvalues: Registry (copy), RunService (copy), TweenService (copy)
    u15:cancel();
    local generation = u15.generation;
    local options = u15.options;
    local container = u15.container;
    local v18 = #p16.prizes;
    container.Visible = true;
    local v19 = (1 - u15.gap * (v18 - 1)) / v18;
    local v20 = container.AbsoluteSize.X * v19;
    local Y = container.AbsoluteSize.Y;
    local math_min_ret = math.min(v20 * 0.84, Y / 2.3 * 0.8);
    local u21 = math_min_ret / 0.8;
    local u22 = u21 * 1.08;
    local u23 = (v20 - math_min_ret) / 2;
    local u24 = Y / 2 / u22 + 1;
    local u25 = math.floor(u24 * 2) + 2;

    for i, v in p16.prizes do
        local v26 = u15.template:Clone();
        v26.Name = "Lane" .. i;
        v26.LayoutOrder = i;
        v26.Size = UDim2.fromScale(v19, 1);
        local v27 = Registry.get(v26, "Strip");
        local table_create_ret = table.create(32);
        local v28 = i;
        local v29 = v;

        for i2 = 1, 32 do
            local v30;

            if i2 == 28 then
                v30 = v29.emote or v29.skin;
            else
                v30 = options.pick(p16.crate);
            end;

            table_create_ret[i2] = v30;
            local _ = i2;
        end;

        local table_create_ret2 = table.create(u25);

        for i2 = 1, u25 do
            local v31 = options.card:Clone();
            v31.Name = "Card" .. i2;
            v31.AnchorPoint = Vector2.zero;
            v31.Size = UDim2.fromOffset(math_min_ret, u21);
            v31.Visible = false;
            v31.Parent = v27;
            table_create_ret2[i2] = {
                index = 0,
                card = v31
            };
            local _ = i2;
        end;

        v26.Parent = container;
        u15.lanes[v28] = {
            frame = v26,
            flash = Registry.get(v26, "Flash"),
            ids = table_create_ret,
            pool = table_create_ret2,
            seconds = 4 + (v28 - 1) * 0.18
        };
    end;

    local v32 = u15:sound("Open");
    local u33 = u15:sound("Tick");
    local u34 = u15:sound("Reward");
    v32:Play();

    local function place(p35, p36) -- Line: 141
        -- upvalues: u24 (copy), u25 (copy), options (copy), u23 (copy), Y (copy), u22 (copy), u21 (copy)
        local math_ceil_ret = math.ceil(p36 - u24);
        local math_max_ret = math.max(1, math_ceil_ret);
        local math_floor_ret = math.floor(p36 + u24);
        local math_min_ret2 = math.min(32, math_floor_ret);

        for i = math_max_ret, math_min_ret2 do
            local v37 = p35.pool[(i - 1) % u25 + 1];

            if v37.index ~= i then
                v37.index = i;
                options.paint(v37.card, p35.ids[i]);
            end;

            v37.card.Position = UDim2.fromOffset(u23, Y / 2 + (p36 - i) * u22 - u21 / 2);
            local _ = i;
        end;

        for _, v in p35.pool do
            local v38;

            if math_max_ret <= v.index then
                v38 = v.index <= math_min_ret2;
            else
                v38 = false;
            end;

            if v.card.Visible ~= v38 then
                v.card.Visible = v38;
            end;
        end;
    end;

    for _, v in u15.lanes do
        place(v, 2);
    end;

    local u39 = 0;
    local u40 = 0;
    local u41 = v18;
    u15.connection = RunService.RenderStepped:Connect(function(p42) -- Line: 165
        -- upvalues: u39 (ref), u15 (copy), place (copy), u41 (ref), options (copy), u25 (copy), TweenService (ref), u40 (ref), u33 (copy), generation (copy), u34 (copy), u17 (copy)
        u39 = u39 + p42;
        local v43 = false;

        for _, v in u15.lanes do
            if not v.done then
                local math_clamp_ret = math.clamp(u39 / v.seconds, 0, 1);
                local v44 = (1 - (1 - math_clamp_ret) ^ 4) * 26 + 2;
                local math_floor_ret = math.floor(v44 + 0.5);
                v43 = v43 or math_floor_ret ~= v.nearest;
                v.nearest = math_floor_ret;
                place(v, v44);

                if math_clamp_ret >= 1 then
                    v.done = true;
                    u41 = u41 - 1;
                    local v45 = options.paint(v.pool[27 % u25 + 1].card, v.ids[28]);
                    v.flash.BackgroundColor3 = v45;
                    v.flash.BackgroundTransparency = 0.35;
                    local v46 = TweenService:Create(v.flash, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 1
                    });
                    table.insert(u15.tweens, v46);
                    v46:Play();
                end;
            end;
        end;

        if v43 and os.clock() - u40 >= 0.06 then
            u40 = os.clock();
            u33.PlaybackSpeed = math.max(0, 1 - u39 / 4) * 0.6 + 0.85;
            u33.TimePosition = 0;
            u33:Play();
        end;

        if u41 > 0 then
            return;
        end;

        u15.connection:Disconnect();
        u15.connection = nil;
        u15:later(0.5, generation, function() -- Line: 200
            -- upvalues: u34 (ref), u17 (ref)
            u34:Play();
            u17();
        end);
    end);
end;

return u1;