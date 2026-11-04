 

 

local u1 = {
    Reference = Vector2.new(2130, 933)
};

local function loadingPresentation(p2) -- Line: 6
    if p2 then
        p2 = p2.Name == "ScreenOverlay" and true or p2.Name == "TeleportOverlay";
    end;

    return p2;
end;

local function proximityPresentation(p3) -- Line: 10
    while p3 do
        if p3.Name == "ProximityPrompts" or p3:GetAttribute("ProximityPromptUI") == true then
            return true;
        end;

        p3 = p3.Parent;
    end;

    return false;
end;

local function excluded(p4) -- Line: 21
    -- upvalues: proximityPresentation (copy)
    local v5 = p4:FindFirstAncestorWhichIsA("ScreenGui");

    if not proximityPresentation(p4) then
        local v6;

        if v5 then
            v6 = v5.Name == "ScreenOverlay" and true or v5.Name == "TeleportOverlay";
        else
            v6 = v5;
        end;

        if not (v6 or v5 and (v5.Name == "AbilityControls" or v5.Name == "GearControls")) then
            while p4 and p4 ~= v5 do
                if p4:GetAttribute("UIProportionalExclude") == true then
                    return true;
                end;

                if v5 and (v5.Name == "HUD" and (p4.Name == "CatchButton" or (p4.Name == "BoostButton" or p4.Name == "MeleeButton"))) then
                    return true;
                end;

                p4 = p4.Parent;
            end;

            return false;
        end;
    end;

    return true;
end;

function u1.factor(p7, p8) -- Line: 47
    -- upvalues: u1 (copy)
    local v9 = p8 or u1.Reference;

    return (p7.X <= 0 or p7.Y <= 0) and 1 or math.min(p7.X / v9.X, p7.Y / v9.Y);
end;

local function referenceSize(p10, p11) -- Line: 55
    local Size = p10.Size;

    if p10.SizeConstraint == Enum.SizeConstraint.RelativeXX then
        p11 = Vector2.new(p11.X, p11.X);
    elseif p10.SizeConstraint == Enum.SizeConstraint.RelativeYY then
        p11 = Vector2.new(p11.Y, p11.Y);
    end;

    return Vector2.new(Size.X.Scale * p11.X + Size.X.Offset, Size.Y.Scale * p11.Y + Size.Y.Offset);
end;

function u1.bind(u12, u13) -- Line: 66
    -- upvalues: excluded (copy), u1 (copy), referenceSize (copy)
    local v14 = u12:IsA("GuiObject");
    assert(v14, "A proportional group must be a GuiObject");
    local u15 = u12:FindFirstAncestorWhichIsA("ScreenGui");
    assert(u15, "A proportional group must belong to a ScreenGui");

    if excluded(u12) then
        for _, child in u12:GetChildren() do
            if child:IsA("UIScale") and child.Name == "ProportionalScale" then
                child:Destroy();
            end;
        end;

        u12:SetAttribute("UIAppliedScale", nil);

        return {
            resize = function() -- Line: 77, Name: resize
            end,

            destroy = function() -- Line: 77, Name: destroy
            end
        };
    end;

    local u16 = u15:GetAttribute("UIReferenceViewport") or u1.Reference;
    local Size = u12.Size;
    local SizeConstraint = u12.SizeConstraint;
    local u17 = referenceSize(u12, u16);
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "ProportionalScale";
    local Reveal = u12:FindFirstChild("Reveal");

    if not (Reveal and Reveal:IsA("NumberValue")) then
        Reveal = nil;
    end;

    local u18 = {
        alive = true,
        connections = {}
    };

    local function resize(p19) -- Line: 89
        -- upvalues: u18 (copy), u13 (copy), u15 (copy), u12 (copy), u17 (copy), u1 (ref), u16 (copy), UIScale (copy), Reveal (ref)
        if not u18.alive then
            return;
        end;

        local v20 = p19 or u13 and u13() or u15.AbsoluteSize;

        if v20.X <= 0 or v20.Y <= 0 then
            return;
        end;

        local AbsoluteSize = u12.Parent.AbsoluteSize;

        if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
            return;
        end;

        u12.Size = UDim2.fromScale(u17.X / AbsoluteSize.X, u17.Y / AbsoluteSize.Y);
        local v21 = u1.factor(v20, u16);
        UIScale.Scale = v21 * (Reveal and Reveal.Value or 1);
        u12:SetAttribute("UIAppliedScale", v21);
    end;

    u12.SizeConstraint = Enum.SizeConstraint.RelativeXY;
    u12.Size = UDim2.fromOffset(u17.X, u17.Y);
    UIScale.Parent = u12;

    function u18.resize(p22, p23) -- Line: 111
        -- upvalues: resize (copy)
        resize(p23);
    end;

    function u18.destroy() -- Line: 114
        -- upvalues: u18 (copy), UIScale (copy), u12 (copy), Size (copy), SizeConstraint (copy)
        if not u18.alive then
            return;
        end;

        u18.alive = false;

        for _, v in ipairs(u18.connections) do
            v:Disconnect();
        end;

        UIScale:Destroy();
        u12.Size = Size;
        u12.SizeConstraint = SizeConstraint;
        u12:SetAttribute("UIAppliedScale", nil);
    end;

    local connections = u18.connections;
    local PropertyChangedSignal = u15:GetPropertyChangedSignal("AbsoluteSize");
    table.insert(connections, PropertyChangedSignal:Connect(function() -- Line: 129
        -- upvalues: resize (copy)
        resize();
    end));

    if u12.Parent ~= u15 then
        local connections2 = u18.connections;
        local PropertyChangedSignal2 = u12.Parent:GetPropertyChangedSignal("AbsoluteSize");
        table.insert(connections2, PropertyChangedSignal2:Connect(function() -- Line: 136
            -- upvalues: resize (copy)
            resize();
        end));
    end;

    if Reveal then
        table.insert(u18.connections, Reveal.Changed:Connect(function() -- Line: 144
            -- upvalues: resize (copy)
            resize();
        end));
    end;

    resize();

    return u18;
