 

 

local v1 = {};
local u2 = "rbxasset://textures/ui/traildot.png";
local u3 = "rbxasset://textures/ui/waypoint.png";
local u4 = false;
local UDim2_new_ret = UDim2.new(0, 42, 0, 50);
local Vector2_new_ret = Vector2.new(0, 0.5);
local Vector2_new_ret2 = Vector2.new(0, 1);
local Vector2_new_ret3 = Vector2.new(0, 0.5);
local Vector2_new_ret4 = Vector2.new(0.1, 0.5);
local Vector2_new_ret5 = Vector2.new(-0.1, 0.5);
local Vector2_new_ret6 = Vector2.new(1.5, 1.5);
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local LocalPlayer = Players.LocalPlayer;

local function CreateWaypointTemplates() -- Line: 44
    -- upvalues: Vector2_new_ret6 (ref), u4 (ref), u2 (ref), UDim2_new_ret (copy), Vector2_new_ret (copy), u3 (ref), Vector2_new_ret3 (copy)
    local Part = Instance.new("Part");
    Part.Size = Vector3.new(1, 1, 1);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Name = "TrailDot";
    Part.Transparency = 1;
    local ImageHandleAdornment = Instance.new("ImageHandleAdornment");
    ImageHandleAdornment.Name = "TrailDotImage";
    ImageHandleAdornment.Size = Vector2_new_ret6;
    ImageHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    ImageHandleAdornment.AlwaysOnTop = u4;
    ImageHandleAdornment.Image = u2;
    ImageHandleAdornment.Adornee = Part;
    ImageHandleAdornment.Parent = Part;
    local Part2 = Instance.new("Part");
    Part2.Size = Vector3.new(2, 2, 2);
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.Name = "EndWaypoint";
    Part2.Transparency = 1;
    local ImageHandleAdornment2 = Instance.new("ImageHandleAdornment");
    ImageHandleAdornment2.Name = "TrailDotImage";
    ImageHandleAdornment2.Size = Vector2_new_ret6;
    ImageHandleAdornment2.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    ImageHandleAdornment2.AlwaysOnTop = u4;
    ImageHandleAdornment2.Image = u2;
    ImageHandleAdornment2.Adornee = Part2;
    ImageHandleAdornment2.Parent = Part2;
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "EndWaypointBillboard";
    BillboardGui.Size = UDim2_new_ret;
    BillboardGui.LightInfluence = 0;
    BillboardGui.SizeOffset = Vector2_new_ret;
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.Adornee = Part2;
    BillboardGui.Parent = Part2;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Image = u3;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.new(1, 0, 1, 0);
    ImageLabel.Parent = BillboardGui;
    local Part3 = Instance.new("Part");
    Part3.Size = Vector3.new(2, 2, 2);
    Part3.Anchored = true;
    Part3.CanCollide = false;
    Part3.Name = "FailureWaypoint";
    Part3.Transparency = 1;
    local ImageHandleAdornment3 = Instance.new("ImageHandleAdornment");
    ImageHandleAdornment3.Name = "TrailDotImage";
    ImageHandleAdornment3.Size = Vector2_new_ret6;
    ImageHandleAdornment3.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    ImageHandleAdornment3.AlwaysOnTop = u4;
    ImageHandleAdornment3.Image = u2;
    ImageHandleAdornment3.Adornee = Part3;
    ImageHandleAdornment3.Parent = Part3;
    local BillboardGui2 = Instance.new("BillboardGui");
    BillboardGui2.Name = "FailureWaypointBillboard";
    BillboardGui2.Size = UDim2_new_ret;
    BillboardGui2.LightInfluence = 0;
    BillboardGui2.SizeOffset = Vector2_new_ret3;
    BillboardGui2.AlwaysOnTop = true;
    BillboardGui2.Adornee = Part3;
    BillboardGui2.Parent = Part3;
    local Frame = Instance.new("Frame");
    Frame.BackgroundTransparency = 1;
    Frame.Size = UDim2.new(0, 0, 0, 0);
    Frame.Position = UDim2.new(0.5, 0, 1, 0);
    Frame.Parent = BillboardGui2;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Image = u3;
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Position = UDim2.new(0, -UDim2_new_ret.X.Offset / 2, 0, -UDim2_new_ret.Y.Offset);
    ImageLabel2.Size = UDim2_new_ret;
    ImageLabel2.Parent = Frame;

    return Part, Part2, Part3;
end;

local u5, u6, u7 = CreateWaypointTemplates();

