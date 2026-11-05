  

 

local VRService = game:GetService("VRService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local PathfindingService = game:GetService("PathfindingService");
local ContextActionService = game:GetService("ContextActionService");
local StarterGui = game:GetService("StarterGui");
local u1 = nil;
local LocalPlayer = Players.LocalPlayer;

local function IsFinite(p2) -- Line: 29
    local v3;

    if p2 == p2 and p2 ~= (1 / 0) then
        v3 = p2 ~= (-1 / 0);
    else
        v3 = false;
    end;

    return v3;
end;

local function IsFiniteVector3(p4) -- Line: 33
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
coroutine.wrap(function() -- Line: 41
    -- upvalues: u1 (ref)
    local PathDisplay = script.Parent:WaitForChild("PathDisplay");

    if PathDisplay then
        u1 = require(PathDisplay);
    end;
end)();
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u6 = setmetatable({}, BaseCharacterController);
u6.__index = u6;

function u6.new(p7) -- Line: 54
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

function u6.SetLaserPointerMode(p10, u11) -- Line: 79
    -- upvalues: StarterGui (copy)
    pcall(function() -- Line: 80
        -- upvalues: StarterGui (ref), u11 (copy)
        StarterGui:SetCore("VRLaserPointerMode", u11);
    end);
end;

function u6.GetLocalHumanoid(p12) -- Line: 85
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

function u6.HasBothHandControllers(p13) -- Line: 99
    -- upvalues: VRService (copy)
    local v14 = VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand);

    return v14;
end;

function u6.HasAnyHandControllers(p15) -- Line: 103
    -- upvalues: VRService (copy)
    return VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand);
end;

function u6.IsMobileVR(p16) -- Line: 107
    -- upvalues: UserInputService (copy)
    return UserInputService.TouchEnabled;
end;

function u6.HasGamepad(p17) -- Line: 111
    -- upvalues: UserInputService (copy)
    return UserInputService.GamepadEnabled;
end;

function u6.ShouldUseNavigationLaser(p18) -- Line: 115
    if p18:IsMobileVR() then
        return true;
    end;

    if p18:HasBothHandControllers() then
        return false;
    end;

    return p18:HasAnyHandControllers() and true or not p18:HasGamepad();
end;

