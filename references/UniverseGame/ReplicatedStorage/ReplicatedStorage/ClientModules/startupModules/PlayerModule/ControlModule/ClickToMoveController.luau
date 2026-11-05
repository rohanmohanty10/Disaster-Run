  

 

local success, result = pcall(function() -- Line: 9
    return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding");
end);
local u1 = success and result;
local UserInputService = game:GetService("UserInputService");
local PathfindingService = game:GetService("PathfindingService");
local Players = game:GetService("Players");
game:GetService("Debris");
local StarterGui = game:GetService("StarterGui");
local Workspace = game:GetService("Workspace");
local CollectionService = game:GetService("CollectionService");
local GuiService = game:GetService("GuiService");
local u2 = true;
local u3 = true;
local u4 = false;
local u5 = 1;
local u6 = 8;
local u7 = {
    [Enum.KeyCode.W] = true,
    [Enum.KeyCode.A] = true,
    [Enum.KeyCode.S] = true,
    [Enum.KeyCode.D] = true,
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.Down] = true
};
local LocalPlayer = Players.LocalPlayer;
local ClickToMoveDisplay = require(script.Parent:WaitForChild("ClickToMoveDisplay"));
local u8 = {};

local function FindCharacterAncestor(p9) -- Line: 51
    -- upvalues: FindCharacterAncestor (copy)
    if p9 then
        local v10 = p9:FindFirstChildOfClass("Humanoid");

        if v10 then
            return p9, v10;
        end;

        return FindCharacterAncestor(p9.Parent);
    end;
end;

u8.FindCharacterAncestor = FindCharacterAncestor;

local function Raycast(p11, p12, p13) -- Line: 63
    -- upvalues: Workspace (copy), FindCharacterAncestor (copy), Raycast (copy)
    local v14 = p13 or {};
    local v15, v16, v17, v18 = Workspace:FindPartOnRayWithIgnoreList(p11, v14);

    if not v15 then
        return nil, nil;
    end;

    if p12 and v15.CanCollide == false then
        local v19;

        if v15 then
            v19 = v15:FindFirstChildOfClass("Humanoid");

            if not v19 then
                local v20;
                v20, v19 = FindCharacterAncestor(v15.Parent);
            end;
        else
            v19 = nil;
        end;

        if v19 == nil then
            table.insert(v14, v15);

            return Raycast(p11, p12, v14);
        end;
    end;

    return v15, v16, v17, v18;
end;

u8.Raycast = Raycast;
local u21 = {};

local function findPlayerHumanoid(p22) -- Line: 84
    -- upvalues: u21 (copy)
    local v23;

    if p22 then
        v23 = p22.Character;
    else
        v23 = p22;
    end;

    if v23 then
        local v24 = u21[p22];

        if v24 and v24.Parent == v23 then
            return v24;
        end;

        u21[p22] = nil;
        local v25 = v23:FindFirstChildOfClass("Humanoid");

        if v25 then
            u21[p22] = v25;
        end;

        return v25;
    end;
end;

local u26 = nil;
local u27 = nil;
local u28 = nil;
local u29 = nil;

local function GetCharacter() -- Line: 108
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer and LocalPlayer.Character;
end;

