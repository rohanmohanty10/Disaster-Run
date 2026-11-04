  

local success, result = pcall(function() -- Line: 10
    return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding");
end);
local u1 = success and result;
local success2, result2 = pcall(function() -- Line: 14
    return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2");
end);
local u2 = success2 and result2;
local UserInputService = game:GetService("UserInputService");
local PathfindingService = game:GetService("PathfindingService");
local Players = game:GetService("Players");
game:GetService("Debris");
local StarterGui = game:GetService("StarterGui");
local Workspace = game:GetService("Workspace");
local CollectionService = game:GetService("CollectionService");
local GuiService = game:GetService("GuiService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local UserFlag = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserUpdateInputConnections");
local u3 = true;
local u4 = true;
local u5 = false;
local u6 = 1;
local u7 = 8;
local u8 = {
    [Enum.KeyCode.W] = true,
    [Enum.KeyCode.A] = true,
    [Enum.KeyCode.S] = true,
    [Enum.KeyCode.D] = true,
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.Down] = true
};
local LocalPlayer = Players.LocalPlayer;
local ClickToMoveDisplay = require(script.Parent:WaitForChild("ClickToMoveDisplay"));
local u9 = {};

local function FindCharacterAncestor(p10) -- Line: 61
    -- upvalues: FindCharacterAncestor (copy)
    if p10 then
        local v11 = p10:FindFirstChildOfClass("Humanoid");

        if v11 then
            return p10, v11;
        end;

        return FindCharacterAncestor(p10.Parent);
    end;
end;

u9.FindCharacterAncestor = FindCharacterAncestor;

local function Raycast(p12: any, p13: boolean, p14: table) -- Line: 73
    -- upvalues: Workspace (copy), FindCharacterAncestor (copy), Raycast (copy)
    local v15 = p14 or {};
    local v16, v17, v18, v19 = Workspace:FindPartOnRayWithIgnoreList(p12, v15);

    if not v16 then
        return nil, nil;
    end;

    if p13 and v16.CanCollide == false then
        local v20;

        if v16 then
            v20 = v16:FindFirstChildOfClass("Humanoid");

            if not v20 then
                local v21;
                v21, v20 = FindCharacterAncestor(v16.Parent);
            end;
        else
            v20 = nil;
        end;

        if v20 == nil then
            table.insert(v15, v16);

            return Raycast(p12, p13, v15);
        end;
    end;

    return v16, v17, v18, v19;
end;

u9.Raycast = Raycast;
local u22 = {};

local function findPlayerHumanoid(p23: userdata) -- Line: 94
    -- upvalues: u22 (copy)
    local v24;

    if p23 then
        v24 = p23.Character;
    else
        v24 = p23;
    end;

    if v24 then
        local v25 = u22[p23];

        if v25 and v25.Parent == v24 then
            return v25;
        end;

        u22[p23] = nil;
        local v26 = v24:FindFirstChildOfClass("Humanoid");

        if v26 then
            u22[p23] = v26;
        end;

        return v26;
    end;
end;

local u27 = nil;
local u28 = nil;
local u29 = nil;
local u30 = nil;

local function GetCharacter() -- Line: 118
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer and LocalPlayer.Character;
end;

