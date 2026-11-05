  

 

local v1 = {};
local u2 = "rbxasset://textures/ui/traildot.png";
local u3 = "rbxasset://textures/ui/waypoint.png";
local u4 = false;
local u5 = UDim2.new(0, 42, 0, 50);
local u6 = Vector2.new(0, 0.5);
local u7 = Vector2.new(0, 1);
local u8 = Vector2.new(0, 0.5);
local u9 = Vector2.new(0.1, 0.5);
local u10 = Vector2.new(-0.1, 0.5);
local u11 = Vector2.new(1.5, 1.5);
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Workspace = game:GetService("Workspace");
local LocalPlayer = Players.LocalPlayer;

local function CreateWaypointTemplates() -- Line: 43
    -- upvalues: u11 (ref), u4 (ref), u2 (ref), u5 (copy), u6 (copy), u3 (ref), u8 (copy)
    local Part = Instance.new("Part");
    Part.Size = Vector3.new(1, 1, 1);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Name = "TrailDot";
    Part.Transparency = 1;
    local ImageHandleAdornment = Instance.new("ImageHandleAdornment");
    ImageHandleAdornment.Name = "TrailDotImage";
    ImageHandleAdornment.Size = u11;
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
    ImageHandleAdornment2.Size = u11;
    ImageHandleAdornment2.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    ImageHandleAdornment2.AlwaysOnTop = u4;
    ImageHandleAdornment2.Image = u2;
    ImageHandleAdornment2.Adornee = Part2;
    ImageHandleAdornment2.Parent = Part2;
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "EndWaypointBillboard";
    BillboardGui.Size = u5;
    BillboardGui.LightInfluence = 0;
    BillboardGui.SizeOffset = u6;
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
    ImageHandleAdornment3.Size = u11;
    ImageHandleAdornment3.SizeRelativeOffset = Vector3.new(0, 0, -0.1);
    ImageHandleAdornment3.AlwaysOnTop = u4;
    ImageHandleAdornment3.Image = u2;
    ImageHandleAdornment3.Adornee = Part3;
    ImageHandleAdornment3.Parent = Part3;
    local BillboardGui2 = Instance.new("BillboardGui");
    BillboardGui2.Name = "FailureWaypointBillboard";
    BillboardGui2.Size = u5;
    BillboardGui2.LightInfluence = 0;
    BillboardGui2.SizeOffset = u8;
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
    ImageLabel2.Position = UDim2.new(0, -u5.X.Offset / 2, 0, -u5.Y.Offset);
    ImageLabel2.Size = u5;
    ImageLabel2.Parent = Frame;

    return Part, Part2, Part3;
end;

local u12, u13, u14 = CreateWaypointTemplates();

local function getTrailDotParent() -- Line: 129
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

local function placePathWaypoint(p15, p16) -- Line: 140
    -- upvalues: Workspace (copy), LocalPlayer (copy)
    local v17, v18, v19 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(p16 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { Workspace.CurrentCamera, LocalPlayer.Character });

    if v17 then
        p15.CFrame = CFrame.new(v18, v18 + v19);
        local CurrentCamera = Workspace.CurrentCamera;
        local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay");

        if not ClickToMoveDisplay then
            ClickToMoveDisplay = Instance.new("Model");
            ClickToMoveDisplay.Name = "ClickToMoveDisplay";
            ClickToMoveDisplay.Parent = CurrentCamera;
        end;

        p15.Parent = ClickToMoveDisplay;
    end;
end;

local u20 = {};
u20.__index = u20;

function u20.Destroy(p21) -- Line: 155
    p21.DisplayModel:Destroy();
end;

function u20.NewDisplayModel(p22, p23) -- Line: 159
    -- upvalues: u12 (ref), placePathWaypoint (copy)
    local v24 = u12:Clone();
    placePathWaypoint(v24, p23);

    return v24;
end;