local function UpdateIgnoreTag(p30) -- Line: 112
    -- upvalues: u27 (ref), u28 (ref), u29 (ref), u26 (ref), LocalPlayer (copy), CollectionService (copy)
    if p30 == u27 then
        return;
    end;

    if u28 then
        u28:Disconnect();
        u28 = nil;
    end;

    if u29 then
        u29:Disconnect();
        u29 = nil;
    end;

    u27 = p30;
    local v31 = {};
    v31[1] = LocalPlayer and LocalPlayer.Character;
    u26 = v31;

    if u27 ~= nil then
        local v32 = CollectionService:GetTagged(u27);

        for _, v in ipairs(v32) do
            table.insert(u26, v);
        end;

        u28 = CollectionService:GetInstanceAddedSignal(u27):Connect(function(p33) -- Line: 132
            -- upvalues: u26 (ref)
            table.insert(u26, p33);
        end);
        u29 = CollectionService:GetInstanceRemovedSignal(u27):Connect(function(p34) -- Line: 136
            -- upvalues: u26 (ref)
            for i = 1, #u26 do
                if u26[i] == p34 then
                    u26[i] = u26[#u26];
                    table.remove(u26);

                    return;
                end;
            end;
        end);
    end;
end;

local function getIgnoreList() -- Line: 148
    -- upvalues: u26 (ref), LocalPlayer (copy)
    if u26 then
        return u26;
    end;

    u26 = {};
    table.insert(u26, LocalPlayer and LocalPlayer.Character);

    return u26;
end;

local function minV(p35, p36) -- Line: 157
    local v37 = math.min(p35.X, p36.X);
    local v38 = math.min(p35.Y, p36.Y);
    local v39 = math.min(p35.Z, p36.Z);

    return Vector3.new(v37, v38, v39);
end;

local function maxV(p40, p41) -- Line: 160
    local v42 = math.max(p40.X, p41.X);
    local v43 = math.max(p40.Y, p41.Y);
    local v44 = math.max(p40.Z, p41.Z);

    return Vector3.new(v42, v43, v44);
end;

local function getCollidableExtentsSize(p45) -- Line: 163
    if p45 ~= nil and p45.PrimaryPart ~= nil then
        local v46 = p45.PrimaryPart.CFrame:inverse();
        local v47 = Vector3.new(inf, inf, inf);
        local v48 = Vector3.new(-inf, -inf, -inf);

        for _, descendant in pairs(p45:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.CanCollide then
                local v49 = v46 * descendant.CFrame;
                local v50 = Vector3.new(descendant.Size.X / 2, descendant.Size.Y / 2, descendant.Size.Z / 2);
                local v51 = {
                    Vector3.new(v50.X, v50.Y, v50.Z),
                    Vector3.new(v50.X, v50.Y, -v50.Z),
                    Vector3.new(v50.X, -v50.Y, v50.Z),
                    Vector3.new(v50.X, -v50.Y, -v50.Z),
                    Vector3.new(-v50.X, v50.Y, v50.Z),
                    Vector3.new(-v50.X, v50.Y, -v50.Z),
                    Vector3.new(-v50.X, -v50.Y, v50.Z),
                    (Vector3.new(-v50.X, -v50.Y, -v50.Z))
                };

                for _, v in ipairs(v51) do
                    local v52 = v49 * v;
                    local v53 = math.min(v47.X, v52.X);
                    local v54 = math.min(v47.Y, v52.Y);
                    local v55 = math.min(v47.Z, v52.Z);
                    v47 = Vector3.new(v53, v54, v55);
                    local v56 = math.max(v48.X, v52.X);
                    local v57 = math.max(v48.Y, v52.Y);
                    local v58 = math.max(v48.Z, v52.Z);
                    v48 = Vector3.new(v56, v57, v58);
                end;
            end;
        end;

        local v59 = v48 - v47;

        if v59.X < 0 or (v59.Y < 0 or v59.Z < 0) then
            return nil;
        end;

        return v59;
    end;
end;

local function Pather(p60, p61, p62) -- Line: 196
    -- upvalues: u4 (ref), LocalPlayer (copy), u21 (copy), u5 (ref), u1 (copy), getCollidableExtentsSize (copy), PathfindingService (copy), u2 (ref), ClickToMoveDisplay (copy), u6 (ref), Workspace (copy), u26 (ref)
    local u63 = {};
    local v64;

    if p62 == nil then
        v64 = u4;
        p62 = true;
    else
        v64 = p62;
    end;

    u63.Cancelled = false;
    u63.Started = false;
    u63.Finished = Instance.new("BindableEvent");
    u63.PathFailed = Instance.new("BindableEvent");
    u63.PathComputing = false;
    u63.PathComputed = false;
    u63.OriginalTargetPoint = p60;
    u63.TargetPoint = p60;
    u63.TargetSurfaceNormal = p61;
    u63.DiedConn = nil;
    u63.SeatedConn = nil;
    u63.BlockedConn = nil;
    u63.TeleportedConn = nil;
    u63.CurrentPoint = 0;
    u63.HumanoidOffsetFromPath = Vector3.new(0, 0, 0);
    u63.CurrentWaypointPosition = nil;
    u63.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
    u63.CurrentWaypointPlaneDistance = 0;
    u63.CurrentWaypointNeedsJump = false;
    u63.CurrentHumanoidPosition = Vector3.new(0, 0, 0);
    u63.CurrentHumanoidVelocity = 0;
    u63.NextActionMoveDirection = Vector3.new(0, 0, 0);
    u63.NextActionJump = false;
    u63.Timeout = 0;
    local v65 = LocalPlayer;
    local v66;

    if v65 then
        v66 = v65.Character;
    else
        v66 = v65;
    end;

    local v67;

    if v66 then
        v67 = u21[v65];

        if not v67 or v67.Parent ~= v66 then
            u21[v65] = nil;
            v67 = v66:FindFirstChildOfClass("Humanoid");

            if v67 then
                u21[v65] = v67;
            end;
        end;
    else
        v67 = nil;
    end;

    u63.Humanoid = v67;
    u63.OriginPoint = nil;
    u63.AgentCanFollowPath = false;
    u63.DirectPath = false;
    u63.DirectPathRiseFirst = false;
    local v68 = u63.Humanoid and u63.Humanoid.RootPart;

    if v68 then
        u63.OriginPoint = v68.CFrame.p;
        local v69 = 2;
        local v70 = 5;
        local v71 = true;
        local SeatPart = u63.Humanoid.SeatPart;

        if SeatPart and SeatPart:IsA("VehicleSeat") then
            local v72 = SeatPart:FindFirstAncestorOfClass("Model");

            if v72 then
                local PrimaryPart = v72.PrimaryPart;
                v72.PrimaryPart = SeatPart;

                if p62 then
                    local v73 = v72:GetExtentsSize();
                    v69 = u5 * 0.5 * math.sqrt(v73.X * v73.X + v73.Z * v73.Z);
                    v70 = u5 * v73.Y;
                    u63.AgentCanFollowPath = true;
                    u63.DirectPath = p62;
                    v71 = false;
                end;

                v72.PrimaryPart = PrimaryPart;
            end;
        else
            local v74 = nil;

            if u1 then
                local v75 = LocalPlayer and LocalPlayer.Character;

                if v75 ~= nil then
                    v74 = getCollidableExtentsSize(v75);
                end;
            end;

            if v74 == nil then
                v74 = (LocalPlayer and LocalPlayer.Character):GetExtentsSize();
            end;

            v69 = u5 * 0.5 * math.sqrt(v74.X * v74.X + v74.Z * v74.Z);
            v70 = u5 * v74.Y;
            v71 = u63.Humanoid.JumpPower > 0;
            u63.AgentCanFollowPath = true;
            u63.DirectPath = v64;
            u63.DirectPathRiseFirst = u63.Humanoid.Sit;
        end;

        u63.pathResult = PathfindingService:CreatePath({
            AgentRadius = v69,
            AgentHeight = v70,
            AgentCanJump = v71
        });
    end;

    function u63.Cleanup(p76) -- Line: 305
        -- upvalues: u63 (copy)
        if u63.stopTraverseFunc then
            u63.stopTraverseFunc();
            u63.stopTraverseFunc = nil;
        end;

        if u63.MoveToConn then
            u63.MoveToConn:Disconnect();
            u63.MoveToConn = nil;
        end;

        if u63.BlockedConn then
            u63.BlockedConn:Disconnect();
            u63.BlockedConn = nil;
        end;

        if u63.DiedConn then
            u63.DiedConn:Disconnect();
            u63.DiedConn = nil;
        end;

        if u63.SeatedConn then
            u63.SeatedConn:Disconnect();
            u63.SeatedConn = nil;
        end;

        if u63.TeleportedConn then
            u63.TeleportedConn:Disconnect();
            u63.TeleportedConn = nil;
        end;

        u63.Started = false;
    end;

    function u63.Cancel(p77) -- Line: 339
        -- upvalues: u63 (copy)
        u63.Cancelled = true;
        u63:Cleanup();
    end;

    function u63.IsActive(p78) -- Line: 344
        -- upvalues: u63 (copy)
        return u63.AgentCanFollowPath and u63.Started and not u63.Cancelled;
    end;

    function u63.OnPathInterrupted(p79) -- Line: 348
        -- upvalues: u63 (copy)
        u63.Cancelled = true;
        u63:OnPointReached(false);
    end;

    function u63.ComputePath(p80) -- Line: 354
        -- upvalues: u63 (copy)
        if u63.OriginPoint then
            if u63.PathComputed or u63.PathComputing then
                return;
            end;

            u63.PathComputing = true;

            if u63.AgentCanFollowPath then
                if u63.DirectPath then
                    u63.pointList = { PathWaypoint.new(u63.OriginPoint, Enum.PathWaypointAction.Walk), PathWaypoint.new(u63.TargetPoint, u63.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk) };
                    u63.PathComputed = true;
                else
                    u63.pathResult:ComputeAsync(u63.OriginPoint, u63.TargetPoint);
                    u63.pointList = u63.pathResult:GetWaypoints();
                    u63.BlockedConn = u63.pathResult.Blocked:Connect(function(p81) -- Line: 368
                        -- upvalues: u63 (ref)
                        u63:OnPathBlocked(p81);
                    end);
                    u63.PathComputed = u63.pathResult.Status == Enum.PathStatus.Success;
                end;
            end;

            u63.PathComputing = false;
        end;
    end;

    function u63.IsValidPath(p82) -- Line: 376
        -- upvalues: u63 (copy)
        u63:ComputePath();

        return u63.PathComputed and u63.AgentCanFollowPath;
    end;

    u63.Recomputing = false;

    function u63.OnPathBlocked(p83, p84) -- Line: 382
        -- upvalues: u63 (copy), u2 (ref), ClickToMoveDisplay (ref)
        if u63.CurrentPoint > p84 or u63.Recomputing then
            return;
        end;

        u63.Recomputing = true;

        if u63.stopTraverseFunc then
            u63.stopTraverseFunc();
            u63.stopTraverseFunc = nil;
        end;

        u63.OriginPoint = u63.Humanoid.RootPart.CFrame.p;
        u63.pathResult:ComputeAsync(u63.OriginPoint, u63.TargetPoint);
        u63.pointList = u63.pathResult:GetWaypoints();

        if #u63.pointList > 0 then
            u63.HumanoidOffsetFromPath = u63.pointList[1].Position - u63.OriginPoint;
        end;

        u63.PathComputed = u63.pathResult.Status == Enum.PathStatus.Success;

        if u2 then
            local v85, v86 = ClickToMoveDisplay.CreatePathDisplay(u63.pointList);
            u63.stopTraverseFunc = v85;
            u63.setPointFunc = v86;
        end;

        if u63.PathComputed then
            u63.CurrentPoint = 1;
            u63:OnPointReached(true);
        else
            u63.PathFailed:Fire();
            u63:Cleanup();
        end;

        u63.Recomputing = false;
    end;

    function u63.OnRenderStepped(p87, p88) -- Line: 418
        -- upvalues: u63 (copy), u6 (ref)
        if u63.Started and not u63.Cancelled then
            u63.Timeout = u63.Timeout + p88;

            if u6 < u63.Timeout then
                u63:OnPointReached(false);

                return;
            end;

            u63.CurrentHumanoidPosition = u63.Humanoid.RootPart.Position + u63.HumanoidOffsetFromPath;
            u63.CurrentHumanoidVelocity = u63.Humanoid.RootPart.Velocity;

            while u63.Started and u63:IsCurrentWaypointReached() do
                u63:OnPointReached(true);
            end;

            if u63.Started then
                u63.NextActionMoveDirection = u63.CurrentWaypointPosition - u63.CurrentHumanoidPosition;

                if u63.NextActionMoveDirection.Magnitude > 1e-6 then
                    u63.NextActionMoveDirection = u63.NextActionMoveDirection.Unit;
                else
                    u63.NextActionMoveDirection = Vector3.new(0, 0, 0);
                end;

                if u63.CurrentWaypointNeedsJump then
                    u63.NextActionJump = true;
                    u63.CurrentWaypointNeedsJump = false;

                    return;
                end;

                u63.NextActionJump = false;
            end;
        end;
    end;

    function u63.IsCurrentWaypointReached(p89) -- Line: 456
        -- upvalues: u63 (copy)
        local v90;

        if u63.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0) then
            v90 = true;
        else
            local v91 = u63.CurrentWaypointPlaneNormal:Dot(u63.CurrentHumanoidPosition) - u63.CurrentWaypointPlaneDistance;
            local v92 = 0.0625 * -u63.CurrentWaypointPlaneNormal:Dot(u63.CurrentHumanoidVelocity);
            v90 = v91 < math.max(1, v92);
        end;

        if v90 then
            u63.CurrentWaypointPosition = nil;
            u63.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
            u63.CurrentWaypointPlaneDistance = 0;
        end;

        return v90;
    end;

    function u63.OnPointReached(p93, p94) -- Line: 482
        -- upvalues: u63 (copy)
        if not p94 or u63.Cancelled then
            u63.PathFailed:Fire();
            u63:Cleanup();

            return;
        end;

        if u63.setPointFunc then
            u63.setPointFunc(u63.CurrentPoint);
        end;

        local v95 = u63.CurrentPoint + 1;

        if #u63.pointList < v95 then
            if u63.stopTraverseFunc then
                u63.stopTraverseFunc();
            end;

            u63.Finished:Fire();
            u63:Cleanup();

            return;
        end;

        local v96 = u63.pointList[u63.CurrentPoint];
        local v97 = u63.pointList[v95];
        local v98 = u63.Humanoid:GetState();

        if (v98 == Enum.HumanoidStateType.FallingDown or v98 == Enum.HumanoidStateType.Freefall) and true or v98 == Enum.HumanoidStateType.Jumping then
            local v99 = v97.Action == Enum.PathWaypointAction.Jump;

            if not v99 and u63.CurrentPoint > 1 then
                local v100 = v96.Position - u63.pointList[u63.CurrentPoint - 1].Position;
                local v101 = v97.Position - v96.Position;
                v99 = Vector2.new(v100.x, v100.z).Unit:Dot(Vector2.new(v101.x, v101.z).Unit) < 0.996;
            end;

            if v99 then
                u63.Humanoid.FreeFalling:Wait();
                wait(0.1);
            end;
        end;

        u63:MoveToNextWayPoint(v96, v97, v95);
    end;

    function u63.MoveToNextWayPoint(p102, p103, p104, p105) -- Line: 545
        -- upvalues: u63 (copy)
        u63.CurrentWaypointPlaneNormal = p103.Position - p104.Position;
        u63.CurrentWaypointPlaneNormal = Vector3.new(u63.CurrentWaypointPlaneNormal.X, 0, u63.CurrentWaypointPlaneNormal.Z);

        if u63.CurrentWaypointPlaneNormal.Magnitude > 1e-6 then
            u63.CurrentWaypointPlaneNormal = u63.CurrentWaypointPlaneNormal.Unit;
            u63.CurrentWaypointPlaneDistance = u63.CurrentWaypointPlaneNormal:Dot(p104.Position);
        else
            u63.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
            u63.CurrentWaypointPlaneDistance = 0;
        end;

        u63.CurrentWaypointNeedsJump = p104.Action == Enum.PathWaypointAction.Jump;
        u63.CurrentWaypointPosition = p104.Position;
        u63.CurrentPoint = p105;
        u63.Timeout = 0;
    end;

    function u63.Start(p106, p107) -- Line: 573
        -- upvalues: u63 (copy), ClickToMoveDisplay (ref), u2 (ref)
        if not u63.AgentCanFollowPath then
            u63.PathFailed:Fire();

            return;
        end;

        if u63.Started then
            return;
        end;

        u63.Started = true;
        ClickToMoveDisplay.CancelFailureAnimation();

        if u2 and (p107 == nil or p107) then
            local v108, v109 = ClickToMoveDisplay.CreatePathDisplay(u63.pointList, u63.OriginalTargetPoint);
            u63.stopTraverseFunc = v108;
            u63.setPointFunc = v109;
        end;

        if #u63.pointList <= 0 then
            u63.PathFailed:Fire();

            if u63.stopTraverseFunc then
                u63.stopTraverseFunc();
            end;

            return;
        end;

        u63.HumanoidOffsetFromPath = Vector3.new(0, u63.pointList[1].Position.Y - u63.OriginPoint.Y, 0);
        u63.CurrentHumanoidPosition = u63.Humanoid.RootPart.Position + u63.HumanoidOffsetFromPath;
        u63.CurrentHumanoidVelocity = u63.Humanoid.RootPart.Velocity;
        u63.SeatedConn = u63.Humanoid.Seated:Connect(function(p110, p111) -- Line: 600
            -- upvalues: u63 (ref)
            u63:OnPathInterrupted();
        end);
        u63.DiedConn = u63.Humanoid.Died:Connect(function() -- Line: 601
            -- upvalues: u63 (ref)
            u63:OnPathInterrupted();
        end);
        u63.TeleportedConn = u63.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function() -- Line: 602
            -- upvalues: u63 (ref)
            u63:OnPathInterrupted();
        end);
        u63.CurrentPoint = 1;
        u63:OnPointReached(true);
    end;

    local v112 = Ray.new(u63.TargetPoint + u63.TargetSurfaceNormal * 1.5, Vector3.new(0, -50, 0));
    local v113;

    if u26 then
        v113 = u26;
    else
        u26 = {};
        table.insert(u26, LocalPlayer and LocalPlayer.Character);
        v113 = u26;
    end;

    local v114, v115 = Workspace:FindPartOnRayWithIgnoreList(v112, v113);

    if v114 then
        u63.TargetPoint = v115;
    end;

    u63:ComputePath();

    return u63;