local function UpdateIgnoreTag(p31) -- Line: 122
    -- upvalues: u28 (ref), u29 (ref), u30 (ref), u27 (ref), LocalPlayer (copy), CollectionService (copy)
    if p31 == u28 then
        return;
    end;

    if u29 then
        u29:Disconnect();
        u29 = nil;
    end;

    if u30 then
        u30:Disconnect();
        u30 = nil;
    end;

    u28 = p31;
    local v32 = {};
    v32[1] = LocalPlayer and LocalPlayer.Character;
    u27 = v32;

    if u28 ~= nil then
        local Tagged = CollectionService:GetTagged(u28);

        for _, v in ipairs(Tagged) do
            table.insert(u27, v);
        end;

        u29 = CollectionService:GetInstanceAddedSignal(u28):Connect(function(p33) -- Line: 142
            -- upvalues: u27 (ref)
            table.insert(u27, p33);
        end);
        u30 = CollectionService:GetInstanceRemovedSignal(u28):Connect(function(p34) -- Line: 146
            -- upvalues: u27 (ref)
            for i = 1, #u27 do
                if u27[i] == p34 then
                    u27[i] = u27[#u27];
                    table.remove(u27);

                    return;
                end;

                local _ = i;
            end;
        end);
    end;
end;

local function getIgnoreList() -- Line: 158
    -- upvalues: u27 (ref), LocalPlayer (copy)
    if u27 then
        return u27;
    end;

    u27 = {};
    assert(u27, "");
    table.insert(u27, LocalPlayer and LocalPlayer.Character);

    return u27;
end;

local function minV(p35: vector, p36: vector) -- Line: 168
    local math_min_ret = math.min(p35.X, p36.X);
    local math_min_ret2 = math.min(p35.Y, p36.Y);
    local math_min_ret3 = math.min(p35.Z, p36.Z);

    return Vector3.new(math_min_ret, math_min_ret2, math_min_ret3);
end;

local function maxV(p37, p38) -- Line: 171
    local math_max_ret = math.max(p37.X, p38.X);
    local math_max_ret2 = math.max(p37.Y, p38.Y);
    local math_max_ret3 = math.max(p37.Z, p38.Z);

    return Vector3.new(math_max_ret, math_max_ret2, math_max_ret3);
end;

local function getCollidableExtentsSize(p39: userdata?) -- Line: 174
    if p39 ~= nil and p39.PrimaryPart ~= nil then
        assert(p39, "");
        assert(p39.PrimaryPart, "");
        local v40 = p39.PrimaryPart.CFrame:Inverse();
        local v41 = Vector3.new(inf, inf, inf);
        local v42 = Vector3.new(-inf, -inf, -inf);

        for _, descendant in pairs(p39:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.CanCollide then
                local v43 = v40 * descendant.CFrame;
                local Vector3_new_ret = Vector3.new(descendant.Size.X / 2, descendant.Size.Y / 2, descendant.Size.Z / 2);
                local v44 = {
                    Vector3.new(Vector3_new_ret.X, Vector3_new_ret.Y, Vector3_new_ret.Z),
                    Vector3.new(Vector3_new_ret.X, Vector3_new_ret.Y, -Vector3_new_ret.Z),
                    Vector3.new(Vector3_new_ret.X, -Vector3_new_ret.Y, Vector3_new_ret.Z),
                    Vector3.new(Vector3_new_ret.X, -Vector3_new_ret.Y, -Vector3_new_ret.Z),
                    Vector3.new(-Vector3_new_ret.X, Vector3_new_ret.Y, Vector3_new_ret.Z),
                    Vector3.new(-Vector3_new_ret.X, Vector3_new_ret.Y, -Vector3_new_ret.Z),
                    Vector3.new(-Vector3_new_ret.X, -Vector3_new_ret.Y, Vector3_new_ret.Z),
                    (Vector3.new(-Vector3_new_ret.X, -Vector3_new_ret.Y, -Vector3_new_ret.Z))
                };

                for _, v in ipairs(v44) do
                    local v45 = v43 * v;
                    local math_min_ret = math.min(v41.X, v45.X);
                    local math_min_ret2 = math.min(v41.Y, v45.Y);
                    local math_min_ret3 = math.min(v41.Z, v45.Z);
                    v41 = Vector3.new(math_min_ret, math_min_ret2, math_min_ret3);
                    local math_max_ret = math.max(v42.X, v45.X);
                    local math_max_ret2 = math.max(v42.Y, v45.Y);
                    local math_max_ret3 = math.max(v42.Z, v45.Z);
                    v42 = Vector3.new(math_max_ret, math_max_ret2, math_max_ret3);
                end;
            end;
        end;

        local v46 = v42 - v41;

        if v46.X < 0 or (v46.Y < 0 or v46.Z < 0) then
            return nil;
        end;

        return v46;
    end;
end;

local function Pather(p47: any, p48: any, p49: boolean?) -- Line: 209
    -- upvalues: u5 (ref), LocalPlayer (copy), u22 (copy), u6 (ref), u1 (copy), getCollidableExtentsSize (copy), u2 (copy), PathfindingService (copy), u3 (ref), ClickToMoveDisplay (copy), u7 (ref), Workspace (copy), u27 (ref)
    local u50 = {};
    local v51;

    if p49 == nil then
        v51 = u5;
        p49 = true;
    else
        v51 = p49;
    end;

    u50.Cancelled = false;
    u50.Started = false;
    u50.Finished = Instance.new("BindableEvent");
    u50.PathFailed = Instance.new("BindableEvent");
    u50.PathComputing = false;
    u50.PathComputed = false;
    u50.OriginalTargetPoint = p47;
    u50.TargetPoint = p47;
    u50.TargetSurfaceNormal = p48;
    u50.DiedConn = nil;
    u50.SeatedConn = nil;
    u50.BlockedConn = nil;
    u50.TeleportedConn = nil;
    u50.CurrentPoint = 0;
    u50.HumanoidOffsetFromPath = Vector3.new(0, 0, 0);
    u50.CurrentWaypointPosition = nil;
    u50.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
    u50.CurrentWaypointPlaneDistance = 0;
    u50.CurrentWaypointNeedsJump = false;
    u50.CurrentHumanoidPosition = Vector3.new(0, 0, 0);
    u50.CurrentHumanoidVelocity = 0;
    u50.NextActionMoveDirection = Vector3.new(0, 0, 0);
    u50.NextActionJump = false;
    u50.Timeout = 0;
    local v52 = LocalPlayer;
    local v53;

    if v52 then
        v53 = v52.Character;
    else
        v53 = v52;
    end;

    local v54;

    if v53 then
        v54 = u22[v52];

        if not v54 or v54.Parent ~= v53 then
            u22[v52] = nil;
            v54 = v53:FindFirstChildOfClass("Humanoid");

            if v54 then
                u22[v52] = v54;
            end;
        end;
    else
        v54 = nil;
    end;

    u50.Humanoid = v54;
    u50.OriginPoint = nil;
    u50.AgentCanFollowPath = false;
    u50.DirectPath = false;
    u50.DirectPathRiseFirst = false;
    u50.stopTraverseFunc = nil;
    u50.setPointFunc = nil;
    u50.pointList = nil;
    local v55 = u50.Humanoid and u50.Humanoid.RootPart;

    if v55 then
        u50.OriginPoint = v55.CFrame.Position;
        local v56 = 2;
        local v57 = 5;
        local v58 = true;
        local SeatPart = u50.Humanoid.SeatPart;

        if SeatPart and SeatPart:IsA("VehicleSeat") then
            local v59 = SeatPart:FindFirstAncestorOfClass("Model");

            if v59 then
                local PrimaryPart = v59.PrimaryPart;
                v59.PrimaryPart = SeatPart;

                if p49 then
                    local ExtentsSize = v59:GetExtentsSize();
                    v56 = u6 * 0.5 * math.sqrt(ExtentsSize.X * ExtentsSize.X + ExtentsSize.Z * ExtentsSize.Z);
                    v57 = u6 * ExtentsSize.Y;
                    u50.AgentCanFollowPath = true;
                    u50.DirectPath = p49;
                    v58 = false;
                end;

                v59.PrimaryPart = PrimaryPart;
            end;
        else
            local v60 = nil;

            if u1 then
                local v61 = LocalPlayer and LocalPlayer.Character;

                if v61 ~= nil then
                    v60 = getCollidableExtentsSize(v61);
                end;
            end;

            if v60 == nil then
                v60 = (LocalPlayer and LocalPlayer.Character):GetExtentsSize();
            end;

            assert(v60, "");
            v56 = u6 * 0.5 * math.sqrt(v60.X * v60.X + v60.Z * v60.Z);
            v57 = u6 * v60.Y;
            v58 = u50.Humanoid.JumpPower > 0;
            u50.AgentCanFollowPath = true;
            u50.DirectPath = v51;
            u50.DirectPathRiseFirst = u50.Humanoid.Sit;
        end;

        if u2 then
            u50.pathResult = PathfindingService:CreatePath({
                AgentCanClimb = true,
                AgentRadius = v56,
                AgentHeight = v57,
                AgentCanJump = v58
            });
        else
            u50.pathResult = PathfindingService:CreatePath({
                AgentRadius = v56,
                AgentHeight = v57,
                AgentCanJump = v58
            });
        end;
    end;

    function u50.Cleanup(p62) -- Line: 327
        -- upvalues: u50 (copy)
        if u50.stopTraverseFunc then
            u50.stopTraverseFunc();
            u50.stopTraverseFunc = nil;
        end;

        if u50.BlockedConn then
            u50.BlockedConn:Disconnect();
            u50.BlockedConn = nil;
        end;

        if u50.DiedConn then
            u50.DiedConn:Disconnect();
            u50.DiedConn = nil;
        end;

        if u50.SeatedConn then
            u50.SeatedConn:Disconnect();
            u50.SeatedConn = nil;
        end;

        if u50.TeleportedConn then
            u50.TeleportedConn:Disconnect();
            u50.TeleportedConn = nil;
        end;

        u50.Started = false;
    end;

    function u50.Cancel(p63) -- Line: 356
        -- upvalues: u50 (copy)
        u50.Cancelled = true;
        u50:Cleanup();
    end;

    function u50.IsActive(p64) -- Line: 361
        -- upvalues: u50 (copy)
        return u50.AgentCanFollowPath and u50.Started and not u50.Cancelled;
    end;

    function u50.OnPathInterrupted(p65) -- Line: 365
        -- upvalues: u50 (copy)
        u50.Cancelled = true;
        u50:OnPointReached(false);
    end;

    function u50.ComputePath(p66) -- Line: 371
        -- upvalues: u50 (copy)
        if u50.OriginPoint then
            if u50.PathComputed or u50.PathComputing then
                return;
            end;

            u50.PathComputing = true;

            if u50.AgentCanFollowPath then
                if u50.DirectPath then
                    u50.pointList = { PathWaypoint.new(u50.OriginPoint, Enum.PathWaypointAction.Walk), PathWaypoint.new(u50.TargetPoint, u50.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk) };
                    u50.PathComputed = true;
                else
                    u50.pathResult:ComputeAsync(u50.OriginPoint, u50.TargetPoint);
                    u50.pointList = u50.pathResult:GetWaypoints();
                    u50.BlockedConn = u50.pathResult.Blocked:Connect(function(p67) -- Line: 385
                        -- upvalues: u50 (ref)
                        u50:OnPathBlocked(p67);
                    end);
                    u50.PathComputed = u50.pathResult.Status == Enum.PathStatus.Success;
                end;
            end;

            u50.PathComputing = false;
        end;
    end;

    function u50.IsValidPath(p68) -- Line: 393
        -- upvalues: u50 (copy)
        u50:ComputePath();

        return u50.PathComputed and u50.AgentCanFollowPath;
    end;

    u50.Recomputing = false;

    function u50.OnPathBlocked(p69, p70) -- Line: 399
        -- upvalues: u50 (copy), u3 (ref), ClickToMoveDisplay (ref)
        if u50.CurrentPoint > p70 or u50.Recomputing then
            return;
        end;

        u50.Recomputing = true;

        if u50.stopTraverseFunc then
            u50.stopTraverseFunc();
            u50.stopTraverseFunc = nil;
        end;

        u50.OriginPoint = u50.Humanoid.RootPart.CFrame.p;
        u50.pathResult:ComputeAsync(u50.OriginPoint, u50.TargetPoint);
        u50.pointList = u50.pathResult:GetWaypoints();

        if #u50.pointList > 0 then
            u50.HumanoidOffsetFromPath = u50.pointList[1].Position - u50.OriginPoint;
        end;

        u50.PathComputed = u50.pathResult.Status == Enum.PathStatus.Success;

        if u3 then
            local v71, v72 = ClickToMoveDisplay.CreatePathDisplay(u50.pointList);
            u50.stopTraverseFunc = v71;
            u50.setPointFunc = v72;
        end;

        if u50.PathComputed then
            u50.CurrentPoint = 1;
            u50:OnPointReached(true);
        else
            u50.PathFailed:Fire();
            u50:Cleanup();
        end;

        u50.Recomputing = false;
    end;

    function u50.OnRenderStepped(p73: table, p74: number) -- Line: 435
        -- upvalues: u50 (copy), u7 (ref)
        if u50.Started and not u50.Cancelled then
            u50.Timeout = u50.Timeout + p74;

            if u7 < u50.Timeout then
                u50:OnPointReached(false);

                return;
            end;

            u50.CurrentHumanoidPosition = u50.Humanoid.RootPart.Position + u50.HumanoidOffsetFromPath;
            u50.CurrentHumanoidVelocity = u50.Humanoid.RootPart.Velocity;

            while u50.Started and u50:IsCurrentWaypointReached() do
                u50:OnPointReached(true);
            end;

            if u50.Started then
                u50.NextActionMoveDirection = u50.CurrentWaypointPosition - u50.CurrentHumanoidPosition;

                if u50.NextActionMoveDirection.Magnitude > 1e-6 then
                    u50.NextActionMoveDirection = u50.NextActionMoveDirection.Unit;
                else
                    u50.NextActionMoveDirection = Vector3.new(0, 0, 0);
                end;

                if u50.CurrentWaypointNeedsJump then
                    u50.NextActionJump = true;
                    u50.CurrentWaypointNeedsJump = false;

                    return;
                end;

                u50.NextActionJump = false;
            end;
        end;
    end;

    function u50.IsCurrentWaypointReached(p75) -- Line: 473
        -- upvalues: u50 (copy)
        local v76;

        if u50.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0) then
            v76 = true;
        else
            local v77 = u50.CurrentWaypointPlaneNormal:Dot(u50.CurrentHumanoidPosition) - u50.CurrentWaypointPlaneDistance;
            local v78 = 0.0625 * -u50.CurrentWaypointPlaneNormal:Dot(u50.CurrentHumanoidVelocity);
            v76 = v77 < math.max(1, v78);
        end;

        if v76 then
            u50.CurrentWaypointPosition = nil;
            u50.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
            u50.CurrentWaypointPlaneDistance = 0;
        end;

        return v76;
    end;

    function u50.OnPointReached(p79, p80) -- Line: 499
        -- upvalues: u50 (copy)
        if not p80 or u50.Cancelled then
            u50.PathFailed:Fire();
            u50:Cleanup();

            return;
        end;

        if u50.setPointFunc then
            u50.setPointFunc(u50.CurrentPoint);
        end;

        local v81 = u50.CurrentPoint + 1;

        if #u50.pointList < v81 then
            if u50.stopTraverseFunc then
                u50.stopTraverseFunc();
            end;

            u50.Finished:Fire();
            u50:Cleanup();

            return;
        end;

        local v82 = u50.pointList[u50.CurrentPoint];
        local v83 = u50.pointList[v81];
        local State = u50.Humanoid:GetState();

        if (State == Enum.HumanoidStateType.FallingDown or State == Enum.HumanoidStateType.Freefall) and true or State == Enum.HumanoidStateType.Jumping then
            local v84 = v83.Action == Enum.PathWaypointAction.Jump;

            if not v84 and u50.CurrentPoint > 1 then
                local v85 = v82.Position - u50.pointList[u50.CurrentPoint - 1].Position;
                local v86 = v83.Position - v82.Position;
                v84 = Vector2.new(v85.x, v85.z).Unit:Dot(Vector2.new(v86.x, v86.z).Unit) < 0.996;
            end;

            if v84 then
                u50.Humanoid.FreeFalling:Wait();
                wait(0.1);
            end;
        end;

        u50:MoveToNextWayPoint(v82, v83, v81);
    end;

    function u50.MoveToNextWayPoint(p87: table, p88: userdata, p89: userdata, p90: number) -- Line: 562
        -- upvalues: u50 (copy), u2 (ref)
        u50.CurrentWaypointPlaneNormal = p88.Position - p89.Position;

        if not u2 or p89.Label ~= "Climb" then
            u50.CurrentWaypointPlaneNormal = Vector3.new(u50.CurrentWaypointPlaneNormal.X, 0, u50.CurrentWaypointPlaneNormal.Z);
        end;

        if u50.CurrentWaypointPlaneNormal.Magnitude > 1e-6 then
            u50.CurrentWaypointPlaneNormal = u50.CurrentWaypointPlaneNormal.Unit;
            u50.CurrentWaypointPlaneDistance = u50.CurrentWaypointPlaneNormal:Dot(p89.Position);
        else
            u50.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0);
            u50.CurrentWaypointPlaneDistance = 0;
        end;

        u50.CurrentWaypointNeedsJump = p89.Action == Enum.PathWaypointAction.Jump;
        u50.CurrentWaypointPosition = p89.Position;
        u50.CurrentPoint = p90;
        u50.Timeout = 0;
    end;

    function u50.Start(p91, p92) -- Line: 594
        -- upvalues: u50 (copy), ClickToMoveDisplay (ref), u3 (ref)
        if not u50.AgentCanFollowPath then
            u50.PathFailed:Fire();

            return;
        end;

        if u50.Started then
            return;
        end;

        u50.Started = true;
        ClickToMoveDisplay.CancelFailureAnimation();

        if u3 and (p92 == nil or p92) then
            local v93, v94 = ClickToMoveDisplay.CreatePathDisplay(u50.pointList, u50.OriginalTargetPoint);
            u50.stopTraverseFunc = v93;
            u50.setPointFunc = v94;
        end;

        if #u50.pointList <= 0 then
            u50.PathFailed:Fire();

            if u50.stopTraverseFunc then
                u50.stopTraverseFunc();
            end;

            return;
        end;

        u50.HumanoidOffsetFromPath = Vector3.new(0, u50.pointList[1].Position.Y - u50.OriginPoint.Y, 0);
        u50.CurrentHumanoidPosition = u50.Humanoid.RootPart.Position + u50.HumanoidOffsetFromPath;
        u50.CurrentHumanoidVelocity = u50.Humanoid.RootPart.Velocity;
        u50.SeatedConn = u50.Humanoid.Seated:Connect(function(p95, p96) -- Line: 621
            -- upvalues: u50 (ref)
            u50:OnPathInterrupted();
        end);
        u50.DiedConn = u50.Humanoid.Died:Connect(function() -- Line: 622
            -- upvalues: u50 (ref)
            u50:OnPathInterrupted();
        end);
        u50.TeleportedConn = u50.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function() -- Line: 623
            -- upvalues: u50 (ref)
            u50:OnPathInterrupted();
        end);
        u50.CurrentPoint = 1;
        u50:OnPointReached(true);
    end;

    local Ray_new_ret = Ray.new(u50.TargetPoint + u50.TargetSurfaceNormal * 1.5, Vector3.new(0, -50, 0));
    local v97;

    if u27 then
        v97 = u27;
    else
        u27 = {};
        assert(u27, "");
        table.insert(u27, LocalPlayer and LocalPlayer.Character);
        v97 = u27;
    end;

    local v98, v99 = Workspace:FindPartOnRayWithIgnoreList(Ray_new_ret, v97);

    if v98 then
        u50.TargetPoint = v99;
    end;

    u50:ComputePath();

    return u50;