local function getTrailDotParent() -- Line: 130
    -- upvalues: Workspace (copy)
    local CurrentCamera = Workspace.CurrentCamera;
    local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay");

    if not ClickToMoveDisplay then
        ClickToMoveDisplay = Instance.new("Model");
        ClickToMoveDisplay.Name = "ClickToMoveDisplay";
        ClickToMoveDisplay.Parent = CurrentCamera;
    end;

    return ClickToMoveDisplay;
end;

local function placePathWaypoint(p8: any, p9: vector) -- Line: 141
    -- upvalues: Workspace (copy), LocalPlayer (copy)
    local v10, v11, v12 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(p9 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { Workspace.CurrentCamera, LocalPlayer.Character });

    if v10 then
        p8.CFrame = CFrame.new(v11, v11 + v12);
        local CurrentCamera = Workspace.CurrentCamera;
        local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay");

        if not ClickToMoveDisplay then
            ClickToMoveDisplay = Instance.new("Model");
            ClickToMoveDisplay.Name = "ClickToMoveDisplay";
            ClickToMoveDisplay.Parent = CurrentCamera;
        end;

        p8.Parent = ClickToMoveDisplay;
    end;
end;

local u13 = {};
u13.__index = u13;

function u13.Destroy(p14) -- Line: 156
    p14.DisplayModel:Destroy();
end;

function u13.NewDisplayModel(p15, p16) -- Line: 160
    -- upvalues: u5 (ref), placePathWaypoint (copy)
    local v17 = u5:Clone();
    placePathWaypoint(v17, p16);

    return v17;
end;

function u13.new(p18, p19) -- Line: 166
    -- upvalues: u13 (copy)
    local v20 = setmetatable({}, u13);
    v20.DisplayModel = v20:NewDisplayModel(p18);
    v20.ClosestWayPoint = p19;

    return v20;
end;

local u21 = {};
u21.__index = u21;

function u21.Destroy(p22) -- Line: 178
    p22.Destroyed = true;
    p22.Tween:Cancel();
    p22.DisplayModel:Destroy();
end;

function u21.NewDisplayModel(p23, p24) -- Line: 184
    -- upvalues: u6 (ref), placePathWaypoint (copy)
    local v25 = u6:Clone();
    placePathWaypoint(v25, p24);

    return v25;
end;

function u21.CreateTween(p26) -- Line: 190
    -- upvalues: TweenService (copy), Vector2_new_ret2 (copy)
    local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true);
    local v27 = TweenService:Create(p26.DisplayModel.EndWaypointBillboard, TweenInfo_new_ret, {
        SizeOffset = Vector2_new_ret2
    });
    v27:Play();

    return v27;
end;

function u21.TweenInFrom(p28: table, p29: vector) -- Line: 201
    -- upvalues: TweenService (copy)
    p28.DisplayModel.EndWaypointBillboard.StudsOffset = Vector3.new(0, (p29 - p28.DisplayModel.Position).Y, 0);
    local TweenInfo_new_ret = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v30 = TweenService:Create(p28.DisplayModel.EndWaypointBillboard, TweenInfo_new_ret, {
        StudsOffset = Vector3.new(0, 0, 0)
    });
    v30:Play();

    return v30;
end;

function u21.new(p31: vector, p32: number?, p33: vector?) -- Line: 215
    -- upvalues: u21 (copy)
    local u34 = setmetatable({}, u21);
    u34.DisplayModel = u34:NewDisplayModel(p31);
    u34.Destroyed = false;

    if p33 and (p33 - p31).Magnitude > 5 then
        u34.Tween = u34:TweenInFrom(p33);
        coroutine.wrap(function() -- Line: 222
            -- upvalues: u34 (copy)
            u34.Tween.Completed:Wait();

            if not u34.Destroyed then
                u34.Tween = u34:CreateTween();
            end;
        end)();
    else
        u34.Tween = u34:CreateTween();
    end;

    u34.ClosestWayPoint = p32;

    return u34;
end;

local u35 = {};
u35.__index = u35;

function u35.Hide(p36) -- Line: 239
    p36.DisplayModel.Parent = nil;
end;

function u35.Destroy(p37) -- Line: 243
    p37.DisplayModel:Destroy();
end;

function u35.NewDisplayModel(p38, p39) -- Line: 247
    -- upvalues: u7 (ref), placePathWaypoint (copy), Workspace (copy), LocalPlayer (copy)
    local v40 = u7:Clone();
    placePathWaypoint(v40, p39);
    local v41, v42, v43 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(p39 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { Workspace.CurrentCamera, LocalPlayer.Character });

    if v41 then
        v40.CFrame = CFrame.new(v42, v42 + v43);
        local CurrentCamera = Workspace.CurrentCamera;
        local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay");

        if not ClickToMoveDisplay then
            ClickToMoveDisplay = Instance.new("Model");
            ClickToMoveDisplay.Name = "ClickToMoveDisplay";
            ClickToMoveDisplay.Parent = CurrentCamera;
        end;

        v40.Parent = ClickToMoveDisplay;
    end;

    return v40;