end;

local function CheckAlive() -- Line: 629
    -- upvalues: LocalPlayer (copy), u21 (copy)
    local v116 = LocalPlayer;
    local v117;

    if v116 then
        v117 = v116.Character;
    else
        v117 = v116;
    end;

    local v118;

    if v117 then
        v118 = u21[v116];

        if not v118 or v118.Parent ~= v117 then
            u21[v116] = nil;
            v118 = v117:FindFirstChildOfClass("Humanoid");

            if v118 then
                u21[v116] = v118;
            end;
        end;
    else
        v118 = nil;
    end;

    local v119;

    if v118 == nil then
        v119 = false;
    else
        v119 = v118.Health > 0;
    end;

    return v119;
end;

local function GetEquippedTool(p120) -- Line: 634
    if p120 ~= nil then
        for _, child in pairs(p120:GetChildren()) do
            if child:IsA("Tool") then
                return child;
            end;
        end;
    end;
end;

local u121 = nil;
local u122 = nil;
local u123 = nil;

local function CleanupPath() -- Line: 649
    -- upvalues: u121 (ref), u122 (ref), u123 (ref)
    if u121 then
        u121:Cancel();
        u121 = nil;
    end;

    if u122 then
        u122:Disconnect();
        u122 = nil;
    end;

    if u123 then
        u123:Disconnect();
        u123 = nil;
    end;