end;

local function CheckAlive() -- Line: 650
    -- upvalues: LocalPlayer (copy), u22 (copy)
    local v100 = LocalPlayer;
    local v101;

    if v100 then
        v101 = v100.Character;
    else
        v101 = v100;
    end;

    local v102;

    if v101 then
        v102 = u22[v100];

        if not v102 or v102.Parent ~= v101 then
            u22[v100] = nil;
            v102 = v101:FindFirstChildOfClass("Humanoid");

            if v102 then
                u22[v100] = v102;
            end;
        end;
    else
        v102 = nil;
    end;

    local v103;

    if v102 == nil then
        v103 = false;
    else
        v103 = v102.Health > 0;
    end;

    return v103;
end;

local function GetEquippedTool(p104: userdata?) -- Line: 655
    if p104 ~= nil then
        for _, child in pairs(p104:GetChildren()) do
            if child:IsA("Tool") then
                return child;
            end;
        end;
    end;
end;

local u105 = nil;
local u106 = nil;
local u107 = nil;

local function CleanupPath() -- Line: 670
    -- upvalues: u105 (ref), u106 (ref), u107 (ref)
    if u105 then
        u105:Cancel();
        u105 = nil;
    end;

    if u106 then
        u106:Disconnect();
        u106 = nil;
    end;

    if u107 then
        u107:Disconnect();
        u107 = nil;
    end;