end;

function u1.prepareTeleport(p24, p25) -- Line: 155
    -- upvalues: u1 (copy), excluded (copy), referenceSize (copy)
    local v26;

    if p24 then
        v26 = p24.Name == "ScreenOverlay" and true or p24.Name == "TeleportOverlay";
    else
        v26 = p24;
    end;

    if v26 then
        return;
    end;

    local v27 = p24:GetAttribute("UIReferenceViewport") or u1.Reference;
    local v28 = u1.factor(p25, v27);

    for _, descendant in ipairs(p24:GetDescendants()) do
        if descendant:IsA("GuiObject") and (descendant:GetAttribute("UIProportionalGroup") == true and not excluded(descendant)) then
            local v29 = referenceSize(descendant, v27);
            descendant.SizeConstraint = Enum.SizeConstraint.RelativeXY;
            descendant.Size = UDim2.fromOffset(v29.X, v29.Y);
            local UIScale = Instance.new("UIScale");
            UIScale.Name = "ProportionalScale";
            UIScale.Scale = v28;
            UIScale.Parent = descendant;
        end;
    end;
end;

function u1.watch(p30) -- Line: 175
    -- upvalues: excluded (copy), u1 (copy)
    local u31 = {};
    local u32 = {};

    local function add(p33) -- Line: 178
        -- upvalues: u31 (copy), excluded (ref), u1 (ref)
        if u31[p33] or (not p33:IsA("GuiObject") or p33:GetAttribute("UIProportionalGroup") ~= true) then
            return;
        end;

        if not p33:FindFirstAncestorWhichIsA("ScreenGui") or excluded(p33) then
            return;
        end;

        u31[p33] = u1.bind(p33);
    end;

    table.insert(u32, p30.DescendantAdded:Connect(add));
    table.insert(u32, p30.DescendantRemoving:Connect(function(p34) -- Line: 188, Name: remove
        -- upvalues: u31 (copy)
        local v35 = u31[p34];

        if v35 then
            u31[p34] = nil;
            v35.destroy();
        end;
    end));

    for _, descendant in ipairs(p30:GetDescendants()) do
        add(descendant);
    end;

    return function() -- Line: 200
        -- upvalues: u32 (copy), u31 (copy)
        for _, v in ipairs(u32) do
            v:Disconnect();
        end;

        for i in pairs(u31) do
            local v36 = u31[i];

            if v36 then
                u31[i] = nil;
                v36.destroy();
            end;
        end;
    end;
end;

return u1;