end;

local function HandleMoveTo(p124, u125, u126, u127, u128) -- Line: 667
    -- upvalues: u121 (ref), u122 (ref), u123 (ref), GetEquippedTool (copy), u3 (ref), ClickToMoveDisplay (copy)
    if u121 then
        if u121 then
            u121:Cancel();
            u121 = nil;
        end;

        if u122 then
            u122:Disconnect();
            u122 = nil;
        end;

        if u123 then
            u123:Disconnect();
            u123 = nil;
        end;
    end;

    u121 = p124;
    p124:Start(u128);
    u122 = p124.Finished.Event:Connect(function() -- Line: 674
        -- upvalues: u121 (ref), u122 (ref), u123 (ref), u126 (copy), GetEquippedTool (ref), u127 (copy)
        if u121 then
            u121:Cancel();
            u121 = nil;
        end;

        if u122 then
            u122:Disconnect();
            u122 = nil;
        end;

        if u123 then
            u123:Disconnect();
            u123 = nil;
        end;

        local v129 = u126 and GetEquippedTool(u127);

        if v129 then
            v129:Activate();
        end;
    end);
    u123 = p124.PathFailed.Event:Connect(function() -- Line: 683
        -- upvalues: u121 (ref), u122 (ref), u123 (ref), u128 (copy), u3 (ref), ClickToMoveDisplay (ref), u125 (copy)
        if u121 then
            u121:Cancel();
            u121 = nil;
        end;

        if u122 then
            u122:Disconnect();
            u122 = nil;
        end;

        if u123 then
            u123:Disconnect();
            u123 = nil;
        end;

        if u128 == nil or u128 then
            local v130 = u3;

            if v130 then
                local v131 = u121 and u121:IsActive();
                v130 = not v131;
            end;

            if v130 then
                ClickToMoveDisplay.PlayFailureAnimation();
            end;

            ClickToMoveDisplay.DisplayFailureWaypoint(u125);
        end;
    end);