end;

function u35.RunFailureTween(p44) -- Line: 261
    -- upvalues: TweenService (copy), Vector2_new_ret4 (copy), Vector2_new_ret5 (copy), Vector2_new_ret3 (copy)
    wait(0.125);
    local TweenInfo_new_ret = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v45 = TweenService:Create(p44.DisplayModel.FailureWaypointBillboard, TweenInfo_new_ret, {
        SizeOffset = Vector2_new_ret4
    });
    v45:Play();
    TweenService:Create(p44.DisplayModel.FailureWaypointBillboard.Frame, TweenInfo_new_ret, {
        Rotation = 10
    }):Play();
    v45.Completed:wait();
    local TweenInfo_new_ret2 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true);
    local v46 = TweenService:Create(p44.DisplayModel.FailureWaypointBillboard, TweenInfo_new_ret2, {
        SizeOffset = Vector2_new_ret5
    });
    v46:Play();
    local TweenInfo_new_ret3 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true);
    TweenService:Create(p44.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, TweenInfo_new_ret3, {
        ImageColor3 = Color3.new(0.75, 0.75, 0.75)
    }):Play();
    TweenService:Create(p44.DisplayModel.FailureWaypointBillboard.Frame, TweenInfo_new_ret3, {
        Rotation = -10
    }):Play();
    v46.Completed:wait();
    local TweenInfo_new_ret4 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v47 = TweenService:Create(p44.DisplayModel.FailureWaypointBillboard, TweenInfo_new_ret4, {
        SizeOffset = Vector2_new_ret3
    });
    v47:Play();
    TweenService:Create(p44.DisplayModel.FailureWaypointBillboard.Frame, TweenInfo_new_ret4, {
        Rotation = 0
    }):Play();
    v47.Completed:wait();
    wait(0.125);
end;

function u35.new(p48) -- Line: 310
    -- upvalues: u35 (copy)
    local v49 = setmetatable({}, u35);
    v49.DisplayModel = v49:NewDisplayModel(p48);

    return v49;
end;

local Animation = Instance.new("Animation");
Animation.AnimationId = "rbxassetid://2874840706";
local u50 = nil;

local function getFailureAnimationTrack(p51) -- Line: 324
    -- upvalues: u50 (ref), Animation (copy)
    if p51 == nil then
        return u50;
    end;

    u50 = p51:LoadAnimation(Animation);
    assert(u50, "");
    u50.Priority = Enum.AnimationPriority.Action;
    u50.Looped = false;

    return u50;
end;

local function findPlayerHumanoid() -- Line: 335
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        return Character:FindFirstChildOfClass("Humanoid");
    end;
end;