end;

local function HandleMoveTo(p108, u109, u110, u111, u112) -- Line: 688
    -- upvalues: u105 (ref), u106 (ref), u107 (ref), GetEquippedTool (copy), u4 (ref), ClickToMoveDisplay (copy)
    if u105 then
        if u105 then
            u105:Cancel();
            u105 = nil;
        end;

        if u106 then
            u106:Disconnect();
            u106 = nil;
        end;

        if u107 then
            u107:Disconnect();
            u107 = nil;
        end;
    end;

    u105 = p108;
    p108:Start(u112);
    u106 = p108.Finished.Event:Connect(function() -- Line: 695
        -- upvalues: u105 (ref), u106 (ref), u107 (ref), u110 (copy), GetEquippedTool (ref), u111 (copy)
        if u105 then
            u105:Cancel();
            u105 = nil;
        end;

        if u106 then
            u106:Disconnect();
            u106 = nil;
        end;

        if u107 then
            u107:Disconnect();
            u107 = nil;
        end;

        local v113 = u110 and GetEquippedTool(u111);

        if v113 then
            v113:Activate();
        end;
    end);
    u107 = p108.PathFailed.Event:Connect(function() -- Line: 704
        -- upvalues: u105 (ref), u106 (ref), u107 (ref), u112 (copy), u4 (ref), ClickToMoveDisplay (ref), u109 (copy)
        if u105 then
            u105:Cancel();
            u105 = nil;
        end;

        if u106 then
            u106:Disconnect();
            u106 = nil;
        end;

        if u107 then
            u107:Disconnect();
            u107 = nil;
        end;

        if u112 == nil or u112 then
            local v114 = u4;

            if v114 then
                local v115 = u105 and u105:IsActive();
                v114 = not v115;
            end;

            if v114 then
                ClickToMoveDisplay.PlayFailureAnimation();
            end;

            ClickToMoveDisplay.DisplayFailureWaypoint(u109);
        end;
    end);
