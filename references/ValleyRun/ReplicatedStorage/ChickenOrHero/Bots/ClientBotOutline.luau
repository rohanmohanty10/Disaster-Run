 

 

local TweenService = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;
local u2 = {
    Catcher = Color3.fromRGB(255, 85, 85),
    Runner = Color3.fromRGB(75, 170, 255),
    Hero = Color3.fromRGB(255, 202, 86),
    Safe = Color3.fromRGB(90, 230, 145),
    Caught = Color3.fromRGB(255, 85, 85)
};
u1.colors = u2;
local u3 = {
    Catcher = {
        fillT = 0.9,
        edgeT = 0.1,
        fill = u2.Catcher,
        edge = u2.Catcher
    },
    Runner = {
        fillT = 0.9,
        edgeT = 0.1,
        fill = u2.Runner,
        edge = u2.Runner
    },
    Hero = {
        fillT = 0.9,
        edgeT = 0.1,
        fill = u2.Hero,
        edge = u2.Hero
    },
    Safe = {
        fillT = 1,
        edgeT = 0.22,
        fill = u2.Safe,
        edge = u2.Safe
    },
    Caught = {
        fillT = 1,
        edgeT = 0.22,
        fill = u2.Caught,
        edge = u2.Caught
    },
    GearBoost = {
        fillT = 0.8,
        edgeT = 0.3,
        fill = Color3.fromRGB(125, 205, 255),
        edge = Color3.fromRGB(125, 205, 255)
    },
    GearBoostCatcher = {
        fillT = 0.8,
        edgeT = 0.3,
        fill = Color3.fromRGB(140, 15, 25),
        edge = Color3.fromRGB(140, 15, 25)
    },
    GearSlow = {
        fillT = 0.8,
        edgeT = 0.3,
        fill = Color3.fromRGB(255, 210, 90),
        edge = Color3.fromRGB(255, 210, 90)
    },
    Shield = {
        fillT = 0.6,
        edgeT = 0.05,
        fill = Color3.fromRGB(95, 210, 255),
        edge = Color3.new(1, 1, 1)
    }
};
u1.styles = u3;
local TweenInfo_new_ret = TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);

function u1.new(p4) -- Line: 34
    -- upvalues: u1 (copy)
    return setmetatable({
        folder = p4,
        groups = {},
        members = {}
    }, u1);
end;

function u1.group(p5, p6) -- Line: 37
    -- upvalues: u3 (copy)
    local v7 = p5.groups[p6];

    if v7 and v7.Parent == p5.folder then
        return v7;
    end;

    local Model = Instance.new("Model");
    Model.Name = p6;
    local v8 = u3[p6];
    local Highlight = Instance.new("Highlight");
    Highlight.Name = "Outline";
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = v8.fill;
    Highlight.OutlineColor = v8.edge;
    Highlight.FillTransparency = v8.fillT;
    Highlight.OutlineTransparency = v8.edgeT;
    Highlight.Adornee = Model;
    Highlight.Enabled = false;
    Highlight.Parent = Model;
    Model.Parent = p5.folder;
    p5.groups[p6] = Model;
    p5.members[p6] = 0;

    return Model;
end;

function u1.sync(p9, p10) -- Line: 61
    local v11;

    if p10.shown then
        v11 = p10.group or nil;
    else
        v11 = nil;
    end;

    if p10.joined ~= v11 then
        local joined = p10.joined;

        if joined then
            local members = p9.members;
            members[joined] = members[joined] - 1;
            local v12 = p9.groups[joined];

            if p9.members[joined] <= 0 and v12 then
                v12.Outline.Enabled = false;
            end;
        end;

        p10.joined = v11;

        if v11 then
            local v13 = p9:group(v11);
            local members = p9.members;
            members[v11] = members[v11] + 1;
            v13.Outline.Enabled = true;
        end;
    end;

    if p10.shown then
        local v14 = p10.group and p9.groups[p10.group] or p9.folder;

        if p10.model.Parent ~= v14 then
            p10.model.Parent = v14;
        end;
    end;
end;

function u1.cancel(p15, p16) -- Line: 86
    local flash = p16.flash;

    if not flash then
        return;
    end;

    p16.flash = nil;
    local flashTween = p16.flashTween;
    p16.flashTween = nil;

    if flashTween then
        flashTween:Cancel();
        flashTween:Destroy();
    end;

    flash:Destroy();
end;