local function createTrailDots(p52: table, p53: vector) -- Line: 342
    -- upvalues: u13 (copy), u21 (copy)
    local v54 = {};
    local v55 = 1;

    for i = 1, #p52 - 1 do
        local v56 = (p52[i].Position - p52[#p52].Position).Magnitude < 3;
        local v57;

        if i % 2 == 0 then
            v57 = not v56;
        else
            v57 = false;
        end;

        local v58;

        if v57 then
            v54[v55] = u13.new(p52[i].Position, i);
            v55 = v55 + 1;
            v58 = i;
        else
            v58 = i;
        end;
    end;

    local v59 = u21.new(p52[#p52].Position, #p52, p53);
    table.insert(v54, v59);
    local v60 = {};
    local v61 = 1;

    for i = #v54, 1, -1 do
        v60[v61] = v54[i];
        v61 = v61 + 1;
        local _ = i;
    end;

    return v60;
end;

local function getTrailDotScale(p62: number, p63) -- Line: 367
    return p63 * (math.clamp(p62 - 10, 0, 90) / 90 * 1.5 + 1);
end;

local u64 = 0;

function v1.CreatePathDisplay(u65, p66) -- Line: 376
    -- upvalues: u64 (ref), createTrailDots (copy), RunService (copy), Workspace (copy), Vector2_new_ret6 (ref)
    u64 = u64 + 1;
    local u67 = createTrailDots(u65, p66);

    local function removePathBeforePoint(p68) -- Line: 380
        -- upvalues: u67 (copy)
        for i = #u67, 1, -1 do
            local v69 = u67[i];

            if v69.ClosestWayPoint > p68 then
                break;
            end;

            v69:Destroy();
            u67[i] = nil;
            local _ = i;
        end;
    end;

    local u70 = "ClickToMoveResizeTrail" .. u64;
    RunService:BindToRenderStep(u70, Enum.RenderPriority.Camera.Value - 1, function() -- Line: 394, Name: resizeTrailDots
        -- upvalues: u67 (copy), RunService (ref), u70 (copy), Workspace (ref), Vector2_new_ret6 (ref)
        if #u67 == 0 then
            RunService:UnbindFromRenderStep(u70);

            return;
        end;

        local p = Workspace.CurrentCamera.CFrame.p;

        for i = 1, #u67 do
            local TrailDotImage = u67[i].DisplayModel:FindFirstChild("TrailDotImage");
            local v71;

            if TrailDotImage then
                TrailDotImage.Size = Vector2_new_ret6 * (math.clamp((u67[i].DisplayModel.Position - p).Magnitude - 10, 0, 90) / 90 * 1.5 + 1);
                v71 = i;
            else
                v71 = i;
            end;
        end;
    end);

    return function() -- Line: 410, Name: removePath
        -- upvalues: removePathBeforePoint (copy), u65 (copy)
        removePathBeforePoint(#u65);
    end, removePathBeforePoint;
end;

local u72 = nil;

function v1.DisplayFailureWaypoint(p73) -- Line: 418
    -- upvalues: u72 (ref), u35 (copy)
    if u72 then
        u72:Hide();
    end;

    local u74 = u35.new(p73);
    u72 = u74;
    coroutine.wrap(function() -- Line: 424
        -- upvalues: u74 (ref)
        u74:RunFailureTween();
        u74:Destroy();
        u74 = nil;
    end)();
end;

function v1.CreateEndWaypoint(p75) -- Line: 431
    -- upvalues: u21 (copy)
    return u21.new(p75);
end;

function v1.PlayFailureAnimation() -- Line: 435
    -- upvalues: LocalPlayer (copy), u50 (ref), Animation (copy)
    local Character = LocalPlayer.Character;
    local v76;

    if Character then
        v76 = Character:FindFirstChildOfClass("Humanoid");
    else
        v76 = nil;
    end;

    if v76 then
        local v77;

        if v76 == nil then
            v77 = u50;
        else
            u50 = v76:LoadAnimation(Animation);
            assert(u50, "");
            u50.Priority = Enum.AnimationPriority.Action;
            u50.Looped = false;
            v77 = u50;
        end;

        v77:Play();
    end;
end;

function v1.CancelFailureAnimation() -- Line: 443
    -- upvalues: u50 (ref)
    if u50 ~= nil and u50.IsPlaying then
        u50:Stop();
    end;
end;

function v1.SetWaypointTexture(p78) -- Line: 449
    -- upvalues: u2 (ref), u5 (ref), u6 (ref), u7 (ref), CreateWaypointTemplates (copy)
    u2 = p78;
    local v79, v80, v81 = CreateWaypointTemplates();
    u5 = v79;
    u6 = v80;
    u7 = v81;
end;

function v1.GetWaypointTexture() -- Line: 454
    -- upvalues: u2 (ref)
    return u2;
end;

function v1.SetWaypointRadius(p82) -- Line: 458
    -- upvalues: Vector2_new_ret6 (ref), u5 (ref), u6 (ref), u7 (ref), CreateWaypointTemplates (copy)
    Vector2_new_ret6 = Vector2.new(p82, p82);
    local v83, v84, v85 = CreateWaypointTemplates();
    u5 = v83;
    u6 = v84;
    u7 = v85;
end;

function v1.GetWaypointRadius() -- Line: 463
    -- upvalues: Vector2_new_ret6 (ref)
    return Vector2_new_ret6.X;
end;

function v1.SetEndWaypointTexture(p86) -- Line: 467
    -- upvalues: u3 (ref), u5 (ref), u6 (ref), u7 (ref), CreateWaypointTemplates (copy)
    u3 = p86;
    local v87, v88, v89 = CreateWaypointTemplates();
    u5 = v87;
    u6 = v88;
    u7 = v89;
end;

function v1.GetEndWaypointTexture() -- Line: 472
    -- upvalues: u3 (ref)
    return u3;
end;

function v1.SetWaypointsAlwaysOnTop(p90) -- Line: 476
    -- upvalues: u4 (ref), u5 (ref), u6 (ref), u7 (ref), CreateWaypointTemplates (copy)
    u4 = p90;
    local v91, v92, v93 = CreateWaypointTemplates();
    u5 = v91;
    u6 = v92;
    u7 = v93;
end;

function v1.GetWaypointsAlwaysOnTop() -- Line: 481
    -- upvalues: u4 (ref)
    return u4;
end;

return v1;