end;

local function ShowPathFailedFeedback(p116) -- Line: 716
    -- upvalues: u105 (ref), u4 (ref), ClickToMoveDisplay (copy)
    if u105 and u105:IsActive() then
        u105:Cancel();
    end;

    if u4 then
        ClickToMoveDisplay.PlayFailureAnimation();
    end;

    ClickToMoveDisplay.DisplayFailureWaypoint(p116);
end;

function OnTap(p117: table, p118: vector?, p119: boolean?)
    -- upvalues: Workspace (copy), LocalPlayer (copy), u22 (copy), u9 (copy), u27 (ref), StarterGui (copy), Players (copy), u105 (ref), u106 (ref), u107 (ref), Pather (copy), HandleMoveTo (copy), u4 (ref), ClickToMoveDisplay (copy), GetEquippedTool (copy)
    local CurrentCamera = Workspace.CurrentCamera;
    local Character = LocalPlayer.Character;
    local v120 = LocalPlayer;
    local v121;

    if v120 then
        v121 = v120.Character;
    else
        v121 = v120;
    end;

    local v122;

    if v121 then
        v122 = u22[v120];

        if not v122 or v122.Parent ~= v121 then
            u22[v120] = nil;
            v122 = v121:FindFirstChildOfClass("Humanoid");

            if v122 then
                u22[v120] = v122;
            end;
        end;
    else
        v122 = nil;
    end;

    local v123;

    if v122 == nil then
        v123 = false;
    else
        v123 = v122.Health > 0;
    end;

    if not v123 then
        return;
    end;

    if #p117 == 1 or p118 then
        if CurrentCamera then
            local v124 = CurrentCamera:ScreenPointToRay(p117[1].X, p117[1].Y);
            local Ray_new_ret = Ray.new(v124.Origin, v124.Direction * 1000);
            local v125 = LocalPlayer;
            local v126;

            if v125 then
                v126 = v125.Character;
            else
                v126 = v125;
            end;

            if v126 then
                local v127 = u22[v125];

                if not v127 or v127.Parent ~= v126 then
                    u22[v125] = nil;
                    local v128 = v126:FindFirstChildOfClass("Humanoid");

                    if v128 then
                        u22[v125] = v128;
                    end;
                end;
            end;

            local Raycast2 = u9.Raycast;
            local v129;

            if u27 then
                v129 = u27;
            else
                u27 = {};
                assert(u27, "");
                table.insert(u27, LocalPlayer and LocalPlayer.Character);
                v129 = u27;
            end;

            local v130, v131, v132 = Raycast2(Ray_new_ret, true, v129);
            local v133, v134 = u9.FindCharacterAncestor(v130);

            if p119 and (v134 and (StarterGui:GetCore("AvatarContextMenuEnabled") and Players:GetPlayerFromCharacter(v134.Parent))) then
                if u105 then
                    u105:Cancel();
                    u105 = nil;
                end;

                if u106 then
                    u106:Disconnect();
                    u106 = nil;
                end;

                if u107 then
                    u107:Disconnect();
                    u107 = nil;
                end;

                return;
            end;

            if p118 then
                v133 = nil;
            else
                p118 = v131;
            end;

            if p118 and Character then
                if u105 then
                    u105:Cancel();
                    u105 = nil;
                end;

                if u106 then
                    u106:Disconnect();
                    u106 = nil;
                end;

                if u107 then
                    u107:Disconnect();
                    u107 = nil;
                end;

                local v135 = Pather(p118, v132);

                if v135:IsValidPath() then
                    HandleMoveTo(v135, p118, v133, Character);

                    return;
                end;

                v135:Cleanup();

                if u105 and u105:IsActive() then
                    u105:Cancel();
                end;

                if u4 then
                    ClickToMoveDisplay.PlayFailureAnimation();
                end;

                ClickToMoveDisplay.DisplayFailureWaypoint(p118);
            end;
        end;
    else
        local v136 = #p117 >= 2 and (CurrentCamera and GetEquippedTool(Character));

        if v136 then
            v136:Activate();
        end;
    end;
