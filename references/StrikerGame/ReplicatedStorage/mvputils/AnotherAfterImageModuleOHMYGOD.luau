 

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local u1 = {
    Settings = {
        tweenDuration = 0.3,
        fxFolder = "Effects",
        Color = Color3.new(1, 1, 1),
        Outline = Color3.new(1, 1, 1)
    }
};
u1.Settings.tweenInfo = TweenInfo.new(u1.Settings.tweenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
u1._templateCache = {};

function u1._buildCleanTemplate(p2: table, p3: userdata) -- Line: 50
    if p2._templateCache[p3] then
        return p2._templateCache[p3];
    end;

    local v4 = p3:Clone();
    v4.Parent = nil;
    local HumanoidRootPart = v4:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        HumanoidRootPart:Destroy();
    end;

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.CastShadow = false;
            descendant.Color = p2.Settings.Color;
            descendant.Material = Enum.Material.Neon;
            descendant.Transparency = 0;
        elseif not (descendant:IsA("SpecialMesh") or descendant:IsA("DataModelMesh")) then
            descendant:Destroy();
        end;
    end;

    p2._templateCache[p3] = v4;

    return v4;
end;

function u1._applyPose(p5: table, p6: userdata, p7: userdata) -- Line: 80
    for _, descendant in p6:GetDescendants() do
        if descendant:IsA("BasePart") then
            local v8 = p7:FindFirstChild(descendant.Name, true);

            if v8 and v8:IsA("BasePart") then
                descendant.CFrame = v8.CFrame;
            end;
        end;
    end;
end;

function u1._createAfterImage(p9: table, p10: userdata, p11: userdata, p12: number, p13: boolean) -- Line: 91
    -- upvalues: TweenService (copy)
    local u14 = p10:Clone();

    if p13 then
        local v15 = u14:FindFirstChildOfClass("Humanoid");

        if v15 then
            v15:Destroy();
        end;

        local HumanoidRootPart = u14:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            HumanoidRootPart:Destroy();
        end;

        for _, descendant in u14:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.CanCollide = false;
                descendant.CanTouch = false;
                descendant.CanQuery = false;
                descendant.CastShadow = false;
                descendant.CollisionGroup = "FX";
            end;
        end;
    else
        for _, descendant in u14:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CollisionGroup = "FX";
                descendant.Transparency = p12;
            end;
        end;
    end;

    p9:_applyPose(u14, p11);
    local v16 = p13 and TweenInfo.new(0.82, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) or p9.Settings.tweenInfo;

    if not p13 then
        local Highlight = Instance.new("Highlight");
        Highlight.FillColor = p9.Settings.Color;
        Highlight.FillTransparency = 0.5;
        Highlight.OutlineColor = p9.Settings.Outline;
        Highlight.OutlineTransparency = 0;
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        Highlight.Parent = u14;
        TweenService:Create(Highlight, v16, {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end;

    for _, descendant in u14:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            TweenService:Create(descendant, v16, {
                Transparency = 1
            }):Play();
        end;
    end;

    local v17 = workspace:FindFirstChild(p9.Settings.fxFolder);

    if not v17 then
        v17 = Instance.new("Folder");
        v17.Name = p9.Settings.fxFolder;
        v17.Parent = workspace;
    end;

    u14.Parent = v17;
    task.delay(p13 and 0.82 or p9.Settings.tweenDuration, function() -- Line: 157
        -- upvalues: u14 (copy)
        if u14 then
            u14:Destroy();
        end;
    end);
end;

function u1._loop(u18: table, u19: userdata, u20: userdata, u21: number, u22: number, u23: number, u24: boolean, p25: any) -- Line: 166
    -- upvalues: RunService (copy)
    local u26 = 0;
    local u27 = 0;
    local u28 = nil;
    u28 = p25:Add(RunService.Heartbeat:Connect(function(p29) -- Line: 179
        -- upvalues: u26 (ref), u22 (copy), u28 (ref), u27 (ref), u21 (copy), u18 (copy), u19 (copy), u20 (copy), u23 (copy), u24 (copy)
        u26 = u26 + p29;

        if u22 <= u26 and (u28 and u28.Connected) then
            u28:Disconnect();
            u28 = nil;

            return;
        end;

        u27 = u27 + p29;

        if u21 <= u27 then
            u27 = u27 - u21;
            u18:_createAfterImage(u19, u20, u23, u24);
        end;
    end));

    return function() -- Line: 195
        -- upvalues: u28 (ref)
        if u28.Connected then
            u28:Disconnect();
        end;
    end;
end;

return {
    start = function(p30: table, p31: any) -- Line: 206, Name: start
        -- upvalues: u1 (copy)
        local v32 = p30.rig or error("AfterImages: `rig` required");
        local v33 = p30.mode == "Preset";
        local v34;

        if v33 then
            v34 = script:FindFirstChild("Template+");
            assert(v34, "AfterImages: no Template+ found under script");
        else
            if not v32.Archivable then
                v32.Archivable = true;
            end;

            v34 = u1:_buildCleanTemplate(v32);
        end;

        return u1:_loop(v34, v32, p30.interval, p30.duration, p30.transparency or 0, v33, p31);
    end
};