end;

local function ShowPathFailedFeedback(p132) -- Line: 695
    -- upvalues: u121 (ref), u3 (ref), ClickToMoveDisplay (copy)
    if u121 and u121:IsActive() then
        u121:Cancel();
    end;

    if u3 then
        ClickToMoveDisplay.PlayFailureAnimation();
    end;

    ClickToMoveDisplay.DisplayFailureWaypoint(p132);
end;

function OnTap(p133, p134, p135)
    -- upvalues: Workspace (copy), LocalPlayer (copy), u21 (copy), u8 (copy), u26 (ref), StarterGui (copy), Players (copy), u121 (ref), u122 (ref), u123 (ref), Pather (copy), HandleMoveTo (copy), u3 (ref), ClickToMoveDisplay (copy), GetEquippedTool (copy)
    local CurrentCamera = Workspace.CurrentCamera;
    local Character = LocalPlayer.Character;
    local v136 = LocalPlayer;
    local v137;

    if v136 then
        v137 = v136.Character;
    else
        v137 = v136;
    end;

    local v138;

    if v137 then
        v138 = u21[v136];

        if not v138 or v138.Parent ~= v137 then
            u21[v136] = nil;
            v138 = v137:FindFirstChildOfClass("Humanoid");

            if v138 then
                u21[v136] = v138;
            end;
        end;
    else
        v138 = nil;
    end;

    local v139;

    if v138 == nil then
        v139 = false;
    else
        v139 = v138.Health > 0;
    end;

    if not v139 then
        return;
    end;

    if #p133 == 1 or p134 then
        if CurrentCamera then
            local v140 = CurrentCamera:ScreenPointToRay(p133[1].x, p133[1].y);
            local v141 = Ray.new(v140.Origin, v140.Direction * 1000);
            local v142 = LocalPlayer;
            local v143;

            if v142 then
                v143 = v142.Character;
            else
                v143 = v142;
            end;

            if v143 then
                local v144 = u21[v142];

                if not v144 or v144.Parent ~= v143 then
                    u21[v142] = nil;
                    local v145 = v143:FindFirstChildOfClass("Humanoid");

                    if v145 then
                        u21[v142] = v145;
                    end;
                end;
            end;

            local Raycast2 = u8.Raycast;
            local v146;

            if u26 then
                v146 = u26;
            else
                u26 = {};
                table.insert(u26, LocalPlayer and LocalPlayer.Character);
                v146 = u26;
            end;

            local v147, v148, v149 = Raycast2(v141, true, v146);
            local v150, v151 = u8.FindCharacterAncestor(v147);

            if p135 and (v151 and (StarterGui:GetCore("AvatarContextMenuEnabled") and Players:GetPlayerFromCharacter(v151.Parent))) then
                if u121 then
                    u121:Cancel();
                    u121 = nil;
                end;

                if u122 then
                    u122:Disconnect();
                    u122 = nil;
                end;

                if u123 then
                    u123:Disconnect();
                    u123 = nil;
                end;

                return;
            end;

            if p134 then
                v150 = nil;
            else
                p134 = v148;
            end;

            if p134 and Character then
                if u121 then
                    u121:Cancel();
                    u121 = nil;
                end;

                if u122 then
                    u122:Disconnect();
                    u122 = nil;
                end;

                if u123 then
                    u123:Disconnect();
                    u123 = nil;
                end;

                local v152 = Pather(p134, v149);

                if v152:IsValidPath() then
                    HandleMoveTo(v152, p134, v150, Character);

                    return;
                end;

                v152:Cleanup();

                if u121 and u121:IsActive() then
                    u121:Cancel();
                end;

                if u3 then
                    ClickToMoveDisplay.PlayFailureAnimation();
                end;

                ClickToMoveDisplay.DisplayFailureWaypoint(p134);
            end;
        end;
    else
        local v153 = #p133 >= 2 and (CurrentCamera and GetEquippedTool(Character));

        if v153 then
            v153:Activate();
        end;
    end;