function u1.flash(u17, u18, u19) -- Line: 101
    -- upvalues: u2 (copy), TweenService (copy), TweenInfo_new_ret (copy)
    local Highlight = Instance.new("Highlight");
    Highlight.Name = "RoleOutline";
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = u2[u19];
    Highlight.OutlineColor = u2[u19];
    Highlight.FillTransparency = u19 == "Caught" and 0.35 or 1;
    Highlight.OutlineTransparency = 0;
    Highlight.Adornee = u18.model;
    Highlight.Parent = u18.model;
    local u20 = TweenService:Create(Highlight, TweenInfo_new_ret, {
        OutlineTransparency = 0.22,
        FillTransparency = 1
    });
    u18.flash = Highlight;
    u18.flashTween = u20;
    u20.Completed:Once(function() -- Line: 114
        -- upvalues: u18 (copy), Highlight (copy), u20 (copy), u19 (copy), u17 (copy)
        if u18.flash ~= Highlight then
            return;
        end;

        u18.flash = nil;
        u18.flashTween = nil;
        u20:Destroy();
        Highlight:Destroy();

        if u18.style == u19 and u18.model then
            u18.group = u19;
            u17:sync(u18);
        end;
    end);
    u20:Play();
end;

function u1.marker(p21, p22, p23) -- Line: 130
    -- upvalues: u2 (copy)
    local marker = p22.marker;

    if not p23 then
        if marker then
            marker:Destroy();
            p22.marker = nil;
        end;

        p22.markerStyle = nil;

        return;
    end;

    if marker and marker.Parent ~= p22.model then
        marker = nil;
    end;

    if not marker then
        marker = Instance.new("BillboardGui");
        marker.Name = "RoleMarker";
        marker.Size = UDim2.fromOffset(18, 18);
        marker.AlwaysOnTop = false;
        marker.LightInfluence = 0;
        marker.MaxDistance = 420;
        marker.Active = false;
        local Frame = Instance.new("Frame");
        Frame.Name = "Dot";
        Frame.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame.Position = UDim2.fromScale(0.5, 0.5);
        Frame.Size = UDim2.fromOffset(12, 12);
        Frame.BorderSizePixel = 0;
        Frame.Parent = marker;
        local UICorner = Instance.new("UICorner");
        UICorner.CornerRadius = UDim.new(1, 0);
        UICorner.Parent = Frame;
        local Frame2 = Instance.new("Frame");
        Frame2.Name = "DownedCenter";
        Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
        Frame2.Position = UDim2.fromScale(0.5, 0.5);
        Frame2.Size = UDim2.fromOffset(6, 6);
        Frame2.BorderSizePixel = 0;
        Frame2.BackgroundColor3 = Color3.fromRGB(14, 24, 30);
        Frame2.Visible = false;
        Frame2.Parent = Frame;
        local UICorner2 = Instance.new("UICorner");
        UICorner2.CornerRadius = UDim.new(1, 0);
        UICorner2.Parent = Frame2;
        marker.Parent = p22.model;
        p22.marker = marker;
        p22.markerStyle = nil;
    end;

    if p22.markerStyle == p23 then
        return;
    end;

    p22.markerStyle = p23;
    local v24 = p22.head or p22.root;
    marker.Adornee = v24;
    marker.StudsOffsetWorldSpace = Vector3.new(0, v24.Name == "Head" and (v24.Size.Y / 2 + 1.6 or 4.15) or 4.15, 0);
    marker:SetAttribute("VisualStyle", p23);
    marker.Enabled = true;
    marker.Dot.BackgroundTransparency = 0.26;
    marker.Dot.DownedCenter.BackgroundTransparency = 0.3;
    marker.Dot.BackgroundColor3 = u2[p23]:Lerp(Color3.new(1, 1, 1), 0.12);
    marker.Dot.DownedCenter.Visible = p23 == "Caught";
end;

function u1.apply(p25, p26, p27, p28, p29) -- Line: 193
    p25:marker(p26, p27);

    if p28 == p26.style then
        return;
    end;

    p26.style = p28;
    p25:cancel(p26);

    if not (p29 and (p26.shown and (p28 == "Safe" or p28 == "Caught"))) then
        p26.group = p28;
        p25:sync(p26);

        return;
    end;

    p26.group = nil;
    p25:sync(p26);
    p25:flash(p26, p28);
end;

function u1.settle(p30, p31) -- Line: 211
    if p31.flash then
        p30:cancel(p31);
        p31.group = p31.style;
    end;
end;

function u1.counts(p32) -- Line: 217
    local v33 = 0;
    local v34 = 0;

    for _, v in p32.groups do
        v33 = v33 + 1;

        if v.Outline.Enabled then
            v34 = v34 + 1;
        end;
    end;

    return v33, v34;
end;

function u1.destroy(p35) -- Line: 227
    for _, v in p35.groups do
        v:Destroy();
    end;

    table.clear(p35.groups);
    table.clear(p35.members);
end;

return u1;