end;

local function DisconnectEvent(p137) -- Line: 779
    if p137 then
        p137:Disconnect();
    end;
end;

local Keyboard = require(script.Parent:WaitForChild("Keyboard"));
local u138 = setmetatable({}, Keyboard);
u138.__index = u138;

function u138.new(p139) -- Line: 790
    -- upvalues: Keyboard (copy), u138 (copy)
    local v140 = Keyboard.new(p139);
    local v141 = setmetatable(v140, u138);
    v141.fingerTouches = {};
    v141.numUnsunkTouches = 0;
    v141.mouse1Down = tick();
    v141.mouse1DownPos = Vector2.new();
    v141.mouse2DownTime = tick();
    v141.mouse2DownPos = Vector2.new();
    v141.mouse2UpTime = tick();
    v141.keyboardMoveVector = Vector3.new(0, 0, 0);
    v141.tapConn = nil;
    v141.inputBeganConn = nil;
    v141.inputChangedConn = nil;
    v141.inputEndedConn = nil;
    v141.humanoidDiedConn = nil;
    v141.characterChildAddedConn = nil;
    v141.onCharacterAddedConn = nil;
    v141.characterChildRemovedConn = nil;
    v141.renderSteppedConn = nil;
    v141.menuOpenedConnection = nil;
    v141.running = false;
    v141.wasdEnabled = false;

    return v141;
end;

function u138.DisconnectEvents(p142) -- Line: 822
    local tapConn = p142.tapConn;

    if tapConn then
        tapConn:Disconnect();
    end;

    local inputBeganConn = p142.inputBeganConn;

    if inputBeganConn then
        inputBeganConn:Disconnect();
    end;

    local inputChangedConn = p142.inputChangedConn;

    if inputChangedConn then
        inputChangedConn:Disconnect();
    end;

    local inputEndedConn = p142.inputEndedConn;

    if inputEndedConn then
        inputEndedConn:Disconnect();
    end;

    local humanoidDiedConn = p142.humanoidDiedConn;

    if humanoidDiedConn then
        humanoidDiedConn:Disconnect();
    end;

    local characterChildAddedConn = p142.characterChildAddedConn;

    if characterChildAddedConn then
        characterChildAddedConn:Disconnect();
    end;

    local onCharacterAddedConn = p142.onCharacterAddedConn;

    if onCharacterAddedConn then
        onCharacterAddedConn:Disconnect();
    end;

    local renderSteppedConn = p142.renderSteppedConn;

    if renderSteppedConn then
        renderSteppedConn:Disconnect();
    end;

    local characterChildRemovedConn = p142.characterChildRemovedConn;

    if characterChildRemovedConn then
        characterChildRemovedConn:Disconnect();
    end;

    local menuOpenedConnection = p142.menuOpenedConnection;

    if menuOpenedConnection then
        menuOpenedConnection:Disconnect();
    end;
end;

function u138.OnTouchBegan(p143, p144, p145) -- Line: 835
    if p143.fingerTouches[p144] == nil and not p145 then
        p143.numUnsunkTouches = p143.numUnsunkTouches + 1;
    end;

    p143.fingerTouches[p144] = p145;
end;

function u138.OnTouchChanged(p146, p147, p148) -- Line: 842
    if p146.fingerTouches[p147] == nil then
        p146.fingerTouches[p147] = p148;

        if not p148 then
            p146.numUnsunkTouches = p146.numUnsunkTouches + 1;
        end;
    end;
end;

function u138.OnTouchEnded(p149, p150, p151) -- Line: 851
    if p149.fingerTouches[p150] ~= nil and p149.fingerTouches[p150] == false then
        p149.numUnsunkTouches = p149.numUnsunkTouches - 1;
    end;

    p149.fingerTouches[p150] = nil;