end;

local function DisconnectEvent(p154) -- Line: 758
    if p154 then
        p154:Disconnect();
    end;
end;

local Keyboard = require(script.Parent:WaitForChild("Keyboard"));
local u155 = setmetatable({}, Keyboard);
u155.__index = u155;

function u155.new(p156) -- Line: 769
    -- upvalues: Keyboard (copy), u155 (copy)
    local v157 = Keyboard.new(p156);
    local v158 = setmetatable(v157, u155);
    v158.fingerTouches = {};
    v158.numUnsunkTouches = 0;
    v158.mouse1Down = tick();
    v158.mouse1DownPos = Vector2.new();
    v158.mouse2DownTime = tick();
    v158.mouse2DownPos = Vector2.new();
    v158.mouse2UpTime = tick();
    v158.keyboardMoveVector = Vector3.new(0, 0, 0);
    v158.tapConn = nil;
    v158.inputBeganConn = nil;
    v158.inputChangedConn = nil;
    v158.inputEndedConn = nil;
    v158.humanoidDiedConn = nil;
    v158.characterChildAddedConn = nil;
    v158.onCharacterAddedConn = nil;
    v158.characterChildRemovedConn = nil;
    v158.renderSteppedConn = nil;
    v158.menuOpenedConnection = nil;
    v158.running = false;
    v158.wasdEnabled = false;

    return v158;
end;

function u155.DisconnectEvents(p159) -- Line: 801
    local tapConn = p159.tapConn;

    if tapConn then
        tapConn:Disconnect();
    end;

    local inputBeganConn = p159.inputBeganConn;

    if inputBeganConn then
        inputBeganConn:Disconnect();
    end;

    local inputChangedConn = p159.inputChangedConn;

    if inputChangedConn then
        inputChangedConn:Disconnect();
    end;

    local inputEndedConn = p159.inputEndedConn;

    if inputEndedConn then
        inputEndedConn:Disconnect();
    end;

    local humanoidDiedConn = p159.humanoidDiedConn;

    if humanoidDiedConn then
        humanoidDiedConn:Disconnect();
    end;

    local characterChildAddedConn = p159.characterChildAddedConn;

    if characterChildAddedConn then
        characterChildAddedConn:Disconnect();
    end;

    local onCharacterAddedConn = p159.onCharacterAddedConn;

    if onCharacterAddedConn then
        onCharacterAddedConn:Disconnect();
    end;

    local renderSteppedConn = p159.renderSteppedConn;

    if renderSteppedConn then
        renderSteppedConn:Disconnect();
    end;

    local characterChildRemovedConn = p159.characterChildRemovedConn;

    if characterChildRemovedConn then
        characterChildRemovedConn:Disconnect();
    end;

    local menuOpenedConnection = p159.menuOpenedConnection;

    if menuOpenedConnection then
        menuOpenedConnection:Disconnect();
    end;
end;

function u155.OnTouchBegan(p160, p161, p162) -- Line: 814
    if p160.fingerTouches[p161] == nil and not p162 then
        p160.numUnsunkTouches = p160.numUnsunkTouches + 1;
    end;

    p160.fingerTouches[p161] = p162;
end;

function u155.OnTouchChanged(p163, p164, p165) -- Line: 821
    if p163.fingerTouches[p164] == nil then
        p163.fingerTouches[p164] = p165;

        if not p165 then
            p163.numUnsunkTouches = p163.numUnsunkTouches + 1;
        end;
    end;
end;

function u155.OnTouchEnded(p166, p167, p168) -- Line: 830
    if p166.fingerTouches[p167] ~= nil and p166.fingerTouches[p167] == false then
        p166.numUnsunkTouches = p166.numUnsunkTouches - 1;
    end;

    p166.fingerTouches[p167] = nil;
end;