function u20.new(p25, p26) -- Line: 165
    -- upvalues: u20 (copy)
    local v27 = setmetatable({}, u20);
    v27.DisplayModel = v27:NewDisplayModel(p25);
    v27.ClosestWayPoint = p26;

    return v27;
end;

local u28 = {};
u28.__index = u28;

function u28.Destroy(p29) -- Line: 177
    p29.Destroyed = true;
    p29.Tween:Cancel();
    p29.DisplayModel:Destroy();
end;

function u28.NewDisplayModel(p30, p31) -- Line: 183
    -- upvalues: u13 (ref), placePathWaypoint (copy)
    local v32 = u13:Clone();
    placePathWaypoint(v32, p31);

    return v32;
end;

function u28.CreateTween(p33) -- Line: 189
    -- upvalues: TweenService (copy), u7 (copy)
    local v34 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true);
    local v35 = TweenService:Create(p33.DisplayModel.EndWaypointBillboard, v34, {
        SizeOffset = u7
    });
    v35:Play();

    return v35;
end;

function u28.TweenInFrom(p36, p37) -- Line: 200
    -- upvalues: TweenService (copy)
    p36.DisplayModel.EndWaypointBillboard.StudsOffset = Vector3.new(0, (p37 - p36.DisplayModel.Position).Y, 0);
    local v38 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v39 = TweenService:Create(p36.DisplayModel.EndWaypointBillboard, v38, {
        StudsOffset = Vector3.new(0, 0, 0)
    });
    v39:Play();

    return v39;
end;

function u28.new(p40, p41, p42) -- Line: 214
    -- upvalues: u28 (copy)
    local u43 = setmetatable({}, u28);
    u43.DisplayModel = u43:NewDisplayModel(p40);
    u43.Destroyed = false;

    if p42 and (p42 - p40).magnitude > 5 then
        u43.Tween = u43:TweenInFrom(p42);
        coroutine.wrap(function() -- Line: 221
            -- upvalues: u43 (copy)
            u43.Tween.Completed:Wait();

            if not u43.Destroyed then
                u43.Tween = u43:CreateTween();
            end;
        end)();
    else
        u43.Tween = u43:CreateTween();
    end;

    u43.ClosestWayPoint = p41;

    return u43;
end;

local u44 = {};
u44.__index = u44;

function u44.Hide(p45) -- Line: 238
    p45.DisplayModel.Parent = nil;
end;

function u44.Destroy(p46) -- Line: 242
    p46.DisplayModel:Destroy();
end;

function u44.NewDisplayModel(p47, p48) -- Line: 246
    -- upvalues: u14 (ref), placePathWaypoint (copy), Workspace (copy), LocalPlayer (copy)
    local v49 = u14:Clone();
    placePathWaypoint(v49, p48);
    local v50, v51, v52 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(p48 + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0)), { Workspace.CurrentCamera, LocalPlayer.Character });

    if v50 then
        v49.CFrame = CFrame.new(v51, v51 + v52);
        local CurrentCamera = Workspace.CurrentCamera;
        local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay");

        if not ClickToMoveDisplay then
            ClickToMoveDisplay = Instance.new("Model");
            ClickToMoveDisplay.Name = "ClickToMoveDisplay";
            ClickToMoveDisplay.Parent = CurrentCamera;
        end;

        v49.Parent = ClickToMoveDisplay;
    end;

    return v49;
end;