end;

function u138.OnCharacterAdded(u152, p153) -- Line: 859
    -- upvalues: UserInputService (copy), u8 (copy), u105 (ref), u106 (ref), u107 (ref), ClickToMoveDisplay (copy), GuiService (copy)
    u152:DisconnectEvents();
    u152.inputBeganConn = UserInputService.InputBegan:Connect(function(p154, p155) -- Line: 862
        -- upvalues: u152 (copy), u8 (ref), u105 (ref), u106 (ref), u107 (ref), ClickToMoveDisplay (ref)
        if p154.UserInputType == Enum.UserInputType.Touch then
            u152:OnTouchBegan(p154, p155);
        end;

        if u152.wasdEnabled and (p155 == false and (p154.UserInputType == Enum.UserInputType.Keyboard and u8[p154.KeyCode])) then
            if u105 then
                u105:Cancel();
                u105 = nil;
            end;

            if u106 then
                u106:Disconnect();
                u106 = nil;
            end;

            if u107 then
                u107:Disconnect();
                u107 = nil;
            end;

            ClickToMoveDisplay.CancelFailureAnimation();
        end;

        if p154.UserInputType == Enum.UserInputType.MouseButton1 then
            u152.mouse1DownTime = tick();
            u152.mouse1DownPos = p154.Position;
        end;

        if p154.UserInputType == Enum.UserInputType.MouseButton2 then
            u152.mouse2DownTime = tick();
            u152.mouse2DownPos = p154.Position;
        end;
    end);
    u152.inputChangedConn = UserInputService.InputChanged:Connect(function(p156, p157) -- Line: 883
        -- upvalues: u152 (copy)
        if p156.UserInputType == Enum.UserInputType.Touch then
            u152:OnTouchChanged(p156, p157);
        end;
    end);
    u152.inputEndedConn = UserInputService.InputEnded:Connect(function(p158, p159) -- Line: 889
        -- upvalues: u152 (copy), u105 (ref)
        if p158.UserInputType == Enum.UserInputType.Touch then
            u152:OnTouchEnded(p158, p159);
        end;

        if p158.UserInputType == Enum.UserInputType.MouseButton2 then
            u152.mouse2UpTime = tick();
            local Position = p158.Position;

            if u152.mouse2UpTime - u152.mouse2DownTime < 0.25 and ((Position - u152.mouse2DownPos).magnitude < 5 and (u105 or u152.keyboardMoveVector.Magnitude <= 0)) then
                OnTap({ Position });
            end;
        end;
    end);
    u152.tapConn = UserInputService.TouchTap:Connect(function(p160, p161) -- Line: 906
        if not p161 then
            OnTap(p160, nil, true);
        end;
    end);
    u152.menuOpenedConnection = GuiService.MenuOpened:Connect(function() -- Line: 912
        -- upvalues: u105 (ref), u106 (ref), u107 (ref)
        if u105 then
            u105:Cancel();
            u105 = nil;
        end;

        if u106 then
            u106:Disconnect();
            u106 = nil;
        end;

        if u107 then
            u107:Disconnect();
            u107 = nil;
        end;
    end);

    local function OnCharacterChildAdded(p162) -- Line: 916
        -- upvalues: UserInputService (ref), u152 (copy)
        if UserInputService.TouchEnabled and p162:IsA("Tool") then
            p162.ManualActivationOnly = true;
        end;

        if p162:IsA("Humanoid") then
            local humanoidDiedConn = u152.humanoidDiedConn;

            if humanoidDiedConn then
                humanoidDiedConn:Disconnect();
            end;

            u152.humanoidDiedConn = p162.Died:Connect(function() -- Line: 924
            end);
        end;
    end;

    u152.characterChildAddedConn = p153.ChildAdded:Connect(function(p163) -- Line: 932
        -- upvalues: OnCharacterChildAdded (copy)
        OnCharacterChildAdded(p163);
    end);
    u152.characterChildRemovedConn = p153.ChildRemoved:Connect(function(p164) -- Line: 935
        -- upvalues: UserInputService (ref)
        if UserInputService.TouchEnabled and p164:IsA("Tool") then
            p164.ManualActivationOnly = false;
        end;
    end);

    for _, child in pairs(p153:GetChildren()) do
        OnCharacterChildAdded(child);
    end;
end;

function u138.Start(p165) -- Line: 947
    p165:Enable(true);
end;

function u138.Stop(p166) -- Line: 951
    p166:Enable(false);
end;

function u138.CleanupPath(p167) -- Line: 955
    -- upvalues: u105 (ref), u106 (ref), u107 (ref)
    if u105 then
        u105:Cancel();
        u105 = nil;
    end;

    if u106 then
        u106:Disconnect();
        u106 = nil;
    end;

    if u107 then
        u107:Disconnect();
        u107 = nil;
    end;
end;

function u138.Enable(u168: table, p169: boolean, p170: boolean, p171: any) -- Line: 959
    -- upvalues: LocalPlayer (copy), u105 (ref), u106 (ref), u107 (ref), UserInputService (copy), UserFlag (copy), Keyboard (copy)
    if p169 then
        if not u168.running then
            if LocalPlayer.Character then
                u168:OnCharacterAdded(LocalPlayer.Character);
            end;

            u168.onCharacterAddedConn = LocalPlayer.CharacterAdded:Connect(function(p172) -- Line: 965
                -- upvalues: u168 (copy)
                u168:OnCharacterAdded(p172);
            end);
            u168.running = true;
        end;

        u168.touchJumpController = p171;

        if u168.touchJumpController then
            u168.touchJumpController:Enable(u168.jumpEnabled);
        end;
    else
        if u168.running then
            u168:DisconnectEvents();

            if u105 then
                u105:Cancel();
                u105 = nil;
            end;

            if u106 then
                u106:Disconnect();
                u106 = nil;
            end;

            if u107 then
                u107:Disconnect();
                u107 = nil;
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

            u168.running = false;
        end;

        if u168.touchJumpController and not u168.jumpEnabled then
            u168.touchJumpController:Enable(true);
        end;

        u168.touchJumpController = nil;
    end;

    if UserFlag then
        Keyboard.Enable(u168, p169);
    elseif UserInputService.KeyboardEnabled and p169 ~= u168.enabled then
        u168.forwardValue = 0;
        u168.backwardValue = 0;
        u168.leftValue = 0;
        u168.rightValue = 0;
        u168.moveVector = Vector3.new(0, 0, 0);

        if p169 then
            u168:BindContextActions();
            u168:ConnectFocusEventListeners();
        else
            u168:UnbindContextActions();
            u168:DisconnectFocusEventListeners();
        end;
    end;

    u168.wasdEnabled = p169 and p170 and p170 or false;
    u168.enabled = p169;