function u155.OnCharacterAdded(u169, p170) -- Line: 838
    -- upvalues: UserInputService (copy), u7 (copy), u121 (ref), u122 (ref), u123 (ref), ClickToMoveDisplay (copy), GuiService (copy)
    u169:DisconnectEvents();
    u169.inputBeganConn = UserInputService.InputBegan:Connect(function(p171, p172) -- Line: 841
        -- upvalues: u169 (copy), u7 (ref), u121 (ref), u122 (ref), u123 (ref), ClickToMoveDisplay (ref)
        if p171.UserInputType == Enum.UserInputType.Touch then
            u169:OnTouchBegan(p171, p172);
        end;

        if u169.wasdEnabled and (p172 == false and (p171.UserInputType == Enum.UserInputType.Keyboard and u7[p171.KeyCode])) then
            if u121 then
                u121:Cancel();
                u121 = nil;
            end;

            if u122 then
                u122:Disconnect();
                u122 = nil;
            end;

            if u123 then
                u123:Disconnect();
                u123 = nil;
            end;

            ClickToMoveDisplay.CancelFailureAnimation();
        end;

        if p171.UserInputType == Enum.UserInputType.MouseButton1 then
            u169.mouse1DownTime = tick();
            u169.mouse1DownPos = p171.Position;
        end;

        if p171.UserInputType == Enum.UserInputType.MouseButton2 then
            u169.mouse2DownTime = tick();
            u169.mouse2DownPos = p171.Position;
        end;
    end);
    u169.inputChangedConn = UserInputService.InputChanged:Connect(function(p173, p174) -- Line: 862
        -- upvalues: u169 (copy)
        if p173.UserInputType == Enum.UserInputType.Touch then
            u169:OnTouchChanged(p173, p174);
        end;
    end);
    u169.inputEndedConn = UserInputService.InputEnded:Connect(function(p175, p176) -- Line: 868
        -- upvalues: u169 (copy), u121 (ref)
        if p175.UserInputType == Enum.UserInputType.Touch then
            u169:OnTouchEnded(p175, p176);
        end;

        if p175.UserInputType == Enum.UserInputType.MouseButton2 then
            u169.mouse2UpTime = tick();
            local Position = p175.Position;

            if u169.mouse2UpTime - u169.mouse2DownTime < 0.25 and ((Position - u169.mouse2DownPos).magnitude < 5 and (u121 or u169.keyboardMoveVector.Magnitude <= 0)) then
                OnTap({ Position });
            end;
        end;
    end);
    u169.tapConn = UserInputService.TouchTap:Connect(function(p177, p178) -- Line: 885
        if not p178 then
            OnTap(p177, nil, true);
        end;
    end);
    u169.menuOpenedConnection = GuiService.MenuOpened:Connect(function() -- Line: 891
        -- upvalues: u121 (ref), u122 (ref), u123 (ref)
        if u121 then
            u121:Cancel();
            u121 = nil;
        end;

        if u122 then
            u122:Disconnect();
            u122 = nil;
        end;

        if u123 then
            u123:Disconnect();
            u123 = nil;
        end;
    end);

    local function OnCharacterChildAdded(p179) -- Line: 895
        -- upvalues: UserInputService (ref), u169 (copy)
        if UserInputService.TouchEnabled and p179:IsA("Tool") then
            p179.ManualActivationOnly = true;
        end;

        if p179:IsA("Humanoid") then
            local humanoidDiedConn = u169.humanoidDiedConn;

            if humanoidDiedConn then
                humanoidDiedConn:Disconnect();
            end;

            u169.humanoidDiedConn = p179.Died:Connect(function() -- Line: 903
            end);
        end;
    end;

    u169.characterChildAddedConn = p170.ChildAdded:Connect(function(p180) -- Line: 911
        -- upvalues: OnCharacterChildAdded (copy)
        OnCharacterChildAdded(p180);
    end);
    u169.characterChildRemovedConn = p170.ChildRemoved:Connect(function(p181) -- Line: 914
        -- upvalues: UserInputService (ref)
        if UserInputService.TouchEnabled and p181:IsA("Tool") then
            p181.ManualActivationOnly = false;
        end;
    end);

    for _, child in pairs(p170:GetChildren()) do
        OnCharacterChildAdded(child);
    end;
end;

function u155.Start(p182) -- Line: 926
    p182:Enable(true);
end;

function u155.Stop(p183) -- Line: 930
    p183:Enable(false);
end;

function u155.CleanupPath(p184) -- Line: 934
    -- upvalues: u121 (ref), u122 (ref), u123 (ref)
    if u121 then
        u121:Cancel();
        u121 = nil;
    end;

    if u122 then
        u122:Disconnect();
        u122 = nil;
    end;

    if u123 then
        u123:Disconnect();
        u123 = nil;
    end;
end;

function u155.Enable(u185, p186, p187, p188) -- Line: 938
    -- upvalues: LocalPlayer (copy), u121 (ref), u122 (ref), u123 (ref), UserInputService (copy)
    if p186 then
        if not u185.running then
            if LocalPlayer.Character then
                u185:OnCharacterAdded(LocalPlayer.Character);
            end;

            u185.onCharacterAddedConn = LocalPlayer.CharacterAdded:Connect(function(p189) -- Line: 944
                -- upvalues: u185 (copy)
                u185:OnCharacterAdded(p189);
            end);
            u185.running = true;
        end;

        u185.touchJumpController = p188;

        if u185.touchJumpController then
            u185.touchJumpController:Enable(u185.jumpEnabled);
        end;
    else
        if u185.running then
            u185:DisconnectEvents();

            if u121 then
                u121:Cancel();
                u121 = nil;
            end;

            if u122 then
                u122:Disconnect();
                u122 = nil;
            end;

            if u123 then
                u123:Disconnect();
                u123 = nil;
            end;

            if UserInputService.TouchEnabled then
                local Character = LocalPlayer.Character;

                if Character then
                    for _, child in pairs(Character:GetChildren()) do
                        if child:IsA("Tool") then
                            child.ManualActivationOnly = false;
                        end;
                    end;
                end;
            end;

            u185.running = false;
        end;

        if u185.touchJumpController and not u185.jumpEnabled then
            u185.touchJumpController:Enable(true);
        end;

        u185.touchJumpController = nil;
    end;

    if UserInputService.KeyboardEnabled and p186 ~= u185.enabled then
        u185.forwardValue = 0;
        u185.backwardValue = 0;
        u185.leftValue = 0;
        u185.rightValue = 0;
        u185.moveVector = Vector3.new(0, 0, 0);

        if p186 then
            u185:BindContextActions();
            u185:ConnectFocusEventListeners();
        else
            u185:UnbindContextActions();
            u185:DisconnectFocusEventListeners();
        end;
    end;

    u185.wasdEnabled = p186 and p187 and p187 or false;
    u185.enabled = p186;