function u6.StartFollowingPath(p19, p20) -- Line: 137
    -- upvalues: BindableEvent (copy)
    currentPath = p20;
    currentPoints = currentPath:GetPointCoordinates();
    currentPointIdx = 1;
    moving = true;
    timeReachedLastPoint = tick();
    local v21 = p19:GetLocalHumanoid();

    if v21 and (v21.Torso and #currentPoints >= 1) then
        expectedTimeToNextPoint = (currentPoints[1] - v21.Torso.Position).magnitude / v21.WalkSpeed;
    end;

    BindableEvent:Fire("targetPoint", p19.currentDestination);
end;

function u6.GoToPoint(p22, p23) -- Line: 154
    -- upvalues: BindableEvent (copy)
    currentPath = true;
    currentPoints = { p23 };
    currentPointIdx = 1;
    moving = true;
    local v24 = p22:GetLocalHumanoid();
    local v25 = (v24.Torso.Position - p23).magnitude / v24.WalkSpeed;
    timeReachedLastPoint = tick();
    expectedTimeToNextPoint = v25;
    BindableEvent:Fire("targetPoint", p23);
end;

function u6.StopFollowingPath(p26) -- Line: 170
    currentPath = nil;
    currentPoints = nil;
    currentPointIdx = 0;
    moving = false;
    p26.moveVector = Vector3.new(0, 0, 0);
end;

function u6.TryComputePath(p27, p28, p29) -- Line: 178
    -- upvalues: PathfindingService (copy)
    local v30 = nil;
    local v31 = 0;

    while not v30 and v31 < 5 do
        v30 = PathfindingService:ComputeSmoothPathAsync(p28, p29, 200);
        v31 = v31 + 1;

        if v30.Status == Enum.PathStatus.ClosestNoPath or v30.Status == Enum.PathStatus.ClosestOutOfRange then
            return nil;
        end;

        if v30 and v30.Status == Enum.PathStatus.FailStartNotEmpty then
            p28 = p28 + (p29 - p28).unit;
            v30 = nil;
        end;

        if v30 and v30.Status == Enum.PathStatus.FailFinishNotEmpty then
            p29 = p29 + Vector3.new(0, 1, 0);
            v30 = nil;
        end;
    end;

    return v30;
end;

function u6.OnNavigationRequest(p32, p33, p34) -- Line: 205
    -- upvalues: u1 (ref)
    local p = p33.p;
    local currentDestination = p32.currentDestination;
    local x = p.x;
    local v35;

    if x == x and x ~= (1 / 0) then
        v35 = x ~= (-1 / 0);
    else
        v35 = false;
    end;

    if v35 then
        local y = p.y;

        if y == y and y ~= (1 / 0) then
            v35 = y ~= (-1 / 0);
        else
            v35 = false;
        end;

        if v35 then
            local z = p.z;

            if z == z and z ~= (1 / 0) then
                v35 = z ~= (-1 / 0);
            else
                v35 = false;
            end;
        end;
    end;

    if not v35 then
        return;
    end;

    p32.currentDestination = p;
    local v36 = p32:GetLocalHumanoid();

    if not (v36 and v36.Torso) then
        return;
    end;

    local Position = v36.Torso.Position;

    if (p32.currentDestination - Position).magnitude < 12 then
        p32:GoToPoint(p32.currentDestination);

        return;
    end;

    if currentDestination and (p32.currentDestination - currentDestination).magnitude <= 4 then
        if moving then
            p32.currentPoints[#currentPoints] = p32.currentDestination;

            return;
        end;

        p32:GoToPoint(p32.currentDestination);
    else
        local v37 = p32:TryComputePath(Position, p32.currentDestination);

        if v37 then
            p32:StartFollowingPath(v37);

            if u1 then
                u1.setCurrentPoints(p32.currentPoints);
                u1.renderPath();
            end;
        else
            p32:StopFollowingPath();

            if u1 then
                u1.clearRenderedPath();
            end;
        end;
    end;
end;

function u6.OnJumpAction(p38, p39, p40, p41) -- Line: 251
    if p40 == Enum.UserInputState.Begin then
        p38.isJumping = true;
    end;

    return Enum.ContextActionResult.Sink;
end;

function u6.BindJumpAction(u42, p43) -- Line: 257
    -- upvalues: ContextActionService (copy)
    if p43 then
        if not u42.isJumpBound then
            u42.isJumpBound = true;
            ContextActionService:BindActionAtPriority("VRJumpAction", function() -- Line: 261
                -- upvalues: u42 (copy)
                return u42:OnJumpAction();
            end, false, u42.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA);
        end;
    elseif u42.isJumpBound then
        u42.isJumpBound = false;
        ContextActionService:UnbindAction("VRJumpAction");
    end;
end;

function u6.ControlCharacterGamepad(p44, p45, p46, p47) -- Line: 272
    -- upvalues: u1 (ref), BindableEvent (copy)
    if p47.KeyCode ~= Enum.KeyCode.Thumbstick1 then
        return;
    end;

    if p46 ~= Enum.UserInputState.Cancel then
        if p46 == Enum.UserInputState.End then
            p44.moveVector = Vector3.new(0, 0, 0);

            if p44:ShouldUseNavigationLaser() then
                p44:BindJumpAction(false);
                p44:SetLaserPointerMode("Navigation");
            end;

            if p44.moveLatch then
                p44.moveLatch = false;
                BindableEvent:Fire("offtrack");
            end;
        else
            p44:StopFollowingPath();

            if u1 then
                u1.clearRenderedPath();
            end;

            if p44:ShouldUseNavigationLaser() then
                p44:BindJumpAction(true);
                p44:SetLaserPointerMode("Hidden");
            end;

            if p47.Position.magnitude > 0.22 then
                p44.moveVector = Vector3.new(p47.Position.X, 0, -p47.Position.Y);

                if p44.moveVector.magnitude > 0 then
                    p44.moveVector = p44.moveVector.unit * math.min(1, p47.Position.magnitude);
                end;

                p44.moveLatch = true;
            end;
        end;

        return Enum.ContextActionResult.Sink;
    end;

    p44.moveVector = Vector3.new(0, 0, 0);
end;

function u6.OnHeartbeat(p48, p49) -- Line: 315
    -- upvalues: u1 (ref), BindableEvent (copy)
    local moveVector = p48.moveVector;
    local v50 = p48:GetLocalHumanoid();

    if not (v50 and v50.Torso) then
        return;
    end;

    if p48.moving and p48.currentPoints then
        local Position = v50.Torso.Position;
        local v51 = (currentPoints[1] - Position) * Vector3.new(1, 0, 1);
        local magnitude = v51.magnitude;
        local v52 = v51 / magnitude;

        if magnitude < 1 then
            local v53 = currentPoints[1];
            local v54 = 0;

            for i, v in pairs(currentPoints) do
                if i ~= 1 then
                    v54 = v54 + (v - v53).magnitude / v50.WalkSpeed;
                    v53 = v;
                end;
            end;

            table.remove(currentPoints, 1);
            currentPointIdx = currentPointIdx + 1;

            if #currentPoints == 0 then
                p48:StopFollowingPath();

                if u1 then
                    u1.clearRenderedPath();
                end;

                return;
            end;

            if u1 then
                u1.setCurrentPoints(currentPoints);
                u1.renderPath();
            end;

            expectedTimeToNextPoint = (currentPoints[1] - Position).magnitude / v50.WalkSpeed;
            timeReachedLastPoint = tick();
        else
            local v55 = { game.Players.LocalPlayer.Character, workspace.CurrentCamera };
            local v56 = Ray.new(Position - Vector3.new(0, 1, 0), v52 * 3);
            local v57, v58, _ = workspace:FindPartOnRayWithIgnoreList(v56, v55);

            if v57 then
                local v59 = Ray.new(v58 + v52 * 0.5 + Vector3.new(0, 100, 0), Vector3.new(-0, -100, -0));
                local _, v60, _ = workspace:FindPartOnRayWithIgnoreList(v59, v55);
                local v61 = v60.Y - Position.Y;

                if v61 < 6 and v61 > -2 then
                    v50.Jump = true;
                end;
            end;

            if tick() - timeReachedLastPoint > expectedTimeToNextPoint + 2 then
                p48:StopFollowingPath();

                if u1 then
                    u1.clearRenderedPath();
                end;

                BindableEvent:Fire("offtrack");
            end;

            moveVector = p48.moveVector:Lerp(v52, p49 * 10);
        end;
    end;

    local x = moveVector.x;
    local v62;

    if x == x and x ~= (1 / 0) then
        v62 = x ~= (-1 / 0);
    else
        v62 = false;
    end;

    if v62 then
        local y = moveVector.y;

        if y == y and y ~= (1 / 0) then
            v62 = y ~= (-1 / 0);
        else
            v62 = false;
        end;

        if v62 then
            local z = moveVector.z;

            if z == z and z ~= (1 / 0) then
                v62 = z ~= (-1 / 0);
            else
                v62 = false;
            end;
        end;
    end;

    if v62 then
        p48.moveVector = moveVector;
    end;
end;

function u6.OnUserCFrameEnabled(p63) -- Line: 399
    if p63:ShouldUseNavigationLaser() then
        p63:BindJumpAction(false);
        p63:SetLaserPointerMode("Navigation");

        return;
    end;

    p63:BindJumpAction(true);
    p63:SetLaserPointerMode("Hidden");
end;

function u6.Enable(u64, p65) -- Line: 409
    -- upvalues: VRService (copy), RunService (copy), ContextActionService (copy)
    u64.moveVector = Vector3.new(0, 0, 0);
    u64.isJumping = false;

    if p65 then
        u64.navigationRequestedConn = VRService.NavigationRequested:Connect(function(p66, p67) -- Line: 415
            -- upvalues: u64 (copy)
            u64:OnNavigationRequest(p66, p67);
        end);
        u64.heartbeatConn = RunService.Heartbeat:Connect(function(p68) -- Line: 416
            -- upvalues: u64 (copy)
            u64:OnHeartbeat(p68);
        end);
        ContextActionService:BindAction("MoveThumbstick", function(p69, p70, p71) -- Line: 418
            -- upvalues: u64 (copy)
            return u64:ControlCharacterGamepad(p69, p70, p71);
        end, false, u64.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1);
        ContextActionService:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
        u64.userCFrameEnabledConn = VRService.UserCFrameEnabled:Connect(function() -- Line: 422
            -- upvalues: u64 (copy)
            u64:OnUserCFrameEnabled();
        end);
        u64:OnUserCFrameEnabled();
        VRService:SetTouchpadMode(Enum.VRTouchpad.Left, Enum.VRTouchpadMode.VirtualThumbstick);
        VRService:SetTouchpadMode(Enum.VRTouchpad.Right, Enum.VRTouchpadMode.ABXY);
        u64.enabled = true;

        return;
    end;

    u64:StopFollowingPath();
    ContextActionService:UnbindAction("MoveThumbstick");
    ContextActionService:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
    u64:BindJumpAction(false);
    u64:SetLaserPointerMode("Disabled");

    if u64.navigationRequestedConn then
        u64.navigationRequestedConn:Disconnect();
        u64.navigationRequestedConn = nil;
    end;

    if u64.heartbeatConn then
        u64.heartbeatConn:Disconnect();
        u64.heartbeatConn = nil;
    end;

    if u64.userCFrameEnabledConn then
        u64.userCFrameEnabledConn:Disconnect();
        u64.userCFrameEnabledConn = nil;
    end;

    u64.enabled = false;
end;

return u6;