function u44.RunFailureTween(p53) -- Line: 260
    -- upvalues: TweenService (copy), u9 (copy), u10 (copy), u8 (copy)
    wait(0.125);
    local v54 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v55 = TweenService:Create(p53.DisplayModel.FailureWaypointBillboard, v54, {
        SizeOffset = u9
    });
    v55:Play();
    TweenService:Create(p53.DisplayModel.FailureWaypointBillboard.Frame, v54, {
        Rotation = 10
    }):Play();
    v55.Completed:wait();
    local v56 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true);
    local v57 = TweenService:Create(p53.DisplayModel.FailureWaypointBillboard, v56, {
        SizeOffset = u10
    });
    v57:Play();
    local v58 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true);
    TweenService:Create(p53.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, v58, {
        ImageColor3 = Color3.new(0.75, 0.75, 0.75)
    }):Play();
    TweenService:Create(p53.DisplayModel.FailureWaypointBillboard.Frame, v58, {
        Rotation = -10
    }):Play();
    v57.Completed:wait();
    local v59 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v60 = TweenService:Create(p53.DisplayModel.FailureWaypointBillboard, v59, {
        SizeOffset = u8
    });
    v60:Play();
    TweenService:Create(p53.DisplayModel.FailureWaypointBillboard.Frame, v59, {
        Rotation = 0
    }):Play();
    v60.Completed:wait();
    wait(0.125);
end;

function u44.new(p61) -- Line: 309
    -- upvalues: u44 (copy)
    local v62 = setmetatable({}, u44);
    v62.DisplayModel = v62:NewDisplayModel(p61);

    return v62;
end;

local Animation = Instance.new("Animation");
Animation.AnimationId = "rbxassetid://2874840706";
local u63 = nil;

local function getFailureAnimationTrack(p64) -- Line: 323
    -- upvalues: u63 (ref), Animation (copy)
    if p64 == nil then
        return u63;
    end;

    u63 = p64:LoadAnimation(Animation);
    u63.Priority = Enum.AnimationPriority.Action;
    u63.Looped = false;

    return u63;
end;

local function findPlayerHumanoid() -- Line: 333
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        return Character:FindFirstChildOfClass("Humanoid");
    end;
end;

