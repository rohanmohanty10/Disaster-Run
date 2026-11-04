 

 

local VRService = game:GetService("VRService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local PathfindingService = game:GetService("PathfindingService");
local ContextActionService = game:GetService("ContextActionService");
local StarterGui = game:GetService("StarterGui");
local u1 = nil;
local LocalPlayer = Players.LocalPlayer;

local function IsFinite(p2: number) -- Line: 32
    local v3;

    if p2 == p2 and p2 ~= (1 / 0) then
        v3 = p2 ~= (-1 / 0);
    else
        v3 = false;
    end;

    return v3;
end;

local function IsFiniteVector3(p4) -- Line: 36
    local x = p4.x;
    local v5;

    if x == x and x ~= (1 / 0) then
        v5 = x ~= (-1 / 0);
    else
        v5 = false;
    end;

    if v5 then
        local y = p4.y;

        if y == y and y ~= (1 / 0) then
            v5 = y ~= (-1 / 0);
        else
            v5 = false;
        end;

        if v5 then
            local z = p4.z;

            if z == z and z ~= (1 / 0) then
                v5 = z ~= (-1 / 0);
            else
                v5 = false;
            end;
        end;
    end;

    return v5;
end;

local BindableEvent = Instance.new("BindableEvent");
BindableEvent.Name = "MovementUpdate";
BindableEvent.Parent = script;
coroutine.wrap(function() -- Line: 44
    -- upvalues: u1 (ref)
    local PathDisplay = script.Parent:WaitForChild("PathDisplay");

    if PathDisplay then
        u1 = require(PathDisplay);
    end;
end)();
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u6 = setmetatable({}, BaseCharacterController);
u6.__index = u6;

function u6.new(p7) -- Line: 57
    -- upvalues: BaseCharacterController (copy), u6 (copy)
    local v8 = BaseCharacterController.new();
    local v9 = setmetatable(v8, u6);
    v9.CONTROL_ACTION_PRIORITY = p7;
    v9.navigationRequestedConn = nil;
    v9.heartbeatConn = nil;
    v9.currentDestination = nil;
    v9.currentPath = nil;
    v9.currentPoints = nil;
    v9.currentPointIdx = 0;
    v9.expectedTimeToNextPoint = 0;
    v9.timeReachedLastPoint = tick();
    v9.moving = false;
    v9.isJumpBound = false;
    v9.moveLatch = false;
    v9.userCFrameEnabledConn = nil;

    return v9;
end;

function u6.SetLaserPointerMode(p10, u11) -- Line: 82
    -- upvalues: StarterGui (copy)
    pcall(function() -- Line: 83
        -- upvalues: StarterGui (ref), u11 (copy)
        StarterGui:SetCore("VRLaserPointerMode", u11);
    end);
end;

function u6.GetLocalHumanoid(p12) -- Line: 88
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        for _, child in pairs(Character:GetChildren()) do
            if child:IsA("Humanoid") then
                return child;
            end;
        end;

        return nil;
    end;
end;

function u6.HasBothHandControllers(p13) -- Line: 102
    -- upvalues: VRService (copy)
    local v14 = VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand);

    return v14;
end;

function u6.HasAnyHandControllers(p15) -- Line: 106
    -- upvalues: VRService (copy)
    return VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand);
end;

function u6.IsMobileVR(p16) -- Line: 110
    -- upvalues: UserInputService (copy)
    return UserInputService.TouchEnabled;
end;

function u6.HasGamepad(p17) -- Line: 114
    -- upvalues: UserInputService (copy)
    return UserInputService.GamepadEnabled;
end;

function u6.ShouldUseNavigationLaser(p18) -- Line: 118
    if p18:IsMobileVR() then
        return true;
    end;

    if p18:HasBothHandControllers() then
        return false;
    end;

    return p18:HasAnyHandControllers() and true or not p18:HasGamepad();
end;

