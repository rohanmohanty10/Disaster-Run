  

 

local function Lerp(p1, p2, p3) -- Line: 1
    return p1 + (p2 - p1) * p3;
end;

local function ColorQuad(p4, p5, p6, p7) -- Line: 5
    return p4:Lerp(p5, p7):Lerp(p5:Lerp(p6, p7), p7);
end;

return function(p8) -- Line: 10
    -- upvalues: ColorQuad (copy)
    local Parent = script.Parent;
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local Scaling = Parent.Scaling;
    local Damage = Parent.Damage;
    local HitCount = Parent.HitCount;
    local Fusion = require(game:GetService("ReplicatedStorage").ClientLibrary.Fusion);
    local Settings = LocalPlayer:WaitForChild("Settings", 5);

    if not Settings then
        warn("no settings");
    end;

    local u9 = Color3.fromRGB(217, 217, 217);
    local u10 = Color3.fromRGB(255, 238, 106);
    local u11 = Color3.fromRGB(255, 83, 83);
    local u12 = Color3.fromRGB(255, 255, 255);
    local u13 = Color3.fromRGB(187, 202, 255);
    local u14 = Color3.fromRGB(230, 171, 255);
    local u15 = {};
    local u16 = Random.new();
    local u17 = Fusion.Value(nil);
    local u18 = Fusion.Value(0);
    local u19 = Fusion.Value(0);
    local u20 = Fusion.Spring(Fusion.Value(Damage.Position), 25, 0.65);
    local u21 = Fusion.Spring(Fusion.Value(Damage.Rotation), 15, 0.45);
    local u22 = Fusion.Spring(Fusion.Value(HitCount.Position), 19, 0.615);
    local u23 = Fusion.Spring(Fusion.Value(HitCount.Rotation), 12, 0.5);
    local u24 = Fusion.Value(Parent.Position);
    local u27 = Fusion.Computed(function() -- Line: 43
        -- upvalues: u17 (copy), u18 (copy)
        local v25 = u17:get();

        if not v25 then
            return 1;
        end;

        if v25:GetAttribute("NPC") then
            return 1;
        end;

        u18:get();
        local v26 = v25:GetAttribute("TotalDamage") or 0;

        return v26 < 100 and 1 or 1 + -0.75 * math.min((v26 - 100) / 100, 1);
    end);
    local u29 = Fusion.Computed(function() -- Line: 56
        -- upvalues: u27 (copy)
        local v28 = u27:get();

        return UDim2.fromScale(0 + 1 * ((v28 - 0.25) / 0.75), 1);
    end);
    local v31 = Fusion.Spring(Fusion.Computed(function() -- Line: 61
        -- upvalues: u29 (copy), ColorQuad (ref), u9 (copy), u10 (copy), u11 (copy)
        local v30 = 1 - u29:get().X.Scale;

        return ColorQuad(u9, u10, u11, (math.max(v30, 0)));
    end), 15, 0.65);
    local v33 = Fusion.Spring(Fusion.Computed(function() -- Line: 69
        -- upvalues: u18 (copy), ColorQuad (ref), u12 (copy), u13 (copy), u14 (copy)
        local v32 = u18:get() / 300;

        return ColorQuad(u12, u13, u14, (math.clamp(v32, 0, 1)));
    end), 15, 0.65);
    local u34 = Fusion.Computed(function() -- Line: 75
        -- upvalues: u17 (copy)
        return u17:get() ~= nil;
    end);

    local function Round(p35, p36) -- Line: 79
        return math.round(p35 * 10 ^ p36) / 10 ^ p36;
    end;

    local function Constrain(p37, p38, p39) -- Line: 83
        if not p39 then
            return math.min(p38, p37);
        end;

        local v40 = p38 * math.sign(p37);

        return math.clamp(p37, v40, 100000);
    end;

    local function UpdateLog(p41) -- Line: 92
        -- upvalues: u18 (copy), u19 (copy), u15 (copy)
        local Target = p41.Target;

        if not Target then
            return;
        end;

        local Damage2 = p41.Damage;
        u18:set(u18:get() + Damage2, 2);
        u19:set(u19:get() + 1);

        if not u15[Target] then
            u15[Target] = {
                Last = os.clock(),
                Damage = Damage2
            };

            return;
        end;

        u15[Target].Last = os.clock();
        local v42 = u15[Target];
        v42.Damage = v42.Damage + Damage2;
    end;

    local function RemoveTarget(p43) -- Line: 110
        -- upvalues: u15 (copy), u17 (copy)
        if u15[p43] then
            table.clear(u15[p43]);
            u15[p43] = nil;

            if u17:get() == p43 then
                u17:set(nil);
            end;
        end;
    end;

    Fusion.Hydrate(Parent)({
        Visible = true,
        GroupTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 122
            -- upvalues: u34 (copy)
            return u34:get() and 0 or 1;
        end), 20, 0.7),
        Position = Fusion.Spring(Fusion.Computed(function() -- Line: 125
            -- upvalues: u34 (copy), u24 (copy)
            if u34:get() then
                return u24:get();
            end;

            return u24:get() + UDim2.fromOffset(0, -25);
        end), 15, 0.7)
    });
    Fusion.Hydrate(Damage)({
        Text = Fusion.Computed(function() -- Line: 135
            -- upvalues: u18 (copy)
            return string.format("%.2f", u18:get());
        end),
        Position = u20,
        Rotation = u21,
        TextColor3 = v33
    });
    Fusion.Hydrate(HitCount)({
        Text = Fusion.Computed(function() -- Line: 144
            -- upvalues: u19 (copy)
            local v44 = u19:get();

            return `{v44} {v44 == 1 and "Hit" or "Hits"}`;
        end),
        Position = u22,
        Rotation = u23,
        TextColor3 = v33
    });
    Fusion.Hydrate(Scaling.Bar)({
        Size = Fusion.Spring(u29, 22.5, 0.65),
        BackgroundColor3 = v31
    });
    Fusion.Hydrate(Scaling.UIStroke)({
        Color = v31
    });
    Fusion.Hydrate(Scaling.Bar.Label)({
        Text = Fusion.Computed(function() -- Line: 163
            -- upvalues: u27 (copy)
            local v45 = u27:get();

            return string.format("%.2fx", v45);
        end),
        TextColor3 = v31
    });
    task.spawn(function() -- Line: 170
        -- upvalues: Settings (copy), u24 (copy), u18 (copy), u19 (copy), u15 (copy), u17 (copy)
        local ComboIndicator = Settings:WaitForChild("ComboIndicator");
        local u46 = { UDim2.new(0.2, 0, 0.5, 0), UDim2.new(0.75, 0, 0.5, 0) };

        if u46[ComboIndicator.Value] then
            u24:set(u46[ComboIndicator.Value]);
        end;

        ComboIndicator.Changed:Connect(function() -- Line: 179
            -- upvalues: u46 (copy), ComboIndicator (copy), u24 (ref), u18 (ref), u19 (ref)
            if u46[ComboIndicator.Value] then
                u24:set(u46[ComboIndicator.Value]);
            end;

            if ComboIndicator.Value == 3 then
                u18:set(0);
                u19:set(0);
            end;
        end);

        while true do
            task.wait(0.05);
            local v47 = 0;

            for i, v in u15 do
                v47 = v47 + 1;

                if os.clock() - v.Last >= 2.95 and u15[i] then
                    table.clear(u15[i]);
                    u15[i] = nil;

                    if u17:get() == i then
                        u17:set(nil);
                    end;
                end;
            end;

            if v47 == 0 then
                u18:set(0);
                u19:set(0);
            end;
        end;
    end);

    function p8.ShowComboIndicator(p48, p49) -- Line: 208
        -- upvalues: u20 (copy), u16 (copy), u21 (copy), u22 (copy), u23 (copy), u17 (copy), UpdateLog (copy)
        local v50 = math.clamp(p49.Damage, 10, 55);
        local fromOffset = UDim2.fromOffset;
        local v51 = u16:NextNumber(-v50, v50);
        local v52 = 9 * math.sign(v51);
        local v53 = math.clamp(v51, v52, 100000);
        local v54 = u16:NextNumber(-v50, v50);
        local v55 = 9 * math.sign(v54);
        u20:addVelocity(fromOffset(v53, (math.clamp(v54, v55, 100000))));
        u21:addVelocity(u16:NextNumber(-v50 / 5, v50 / 5));
        local v56 = v50 / 2;
        local fromOffset2 = UDim2.fromOffset;
        local v57 = u16:NextNumber(-v56, v56);
        local v58 = 5 * math.sign(v57);
        local v59 = math.clamp(v57, v58, 100000);
        local v60 = u16:NextNumber(-v56, v56);
        local v61 = 5 * math.sign(v60);
        u22:addVelocity(fromOffset2(v59, (math.clamp(v60, v61, 100000))));
        u23:addVelocity(u16:NextNumber(-v56 / 5, v56 / 5));

        if p49.Target then
            u17:set(p49.Target);
        end;

        UpdateLog(p49);
    end;
end;