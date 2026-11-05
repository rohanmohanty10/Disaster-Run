  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local u1 = ReplicatedStorage:WaitForChild("ClientCast-Replication");
local v2 = ReplicatedStorage:WaitForChild("ClientCast-Ping");
task.defer(function() -- Line: 8
    -- upvalues: Players (copy)
    script.Parent = Players.LocalPlayer:FindFirstChildOfClass("PlayerScripts");
end);

function v2.OnClientInvoke() -- Line: 13
end;

local u3 = {};
local u4 = {
    AttachmentName = "DmgPoint",
    DebugAttachmentName = "ClientCast-Debug",
    DebugMode = false,
    DebugLifetime = 1,
    DebugColor = Color3.new(1, 0, 0)
};
u3.Settings = u4;
u3.InitiatedCasters = {};
local u5 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) });
local Signal = require(script.Signal);

local function AssertType(p6, p7, p8) -- Line: 37
    if typeof(p6) ~= p7 then
        error(string.format(p8, p7, (typeof(p6))), 3);
    end;
end;

local u11 = {
    DisableDebug = function(p9) -- Line: 45, Name: DisableDebug
        p9._Debug = false;

        for i in next, p9._DebugTrails do
            i.Enabled = false;
        end;
    end,

    StartDebug = function(p10) -- Line: 51, Name: StartDebug
        p10._Debug = true;

        for i in next, p10._DebugTrails do
            i.Enabled = true;
        end;
    end
};
local u12 = {
    Collided = "Any",
    HumanoidCollided = "Humanoid"
};

function u11.Start(p13) -- Line: 63
    -- upvalues: u3 (copy)
    p13.Disabled = false;
    u3.InitiatedCasters[p13] = {};

    if p13._Debug then
        p13:StartDebug();
    end;
end;

function u11.SetObject(p14, p15) -- Line: 71
    p14.Object = p15;

    for _, v in next, p14._DebugTrails do
        v:Destroy();
    end;

    table.clear(p14._DebugTrails);
    table.clear(p14._DamagePoints);
    local _DescendantConnection = p14._DescendantConnection;

    if _DescendantConnection then
        _DescendantConnection:Disconnect();
    end;

    local v16 = next;
    local v17, v18 = p15:GetDescendants();

    for _, v in v16, v17, v18 do
        p14._OnDamagePointAdded(v);
    end;

    p14._DescendantConnection = p15.DescendantAdded:Connect(p14._OnDamagePointAdded);
end;

function u11.Destroy(p19) -- Line: 91
    -- upvalues: u3 (copy)
    p19.Disabled = true;
    u3.InitiatedCasters[p19] = nil;
    p19._DescendantConnection:Disconnect();

    for _, v in next, p19._CollidedEvents do
        for i in next, v do
            i:Destroy();
        end;
    end;

    for _, v in next, p19._DebugTrails do
        v:Destroy();
    end;
end;

function u11.Stop(p20) -- Line: 106
    -- upvalues: u3 (copy)
    p20.Disabled = true;
    u3.InitiatedCasters[p20] = nil;
    local _DescendantConnection = p20._DescendantConnection;

    if _DescendantConnection then
        _DescendantConnection:Disconnect();
        p20._DescendantConnection = nil;
    end;

    local _Debug = p20._Debug;
    p20:DisableDebug();
    p20._Debug = _Debug;
end;

function u11.__index(p21, p22) -- Line: 120
    -- upvalues: u12 (copy), Signal (copy), u11 (copy)
    local v23 = u12[p22];

    if not v23 then
        return rawget(u11, p22);
    end;

    local v24 = Signal.new();
    p21._CollidedEvents[v23][v24] = true;

    return v24.Invoked;
end;

function u3.new(p25, p26) -- Line: 132
    -- upvalues: u4 (copy), u5 (copy), u11 (copy)
    if typeof(p25) ~= "Instance" then
        error(string.format("Unexpected argument #1 to \'CastObject.new\' (%s expected, got %s)", "Instance", (typeof(p25))), 3);
    end;

    local u27 = nil;
    local u28 = {};
    local u29 = {};

    local function OnDamagePointAdded(u30) -- Line: 139
        -- upvalues: u4 (ref), u29 (copy), u27 (ref), u5 (ref), u28 (copy)
        if u30.ClassName == "Attachment" and (u30.Name == u4.AttachmentName and not u29[u30]) then
            local v31 = u30.Parent == u27.Object;
            u29[u30] = v31;
            local Trail = Instance.new("Trail");
            local Attachment = Instance.new("Attachment");
            Attachment.Name = u4.DebugAttachmentName;
            Attachment.Position = u30.Position - Vector3.new(0, 0, 0.1);
            Trail.Color = ColorSequence.new(u4.DebugColor);
            Trail.Enabled = u27._Debug and (v31 or u27.Recursive);
            Trail.LightEmission = 1;
            Trail.Transparency = u5;
            Trail.FaceCamera = true;
            Trail.Lifetime = u4.DebugLifetime;
            Trail.Attachment0 = u30;
            Trail.Attachment1 = Attachment;
            Trail.Parent = Attachment;
            Attachment.Parent = u30.Parent;
            task.spawn(function() -- Line: 163
                -- upvalues: u30 (copy), u27 (ref), Attachment (copy), u28 (ref), Trail (copy), u29 (ref)
                repeat
                    u30.AncestryChanged:Wait();
                until not u30:IsDescendantOf(u27.Object);

                Attachment:Destroy();
                u28[Trail] = nil;
                u29[u30] = nil;
            end);
            u28[Trail] = Attachment;
        end;
    end;

    u27 = setmetatable({
        Disabled = true,
        Recursive = false,
        _Debug = false,
        RaycastParams = p26,
        Object = p25,
        _CollidedEvents = {
            Humanoid = {},
            Any = {}
        },
        _DamagePoints = u29,
        _ToClean = {},
        _DebugTrails = u28,
        _OnDamagePointAdded = OnDamagePointAdded
    }, u11);
    local v32 = next;
    local v33, v34 = p25:GetDescendants();

    for _, v in v32, v33, v34 do
        OnDamagePointAdded(v);
    end;

    u27._DescendantConnection = p25.DescendantAdded:Connect(OnDamagePointAdded);

    return u27;
