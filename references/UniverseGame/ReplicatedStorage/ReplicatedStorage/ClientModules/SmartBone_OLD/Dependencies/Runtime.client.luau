  

 

local Parent = script.Parent;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;
local u6 = nil;
u6 = Parent:BindToMessage("Setup", function(p7, p8, p9) -- Line: 10
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref)
    u1 = p7;
    u2 = p8;
    u3 = p9;
    u4 = require(p9);
    u5 = true;
    u6:Disconnect();
end);

repeat
    task.wait();
until u5;

local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local u10 = u4.new();
local Dependencies = u3.Dependencies;
local DebugUi = require(Dependencies.DebugUi);
local Utilities = require(Dependencies.Utilities);
local Config = require(Dependencies.Config);
local u11 = RunService:IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG;
local OverlayEvent = u3:WaitForChild("OverlayEvent");
local u12 = {
    Begin = function(...) -- Line: 38, Name: Begin
        -- upvalues: OverlayEvent (copy)
        OverlayEvent:Fire("Begin", ...);
    end,

    End = function(...) -- Line: 41, Name: End
        -- upvalues: OverlayEvent (copy)
        OverlayEvent:Fire("End", ...);
    end,

    Text = function(...) -- Line: 44, Name: Text
        -- upvalues: OverlayEvent (copy)
        OverlayEvent:Fire("Text", ...);
    end
};
shared.FrameCounter = 0;
local u13;

if u11 then
    u13 = require(Dependencies.Iris);

    if not u13.HasInit() then
        u13 = u13.Init();
    end;
else
    u13 = nil;
end;

Parent.Name = `{u1.Name} - {u10.ID}`;
u10:LoadObject(u1);

for _, v in u2 do
    u10:LoadRawCollider(v[1], v[2]);
end;

local u14 = u11 and {
    DRAW_BONE = u13.State(false),
    DRAW_PHYSICAL_BONE = u13.State(false),
    DRAW_ROOT_PART = u13.State(false),
    DRAW_BOUNDING_BOX = u13.State(false),
    DRAW_AXIS_LIMITS = u13.State(false),
    DRAW_COLLIDERS = u13.State(false),
    DRAW_COLLIDER_INFLUENCE = u13.State(false),
    DRAW_COLLIDER_AWAKE = u13.State(false),
    DRAW_COLLIDER_BROADPHASE = u13.State(false),
    DRAW_FILL_COLLIDERS = u13.State(false),
    DRAW_CONTACTS = u13.State(false),
    DRAW_ROTATION_LIMITS = u13.State(false),
    DRAW_ACCELERATION_INFO = u13.State(false)
} or nil;

if u11 then
    u13:Connect(function() -- Line: 90
        -- upvalues: u1 (ref), DebugUi (copy), u13 (ref), u10 (copy), u14 (ref)
        if u1:GetAttribute("Debug") ~= nil then
            DebugUi(u13, u10, u14);
        end;
    end);
end;

CollectionService:GetInstanceAddedSignal("SmartCollider"):Connect(function(p15) -- Line: 97
    -- upvalues: u1 (ref), Utilities (copy), u10 (copy)
    if not p15:IsA("BasePart") then
        return;
    end;

    local v16 = p15:GetAttribute("ColliderKey");
    local v17 = u1:GetAttribute("ColliderKey");

    if tostring(v16) ~= tostring(v17) then
        return;
    end;

    u10:LoadRawCollider(Utilities.GetCollider(p15), p15);
end);
local u18 = nil;
u18 = RunService.Heartbeat:ConnectParallel(function(p19) -- Line: 116
    -- upvalues: u10 (copy), u18 (ref), Parent (copy), u11 (copy), u1 (ref), u14 (ref), u12 (copy)
    local v20 = shared;
    v20.FrameCounter = v20.FrameCounter + 1;

    if shared.FrameCounter > 131072 then
        shared.FrameCounter = 0;
    end;

    u10:StepBoneTrees(p19);

    if not u10.ShouldDestroy then
        if u11 and u1:GetAttribute("Debug") ~= nil then
            task.synchronize();
            u10:DrawDebug(u14.DRAW_COLLIDERS:get(), u14.DRAW_CONTACTS:get(), u14.DRAW_PHYSICAL_BONE:get(), u14.DRAW_BONE:get(), u14.DRAW_AXIS_LIMITS:get(), u14.DRAW_ROOT_PART:get(), u14.DRAW_FILL_COLLIDERS:get(), u14.DRAW_COLLIDER_INFLUENCE:get(), u14.DRAW_COLLIDER_AWAKE:get(), u14.DRAW_COLLIDER_BROADPHASE:get(), u14.DRAW_BOUNDING_BOX:get(), u14.DRAW_ROTATION_LIMITS:get(), u14.DRAW_ACCELERATION_INFO:get());
            u10:DrawOverlay(u12);
        end;

        return;
    end;

    u10:Destroy();
    task.synchronize();
    u18:Disconnect();
    Parent:Destroy();
end);