local function createTrailDots(p65, p66) -- Line: 340
    -- upvalues: u20 (copy), u28 (copy)
    local v67 = {};
    local v68 = 1;

    for i = 1, #p65 - 1 do
        local v69 = (p65[i].Position - p65[#p65].Position).magnitude < 3;
        local v70;

        if i % 2 == 0 then
            v70 = not v69;
        else
            v70 = false;
        end;

        if v70 then
            v67[v68] = u20.new(p65[i].Position, i);
            v68 = v68 + 1;
        end;
    end;

    local v71 = u28.new(p65[#p65].Position, #p65, p66);
    table.insert(v67, v71);
    local v72 = {};
    local v73 = 1;

    for i = #v67, 1, -1 do
        v72[v73] = v67[i];
        v73 = v73 + 1;
    end;

    return v72;
end;

local function getTrailDotScale(p74, p75) -- Line: 365
    return p75 * (math.clamp(p74 - 10, 0, 90) / 90 * 1.5 + 1);
end;

local u76 = 0;

function v1.CreatePathDisplay(u77, p78) -- Line: 374
    -- upvalues: u76 (ref), createTrailDots (copy), RunService (copy), Workspace (copy), u11 (ref)
    u76 = u76 + 1;
    local u79 = createTrailDots(u77, p78);

    local function removePathBeforePoint(p80) -- Line: 378
        -- upvalues: u79 (copy)
        for i = #u79, 1, -1 do
            local v81 = u79[i];

            if v81.ClosestWayPoint > p80 then
                break;
            end;

            v81:Destroy();
            u79[i] = nil;
        end;
    end;

    local u82 = "ClickToMoveResizeTrail" .. u76;
    RunService:BindToRenderStep(u82, Enum.RenderPriority.Camera.Value - 1, function() -- Line: 392, Name: resizeTrailDots
        -- upvalues: u79 (copy), RunService (ref), u82 (copy), Workspace (ref), u11 (ref)
        if #u79 == 0 then
            RunService:UnbindFromRenderStep(u82);

            return;
        end;

        local p = Workspace.CurrentCamera.CFrame.p;

        for i = 1, #u79 do
            local TrailDotImage = u79[i].DisplayModel:FindFirstChild("TrailDotImage");

            if TrailDotImage then
                TrailDotImage.Size = u11 * (math.clamp((u79[i].DisplayModel.Position - p).magnitude - 10, 0, 90) / 90 * 1.5 + 1);
            end;
        end;
    end);

    return function() -- Line: 408, Name: removePath
        -- upvalues: removePathBeforePoint (copy), u77 (copy)
        removePathBeforePoint(#u77);
    end, removePathBeforePoint;
end;

local u83 = nil;

function v1.DisplayFailureWaypoint(p84) -- Line: 416
    -- upvalues: u83 (ref), u44 (copy)
    if u83 then
        u83:Hide();
    end;

    local u85 = u44.new(p84);
    u83 = u85;
    coroutine.wrap(function() -- Line: 422
        -- upvalues: u85 (ref)
        u85:RunFailureTween();
        u85:Destroy();
        u85 = nil;
    end)();
end;

function v1.CreateEndWaypoint(p86) -- Line: 429
    -- upvalues: u28 (copy)
    return u28.new(p86);
end;

function v1.PlayFailureAnimation() -- Line: 433
    -- upvalues: LocalPlayer (copy), u63 (ref), Animation (copy)
    local Character = LocalPlayer.Character;
    local v87;

    if Character then
        v87 = Character:FindFirstChildOfClass("Humanoid");
    else
        v87 = nil;
    end;

    if v87 then
        local v88;

        if v87 == nil then
            v88 = u63;
        else
            u63 = v87:LoadAnimation(Animation);
            u63.Priority = Enum.AnimationPriority.Action;
            u63.Looped = false;
            v88 = u63;
        end;

        v88:Play();
    end;
end;

function v1.CancelFailureAnimation() -- Line: 441
    -- upvalues: u63 (ref)
    if u63 ~= nil and u63.IsPlaying then
        u63:Stop();
    end;
end;

function v1.SetWaypointTexture(p89) -- Line: 447
    -- upvalues: u2 (ref), u12 (ref), u13 (ref), u14 (ref), CreateWaypointTemplates (copy)
    u2 = p89;
    local v90, v91, v92 = CreateWaypointTemplates();
    u12 = v90;
    u13 = v91;
    u14 = v92;
end;

function v1.GetWaypointTexture() -- Line: 452
    -- upvalues: u2 (ref)
    return u2;
end;

function v1.SetWaypointRadius(p93) -- Line: 456
    -- upvalues: u11 (ref), u12 (ref), u13 (ref), u14 (ref), CreateWaypointTemplates (copy)
    u11 = Vector2.new(p93, p93);
    local v94, v95, v96 = CreateWaypointTemplates();
    u12 = v94;
    u13 = v95;
    u14 = v96;
end;

function v1.GetWaypointRadius() -- Line: 461
    -- upvalues: u11 (ref)
    return u11.X;
end;

function v1.SetEndWaypointTexture(p97) -- Line: 465
    -- upvalues: u3 (ref), u12 (ref), u13 (ref), u14 (ref), CreateWaypointTemplates (copy)
    u3 = p97;
    local v98, v99, v100 = CreateWaypointTemplates();
    u12 = v98;
    u13 = v99;
    u14 = v100;
end;

function v1.GetEndWaypointTexture() -- Line: 470
    -- upvalues: u3 (ref)
    return u3;
end;

function v1.SetWaypointsAlwaysOnTop(p101) -- Line: 474
    -- upvalues: u4 (ref), u12 (ref), u13 (ref), u14 (ref), CreateWaypointTemplates (copy)
    u4 = p101;
    local v102, v103, v104 = CreateWaypointTemplates();
    u12 = v102;
    u13 = v103;
    u14 = v104;
end;

function v1.GetWaypointsAlwaysOnTop() -- Line: 479
    -- upvalues: u4 (ref)
    return u4;
end;

return v1;