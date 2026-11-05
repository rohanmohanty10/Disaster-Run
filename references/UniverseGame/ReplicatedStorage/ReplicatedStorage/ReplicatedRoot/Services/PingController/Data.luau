  

 

local UserInputService = game:GetService("UserInputService");
local LocalPlayer = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = RaycastParams.new();
u5.FilterType = Enum.RaycastFilterType.Exclude;

local function CharacterAdded(p6) -- Line: 15
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (copy)
    u1 = p6;
    u2 = u1:WaitForChild("Humanoid");
    u3 = u1:WaitForChild("HumanoidRootPart");
    u4 = u1:WaitForChild("Torso");
    u5.FilterDescendantsInstances = { u1 };
end;

if LocalPlayer.Character then
    task.spawn(CharacterAdded, LocalPlayer.Character);
end;

LocalPlayer.CharacterAdded:Connect(CharacterAdded);

local function GetMouseRaycast() -- Line: 27
    -- upvalues: UserInputService (copy), u5 (copy)
    local v7 = UserInputService:GetMouseLocation();
    local v8 = workspace.CurrentCamera:ViewportPointToRay(v7.X, v7.Y);
    local Origin = v8.Origin;
    local Direction = v8.Direction;
    local v9 = workspace:Raycast(Origin, Direction * 5000, u5);
    local v10;

    if v9 then
        v10 = v9.Position;
    else
        v10 = Origin + Direction * 5000;
    end;

    local v11 = {
        Hit = CFrame.lookAlong(v10, Direction)
    };
    local v12;

    if v9 then
        v12 = v9.Instance;
    else
        v12 = nil;
    end;

    v11.Target = v12;

    return v11;
end;

return {
    IsMobile = function() -- Line: 37, Name: IsMobile
        -- upvalues: UserInputService (copy)
        return UserInputService.TouchEnabled;
    end,

    Time = function() -- Line: 40, Name: Time
        return game.Workspace:GetServerTimeNow();
    end,

    CFrame = function() -- Line: 43, Name: CFrame
        -- upvalues: u3 (ref)
        if u3 then
            return u3.CFrame;
        end;

        return nil;
    end,

    Velocity = function() -- Line: 49, Name: Velocity
        -- upvalues: u3 (ref)
        if u3 then
            return u3.Velocity;
        end;

        return nil;
    end,

    MoveDirection = function() -- Line: 55, Name: MoveDirection
        -- upvalues: u2 (ref)
        if u2 then
            return u2.MoveDirection;
        end;

        return nil;
    end,

    MouseHit = function(p13) -- Line: 61, Name: MouseHit
        -- upvalues: GetMouseRaycast (copy)
        local MouseRaycast = p13.MouseRaycast;

        if MouseRaycast then
            return MouseRaycast.Hit;
        end;

        local v14 = GetMouseRaycast();
        p13.MouseRaycast = v14;

        return v14.Hit;
    end,

    MouseTarget = function(p15) -- Line: 70, Name: MouseTarget
        -- upvalues: GetMouseRaycast (copy)
        local MouseRaycast = p15.MouseRaycast;

        if MouseRaycast then
            return MouseRaycast.Target;
        end;

        local v16 = GetMouseRaycast();
        p15.MouseRaycast = v16;

        return v16.Target;
    end,

    CameraCFrame = function() -- Line: 79, Name: CameraCFrame
        -- upvalues: CurrentCamera (copy)
        if CurrentCamera then
            return CurrentCamera.CFrame;
        end;

        return nil;
    end,

    TorsoCFrame = function() -- Line: 85, Name: TorsoCFrame
        -- upvalues: u4 (ref)
        if u4 then
            return u4.CFrame;
        end;

        return nil;
    end,

    IsGrounded = function() -- Line: 91, Name: IsGrounded
        -- upvalues: u2 (ref)
        if u2 then
            return (u2:GetState() == Enum.HumanoidStateType.Running or u2:GetState() == Enum.HumanoidStateType.RunningNoPhysics) and true or u2:GetState() == Enum.HumanoidStateType.Landed;
        end;

        return nil;
    end,

    IsSprinting = function() -- Line: 97, Name: IsSprinting
        -- upvalues: u2 (ref), u1 (ref)
        local v17 = u2 and u2:GetState();

        return v17 and (u1 and (u1:GetAttribute("Running") == true and (u2.MoveDirection.Magnitude ~= 0 and (v17 == Enum.HumanoidStateType.Running or v17 == Enum.HumanoidStateType.RunningNoPhysics)))) and true or false;
    end,

    SprintEnabled = function() -- Line: 108, Name: SprintEnabled
        -- upvalues: u1 (ref)
        return u1 and u1:GetAttribute("Running") == true and true or false;
    end,

    FloorMaterial = function() -- Line: 115, Name: FloorMaterial
        -- upvalues: u2 (ref)
        return u2 and tostring(u2.FloorMaterial) or nil;
    end
};