end;

local function SerializeResult(p35) -- Line: 200
    return {
        Instance = p35.Instance,
        Position = p35.Position,
        Material = p35.Material,
        Normal = p35.Normal
    };
end;

local function DeserializeParams(p36) -- Line: 208
    local v37 = RaycastParams.new();

    for i, v in next, p36 do
        if i == "FilterType" then
            local v = Enum.RaycastFilterType[v];
        end;

        v37[i] = v;
    end;

    return v37;
end;

local function UpdateCasterEvents(p38) -- Line: 219
    -- upvalues: u1 (copy)
    if p38 then
        u1:FireServer("Any", {
            Instance = p38.Instance,
            Position = p38.Position,
            Material = p38.Material,
            Normal = p38.Normal
        });
        local v39 = p38.Instance:FindFirstAncestorOfClass("Model");

        if v39 then
            v39 = v39:FindFirstChildOfClass("Humanoid");
        end;

        if v39 then
            u1:FireServer("Humanoid", {
                Instance = p38.Instance,
                Position = p38.Position,
                Material = p38.Material,
                Normal = p38.Normal
            });
        end;
    end;
end;

local function UpdateAttachment(p40, p41, p42) -- Line: 230
    -- upvalues: UpdateCasterEvents (copy)
    local WorldPosition = p40.WorldPosition;
    local v43 = p42[p40] or WorldPosition;

    if WorldPosition ~= v43 then
        UpdateCasterEvents((workspace:Raycast(WorldPosition, v43 - WorldPosition, p41.RaycastParams)));
    end;

    p42[p40] = WorldPosition;
end;

local u44 = {};
RunService.Heartbeat:Connect(function() -- Line: 244
    -- upvalues: u3 (copy), UpdateCasterEvents (copy)
    for i, v in next, u3.InitiatedCasters do
        if i.Object then
            local Recursive = i.Recursive;

            for i2, v3 in next, i._DamagePoints do
                if v3 or Recursive then
                    local WorldPosition = i2.WorldPosition;
                    local v45 = v[i2] or WorldPosition;

                    if WorldPosition ~= v45 then
                        UpdateCasterEvents((workspace:Raycast(WorldPosition, v45 - WorldPosition, i.RaycastParams)));
                    end;

                    v[i2] = WorldPosition;
                end;
            end;
        end;
    end;
end);

local function CreateCaster(p46) -- Line: 261
    -- upvalues: u3 (copy), u44 (copy)
    local new = u3.new;
    local Object = p46.Object;
    local RaycastParams2 = p46.RaycastParams;
    local v47 = RaycastParams.new();

    for i, v in next, RaycastParams2 do
        if i == "FilterType" then
            local v = Enum.RaycastFilterType[v];
        end;

        v47[i] = v;
    end;

    local v48 = new(Object, v47);
    u44[p46.Id] = v48;
    v48._Debug = p46.Debug;

    return v48;
end;

u1.OnClientEvent:Connect(function(p49, p50, p51) -- Line: 270
    -- upvalues: u44 (copy), u3 (copy)
    if p49 ~= "Start" then
        if p49 == "Destroy" then
            local v52 = u44[p50.Id];

            if v52 then
                v52:Destroy();
                u44[p50.Id] = nil;

                return;
            end;
        elseif p49 == "Stop" then
            local v53 = u44[p50.Id];

            if v53 then
                v53:Stop();

                return;
            end;
        elseif p49 == "Update" then
            local v54 = u44[p50.Id];

            if not v54 then
                local new = u3.new;
                local Object = p50.Object;
                local RaycastParams2 = p50.RaycastParams;
                local v55 = RaycastParams.new();

                for i, v in next, RaycastParams2 do
                    if i == "FilterType" then
                        local v = Enum.RaycastFilterType[v];
                    end;

                    v55[i] = v;
                end;

                v54 = new(Object, v55);
                u44[p50.Id] = v54;
                v54._Debug = p50.Debug;
            end;

            for i, v in next, p51 do
                if i == "Object" then
                    v54:SetObject(v);
                elseif i == "Debug" then
                    v54[(v and "Start" or "Disable") .. "Debug"](v54);
                else
                    v54[i] = v;
                end;
            end;
        end;

        return;
    end;

    local v56 = u44[p50.Id];

    if not v56 then
        local new = u3.new;
        local Object = p50.Object;
        local RaycastParams2 = p50.RaycastParams;
        local v57 = RaycastParams.new();

        for i, v in next, RaycastParams2 do
            if i == "FilterType" then
                local v = Enum.RaycastFilterType[v];
            end;

            v57[i] = v;
        end;

        v56 = new(Object, v57);
        u44[p50.Id] = v56;
        v56._Debug = p50.Debug;
    end;

    v56:Start();
end);