end;

function u138.OnRenderStepped(p173, p174) -- Line: 1024
    -- upvalues: u105 (ref)
    p173.isJumping = false;

    if u105 then
        u105:OnRenderStepped(p174);

        if u105 then
            p173.moveVector = u105.NextActionMoveDirection;
            p173.moveVectorIsCameraRelative = false;

            if u105.NextActionJump then
                p173.isJumping = true;
            end;
        else
            p173.moveVector = p173.keyboardMoveVector;
            p173.moveVectorIsCameraRelative = true;
        end;
    else
        p173.moveVector = p173.keyboardMoveVector;
        p173.moveVectorIsCameraRelative = true;
    end;

    if p173.jumpRequested then
        p173.isJumping = true;
    end;
end;

function u138.UpdateMovement(p175, p176) -- Line: 1059
    if p176 == Enum.UserInputState.Cancel then
        p175.keyboardMoveVector = Vector3.new(0, 0, 0);

        return;
    end;

    if p175.wasdEnabled then
        p175.keyboardMoveVector = Vector3.new(p175.leftValue + p175.rightValue, 0, p175.forwardValue + p175.backwardValue);
    end;
end;

function u138.UpdateJump(p177) -- Line: 1068
end;

function u138.SetShowPath(p178, p179) -- Line: 1073
    -- upvalues: u3 (ref)
    u3 = p179;
end;

function u138.GetShowPath(p180) -- Line: 1077
    -- upvalues: u3 (ref)
    return u3;
end;

function u138.SetWaypointTexture(p181, p182) -- Line: 1081
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetWaypointTexture(p182);
end;

function u138.GetWaypointTexture(p183) -- Line: 1085
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetWaypointTexture();
end;

function u138.SetWaypointRadius(p184, p185) -- Line: 1089
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetWaypointRadius(p185);
end;

function u138.GetWaypointRadius(p186) -- Line: 1093
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetWaypointRadius();
end;

function u138.SetEndWaypointTexture(p187, p188) -- Line: 1097
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetEndWaypointTexture(p188);
end;

function u138.GetEndWaypointTexture(p189) -- Line: 1101
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetEndWaypointTexture();
end;

function u138.SetWaypointsAlwaysOnTop(p190, p191) -- Line: 1105
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetWaypointsAlwaysOnTop(p191);
end;

function u138.GetWaypointsAlwaysOnTop(p192) -- Line: 1109
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetWaypointsAlwaysOnTop();
end;

function u138.SetFailureAnimationEnabled(p193, p194) -- Line: 1113
    -- upvalues: u4 (ref)
    u4 = p194;
end;

function u138.GetFailureAnimationEnabled(p195) -- Line: 1117
    -- upvalues: u4 (ref)
    return u4;
end;

function u138.SetIgnoredPartsTag(p196, p197) -- Line: 1121
    -- upvalues: UpdateIgnoreTag (copy)
    UpdateIgnoreTag(p197);
end;

function u138.GetIgnoredPartsTag(p198) -- Line: 1125
    -- upvalues: u28 (ref)
    return u28;
end;

function u138.SetUseDirectPath(p199, p200) -- Line: 1129
    -- upvalues: u5 (ref)
    u5 = p200;
end;

function u138.GetUseDirectPath(p201) -- Line: 1133
    -- upvalues: u5 (ref)
    return u5;
end;

function u138.SetAgentSizeIncreaseFactor(p202: table, p203: number) -- Line: 1137
    -- upvalues: u6 (ref)
    u6 = p203 / 100 + 1;
end;

function u138.GetAgentSizeIncreaseFactor(p204) -- Line: 1141
    -- upvalues: u6 (ref)
    return (u6 - 1) * 100;
end;

function u138.SetUnreachableWaypointTimeout(p205, p206) -- Line: 1145
    -- upvalues: u7 (ref)
    u7 = p206;
end;

function u138.GetUnreachableWaypointTimeout(p207) -- Line: 1149
    -- upvalues: u7 (ref)
    return u7;
end;

function u138.SetUserJumpEnabled(p208, p209) -- Line: 1153
    p208.jumpEnabled = p209;

    if p208.touchJumpController then
        p208.touchJumpController:Enable(p209);
    end;
end;

function u138.GetUserJumpEnabled(p210) -- Line: 1160
    return p210.jumpEnabled;
end;

function u138.MoveTo(p211, p212, p213, p214) -- Line: 1164
    -- upvalues: LocalPlayer (copy), Pather (copy), HandleMoveTo (copy)
    local Character = LocalPlayer.Character;

    if Character == nil then
        return false;
    end;

    local v215 = Pather(p212, Vector3.new(0, 1, 0), p214);

    if not (v215 and v215:IsValidPath()) then
        return false;
    end;

    HandleMoveTo(v215, p212, nil, Character, p213);

    return true;
end;

return u138;