function u6.StartFollowingPath(p19, p20) -- Line: 140
    -- upvalues: BindableEvent (copy)
    currentPath = p20;
    currentPoints = currentPath:GetPointCoordinates();
    currentPointIdx = 1;
    moving = true;
    timeReachedLastPoint = tick();
    local LocalHumanoid = p19:GetLocalHumanoid();

    if LocalHumanoid and (LocalHumanoid.Torso and #currentPoints >= 1) then
        expectedTimeToNextPoint = (currentPoints[1] - LocalHumanoid.Torso.Position).magnitude / LocalHumanoid.WalkSpeed;
    end;

    BindableEvent:Fire("targetPoint", p19.currentDestination);
end;

function u6.GoToPoint(p21, p22) -- Line: 157
    -- upvalues: BindableEvent (copy)
    currentPath = true;
    currentPoints = { p22 };
    currentPointIdx = 1;
    moving = true;
    local LocalHumanoid = p21:GetLocalHumanoid();
    local v23 = (LocalHumanoid.Torso.Position - p22).magnitude / LocalHumanoid.WalkSpeed;
    timeReachedLastPoint = tick();
    expectedTimeToNextPoint = v23;
    BindableEvent:Fire("targetPoint", p22);
end;

function u6.StopFollowingPath(p24) -- Line: 173
    currentPath = nil;
    currentPoints = nil;
    currentPointIdx = 0;
    moving = false;
    p24.moveVector = Vector3.new(0, 0, 0);
end;

function u6.TryComputePath(p25: table, p26: vector, p27: vector) -- Line: 181
    -- upvalues: PathfindingService (copy)
    local v28 = nil;
    local v29 = 0;

    while not v28 and v29 < 5 do
        v28 = PathfindingService:ComputeSmoothPathAsync(p26, p27, 200);
        v29 = v29 + 1;

        if v28.Status.Value == 2 or v28.Status.Value == 3 then
            return nil;
        end;

        if v28 and v28.Status.Value == 4 then
            p26 = p26 + (p27 - p26).Unit;
            v28 = nil;
        end;

        if v28 and v28.Status.Value == 5 then
            p27 = p27 + Vector3.new(0, 1, 0);
            v28 = nil;
        end;
    end;

    return v28;
end;

function u6.OnNavigationRequest(p30: table, p31, p32) -- Line: 213
    -- upvalues: u1 (ref)
    local Position = p31.Position;
    local currentDestination = p30.currentDestination;
    local x = Position.x;
    local v33;

    if x == x and x ~= (1 / 0) then
        v33 = x ~= (-1 / 0);
    else
        v33 = false;
    end;

    if v33 then
        local y = Position.y;

        if y == y and y ~= (1 / 0) then
            v33 = y ~= (-1 / 0);
        else
            v33 = false;
        end;

        if v33 then
            local z = Position.z;

            if z == z and z ~= (1 / 0) then
                v33 = z ~= (-1 / 0);
            else
                v33 = false;
            end;
        end;
    end;

    if not v33 then
        return;
    end;

    p30.currentDestination = Position;
    local LocalHumanoid = p30:GetLocalHumanoid();

    if not (LocalHumanoid and LocalHumanoid.Torso) then
        return;
    end;

    local Position2 = LocalHumanoid.Torso.Position;

    if (p30.currentDestination - Position2).magnitude < 12 then
        p30:GoToPoint(p30.currentDestination);

        return;
    end;

    if currentDestination and (p30.currentDestination - currentDestination).magnitude <= 4 then
        if moving then
            p30.currentPoints[#currentPoints] = p30.currentDestination;

            return;
        end;

        p30:GoToPoint(p30.currentDestination);
    else
        local v34 = p30:TryComputePath(Position2, p30.currentDestination);

        if v34 then
            p30:StartFollowingPath(v34);

            if u1 then
                u1.setCurrentPoints(p30.currentPoints);
                u1.renderPath();
            end;
        else
            p30:StopFollowingPath();

            if u1 then
                u1.clearRenderedPath();
            end;
        end;
    end;
end;

function u6.OnJumpAction(p35, p36, p37, p38) -- Line: 259
    if p37 == Enum.UserInputState.Begin then
        p35.isJumping = true;
    end;

    return Enum.ContextActionResult.Sink;
end;

function u6.BindJumpAction(u39, p40) -- Line: 265
    -- upvalues: ContextActionService (copy)
    if p40 then
        if not u39.isJumpBound then
            u39.isJumpBound = true;
            ContextActionService:BindActionAtPriority("VRJumpAction", function() -- Line: 269
                -- upvalues: u39 (copy)
                return u39:OnJumpAction();
            end, false, u39.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA);
        end;
    elseif u39.isJumpBound then
        u39.isJumpBound = false;
        ContextActionService:UnbindAction("VRJumpAction");
    end;
end;

function u6.ControlCharacterGamepad(p41, p42, p43, p44) -- Line: 280
    -- upvalues: u1 (ref), BindableEvent (copy)
    if p44.KeyCode ~= Enum.KeyCode.Thumbstick1 then
        return;
    end;

    if p43 ~= Enum.UserInputState.Cancel then
        if p43 == Enum.UserInputState.End then
            p41.moveVector = Vector3.new(0, 0, 0);

            if p41:ShouldUseNavigationLaser() then
                p41:BindJumpAction(false);
                p41:SetLaserPointerMode("Navigation");
            end;

            if p41.moveLatch then
                p41.moveLatch = false;
                BindableEvent:Fire("offtrack");
            end;
        else
            p41:StopFollowingPath();

            if u1 then
                u1.clearRenderedPath();
            end;

            if p41:ShouldUseNavigationLaser() then
                p41:BindJumpAction(true);
                p41:SetLaserPointerMode("Hidden");
            end;

            if p44.Position.magnitude > 0.22 then
                p41.moveVector = Vector3.new(p44.Position.X, 0, -p44.Position.Y);

                if p41.moveVector.magnitude > 0 then
                    p41.moveVector = p41.moveVector.unit * math.min(1, p44.Position.magnitude);
                end;

                p41.moveLatch = true;
            end;
        end;

        return Enum.ContextActionResult.Sink;
    end;

    p41.moveVector = Vector3.new(0, 0, 0);
end;

function u6.OnHeartbeat(p45, p46) -- Line: 323
    -- upvalues: u1 (ref), BindableEvent (copy)
    local moveVector = p45.moveVector;
    local LocalHumanoid = p45:GetLocalHumanoid();

    if not (LocalHumanoid and LocalHumanoid.Torso) then
        return;
    end;

    if p45.moving and p45.currentPoints then
        local Position = LocalHumanoid.Torso.Position;
        local v47 = (currentPoints[1] - Position) * Vector3.new(1, 0, 1);
        local magnitude = v47.magnitude;
        local v48 = v47 / magnitude;

        if magnitude < 1 then
            local v49 = currentPoints[1];
            local v50 = 0;

            for i, v in pairs(currentPoints) do
                if i ~= 1 then
                    v50 = v50 + (v - v49).magnitude / LocalHumanoid.WalkSpeed;
                    v49 = v;
                end;
            end;

            table.remove(currentPoints, 1);
            currentPointIdx = currentPointIdx + 1;

            if #currentPoints == 0 then
                p45:StopFollowingPath();

                if u1 then
                    u1.clearRenderedPath();
                end;

                return;
            end;

            if u1 then
                u1.setCurrentPoints(currentPoints);
                u1.renderPath();
            end;

            expectedTimeToNextPoint = (currentPoints[1] - Position).magnitude / LocalHumanoid.WalkSpeed;
            timeReachedLastPoint = tick();
        else
            local v51 = { game.Players.LocalPlayer.Character, workspace.CurrentCamera };
            local Ray_new_ret = Ray.new(Position - Vector3.new(0, 1, 0), v48 * 3);
            local v52, v53, _ = workspace:FindPartOnRayWithIgnoreList(Ray_new_ret, v51);

            if v52 then
                local Ray_new_ret2 = Ray.new(v53 + v48 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0));
                local _, v54, _ = workspace:FindPartOnRayWithIgnoreList(Ray_new_ret2, v51);
                local v55 = v54.Y - Position.Y;

                if v55 < 6 and v55 > -2 then
                    LocalHumanoid.Jump = true;
                end;
            end;

            if tick() - timeReachedLastPoint > expectedTimeToNextPoint + 2 then
                p45:StopFollowingPath();

                if u1 then
                    u1.clearRenderedPath();
                end;

                BindableEvent:Fire("offtrack");
            end;

            moveVector = p45.moveVector:Lerp(v48, p46 * 10);
        end;
    end;

    local x = moveVector.x;
    local v56;

    if x == x and x ~= (1 / 0) then
        v56 = x ~= (-1 / 0);
    else
        v56 = false;
    end;

    if v56 then
        local y = moveVector.y;

        if y == y and y ~= (1 / 0) then
            v56 = y ~= (-1 / 0);
        else
            v56 = false;
        end;

        if v56 then
            local z = moveVector.z;

            if z == z and z ~= (1 / 0) then
                v56 = z ~= (-1 / 0);
            else
                v56 = false;
            end;
        end;
    end;

    if v56 then
        p45.moveVector = moveVector;
    end;
end;

function u6.OnUserCFrameEnabled(p57) -- Line: 407
    if p57:ShouldUseNavigationLaser() then
        p57:BindJumpAction(false);
        p57:SetLaserPointerMode("Navigation");

        return;
    end;

    p57:BindJumpAction(true);
    p57:SetLaserPointerMode("Hidden");
end;

function u6.Enable(u58, p59) -- Line: 417
    -- upvalues: VRService (copy), RunService (copy), ContextActionService (copy)
    u58.moveVector = Vector3.new(0, 0, 0);
    u58.isJumping = false;

    if p59 then
        u58.navigationRequestedConn = VRService.NavigationRequested:Connect(function(p60, p61) -- Line: 423
            -- upvalues: u58 (copy)
            u58:OnNavigationRequest(p60, p61);
        end);
        u58.heartbeatConn = RunService.Heartbeat:Connect(function(p62) -- Line: 424
            -- upvalues: u58 (copy)
            u58:OnHeartbeat(p62);
        end);
        ContextActionService:BindAction("MoveThumbstick", function(p63, p64, p65) -- Line: 426
            -- upvalues: u58 (copy)
            return u58:ControlCharacterGamepad(p63, p64, p65);
        end, false, u58.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1);
        ContextActionService:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
        u58.userCFrameEnabledConn = VRService.UserCFrameEnabled:Connect(function() -- Line: 430
            -- upvalues: u58 (copy)
            u58:OnUserCFrameEnabled();
        end);
        u58:OnUserCFrameEnabled();
        VRService:SetTouchpadMode(Enum.VRTouchpad.Left, Enum.VRTouchpadMode.VirtualThumbstick);
        VRService:SetTouchpadMode(Enum.VRTouchpad.Right, Enum.VRTouchpadMode.ABXY);
        u58.enabled = true;

        return;
    end;

    u58:StopFollowingPath();
    ContextActionService:UnbindAction("MoveThumbstick");
    ContextActionService:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
    u58:BindJumpAction(false);
    u58:SetLaserPointerMode("Disabled");

    if u58.navigationRequestedConn then
        u58.navigationRequestedConn:Disconnect();
        u58.navigationRequestedConn = nil;
    end;

    if u58.heartbeatConn then
        u58.heartbeatConn:Disconnect();
        u58.heartbeatConn = nil;
    end;

    if u58.userCFrameEnabledConn then
        u58.userCFrameEnabledConn:Disconnect();
        u58.userCFrameEnabledConn = nil;
    end;

    u58.enabled = false;
end;

return u6;