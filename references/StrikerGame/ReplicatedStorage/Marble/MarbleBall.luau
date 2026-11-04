 

 

local Config = require(script.Parent:WaitForChild("Config"));
local v1 = {
    Attribute = "MarbleBall",
    ScaleAttribute = "MarbleBallScale",
    Fill = 0.8
};
local u2 = { "ParticleEmitter", "Trail", "Beam", "Light", "Fire", "Smoke", "Sparkles", "Highlight", "BillboardGui" };

local function keeper(u3: table) -- Line: 16
    return function(u4: any, u5: string, u6: any) -- Line: 17
        -- upvalues: u3 (copy)
        if u4[u5] ~= u6 then
            u4[u5] = u6;
        end;

        local PropertyChangedSignal = u4:GetPropertyChangedSignal(u5);
        table.insert(u3, PropertyChangedSignal:Connect(function() -- Line: 21
            -- upvalues: u4 (copy), u5 (copy), u6 (copy)
            if u4[u5] ~= u6 then
                u4[u5] = u6;
            end;
        end));
    end;
end;

local function stopper(u7: table) -- Line: 29
    return function() -- Line: 30
        -- upvalues: u7 (copy)
        for _, v in u7 do
            v:Disconnect();
        end;

        table.clear(u7);
    end;
end;

function v1.prepareBody(u8: userdata, u9: string?) -- Line: 42
    -- upvalues: u2 (copy)
    local u10 = {};

    local function u14(u11: any, u12: string, u13: any) -- Line: 17
        -- upvalues: u10 (copy)
        if u11[u12] ~= u13 then
            u11[u12] = u13;
        end;

        local PropertyChangedSignal = u11:GetPropertyChangedSignal(u12);
        table.insert(u10, PropertyChangedSignal:Connect(function() -- Line: 21
            -- upvalues: u11 (copy), u12 (copy), u13 (copy)
            if u11[u12] ~= u13 then
                u11[u12] = u13;
            end;
        end));
    end;

    local function prepare(p15: userdata) -- Line: 45
        -- upvalues: u9 (copy), u14 (copy), u8 (copy), u2 (ref)
        if p15:IsA("BasePart") then
            if u9 then
                p15.CanCollide = false;
                p15.CanTouch = false;
                p15.CanQuery = false;
                p15.Massless = true;
                u14(p15, "CollisionGroup", u9);
            end;
        else
            if p15:IsA("ProximityPrompt") then
                u14(p15, "Enabled", false);

                return;
            end;

            if u8:GetAttribute("Emoting") then
                return;
            end;

            if p15:IsA("GuiBase3d") or p15:IsA("ForceField") then
                u14(p15, "Visible", false);

                return;
            end;

            for _, v in u2 do
                if p15:IsA(v) then
                    u14(p15, "Enabled", false);

                    return;
                end;
            end;
        end;
    end;

    for _, descendant in u8:GetDescendants() do
        prepare(descendant);
    end;

    table.insert(u10, u8.DescendantAdded:Connect(prepare));

    return function() -- Line: 30
        -- upvalues: u10 (copy)
        for _, v in u10 do
            v:Disconnect();
        end;

        table.clear(u10);
    end;
end;

function v1.hideAdded(u16: userdata) -- Line: 79
    local u17 = {};

    local function u21(u18: any, u19: string, u20: any) -- Line: 17
        -- upvalues: u17 (copy)
        if u18[u19] ~= u20 then
            u18[u19] = u20;
        end;

        local PropertyChangedSignal = u18:GetPropertyChangedSignal(u19);
        table.insert(u17, PropertyChangedSignal:Connect(function() -- Line: 21
            -- upvalues: u18 (copy), u19 (copy), u20 (copy)
            if u18[u19] ~= u20 then
                u18[u19] = u20;
            end;
        end));
    end;

    local u22 = setmetatable({}, {
        __mode = "k"
    });
    table.insert(u17, u16.DescendantAdded:Connect(function(p23) -- Line: 83
        -- upvalues: u16 (copy), u22 (copy), u21 (copy)
        if u16:GetAttribute("Emoting") then
            return;
        end;

        if not p23:IsA("BasePart") then
            if p23:IsA("Decal") and (p23.Parent and u22[p23.Parent]) then
                u21(p23, "Transparency", 1);
            end;

            return;
        end;

        u22[p23] = true;
        u21(p23, "Transparency", 1);
    end));

    return function() -- Line: 30
        -- upvalues: u17 (copy)
        for _, v in u17 do
            v:Disconnect();
        end;

        table.clear(u17);
    end;
end;

function v1.measure(p24: userdata, p25: userdata) -- Line: 99
    local v26 = (-1 / 0);
    local v27 = (1 / 0);

    for _, child in p24:GetChildren() do
        if child:IsA("BasePart") then
            local v28 = p25.CFrame:PointToObjectSpace(child.Position);
            local v29 = child.Size.Y / 2;
            v26 = math.max(v26, v28.Y + v29);
            v27 = math.min(v27, v28.Y - v29);
        end;
    end;

    if v26 == (-1 / 0) then
        return 0, 5;
    end;

    return -(v26 + v27) / 2, v26 - v27;
end;

function v1.ballDiameter() -- Line: 116
    -- upvalues: Config (copy)
    local v30 = Config.BallTemplate();

    if not v30 then
        return 1.75;
    end;

    local Size = v30.Size;

    return math.max(Size.X, Size.Y, Size.Z);
end;

return v1;