end;

function u155.OnRenderStepped(p190, p191) -- Line: 999
    -- upvalues: u121 (ref)
    p190.isJumping = false;

    if u121 then
        u121:OnRenderStepped(p191);

        if u121 then
            p190.moveVector = u121.NextActionMoveDirection;
            p190.moveVectorIsCameraRelative = false;

            if u121.NextActionJump then
                p190.isJumping = true;
            end;
        else
            p190.moveVector = p190.keyboardMoveVector;
            p190.moveVectorIsCameraRelative = true;
        end;
    else
        p190.moveVector = p190.keyboardMoveVector;
        p190.moveVectorIsCameraRelative = true;
    end;

    if p190.jumpRequested then
        p190.isJumping = true;
    end;
end;

function u155.UpdateMovement(p192, p193) -- Line: 1034
    if p193 == Enum.UserInputState.Cancel then
        p192.keyboardMoveVector = Vector3.new(0, 0, 0);

        return;
    end;

    if p192.wasdEnabled then
        p192.keyboardMoveVector = Vector3.new(p192.leftValue + p192.rightValue, 0, p192.forwardValue + p192.backwardValue);
    end;
end;

function u155.UpdateJump(p194) -- Line: 1043
end;

function u155.SetShowPath(p195, p196) -- Line: 1048
    -- upvalues: u2 (ref)
    u2 = p196;
end;

function u155.GetShowPath(p197) -- Line: 1052
    -- upvalues: u2 (ref)
    return u2;
end;

function u155.SetWaypointTexture(p198, p199) -- Line: 1056
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetWaypointTexture(p199);
end;

function u155.GetWaypointTexture(p200) -- Line: 1060
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetWaypointTexture();
end;

function u155.SetWaypointRadius(p201, p202) -- Line: 1064
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetWaypointRadius(p202);
end;

function u155.GetWaypointRadius(p203) -- Line: 1068
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetWaypointRadius();
end;

function u155.SetEndWaypointTexture(p204, p205) -- Line: 1072
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetEndWaypointTexture(p205);
end;

function u155.GetEndWaypointTexture(p206) -- Line: 1076
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetEndWaypointTexture();
end;

function u155.SetWaypointsAlwaysOnTop(p207, p208) -- Line: 1080
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetWaypointsAlwaysOnTop(p208);
end;

function u155.GetWaypointsAlwaysOnTop(p209) -- Line: 1084
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetWaypointsAlwaysOnTop();
end;

function u155.SetFailureAnimationEnabled(p210, p211) -- Line: 1088
    -- upvalues: u3 (ref)
    u3 = p211;
end;

function u155.GetFailureAnimationEnabled(p212) -- Line: 1092
    -- upvalues: u3 (ref)
    return u3;
end;

function u155.SetIgnoredPartsTag(p213, p214) -- Line: 1096
    -- upvalues: UpdateIgnoreTag (copy)
    UpdateIgnoreTag(p214);
end;

function u155.GetIgnoredPartsTag(p215) -- Line: 1100
    -- upvalues: u27 (ref)
    return u27;
end;

function u155.SetUseDirectPath(p216, p217) -- Line: 1104
    -- upvalues: u4 (ref)
    u4 = p217;
end;

function u155.GetUseDirectPath(p218) -- Line: 1108
    -- upvalues: u4 (ref)
    return u4;
end;

function u155.SetAgentSizeIncreaseFactor(p219, p220) -- Line: 1112
    -- upvalues: u5 (ref)
    u5 = p220 / 100 + 1;
end;

function u155.GetAgentSizeIncreaseFactor(p221) -- Line: 1116
    -- upvalues: u5 (ref)
    return (u5 - 1) * 100;
end;

function u155.SetUnreachableWaypointTimeout(p222, p223) -- Line: 1120
    -- upvalues: u6 (ref)
    u6 = p223;
end;

function u155.GetUnreachableWaypointTimeout(p224) -- Line: 1124
    -- upvalues: u6 (ref)
    return u6;
end;

function u155.SetUserJumpEnabled(p225, p226) -- Line: 1128
    p225.jumpEnabled = p226;

    if p225.touchJumpController then
        p225.touchJumpController:Enable(p226);
    end;
end;

function u155.GetUserJumpEnabled(p227) -- Line: 1135
    return p227.jumpEnabled;
end;

function u155.MoveTo(p228, p229, p230, p231) -- Line: 1139
    -- upvalues: LocalPlayer (copy), Pather (copy), HandleMoveTo (copy)
    local Character = LocalPlayer.Character;

    if Character == nil then
        return false;
    end;

    local v232 = Pather(p229, Vector3.new(0, 1, 0), p231);

    if not (v232 and v232:IsValidPath()) then
        return false;
    end;

    HandleMoveTo(v232, p229, nil, Character, p230);

    return true;
end;

return u155;