  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local UserInputService = game:GetService("UserInputService");
local v1 = Knit.GetController("PilotController");
local LocalPlayer = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = RaycastParams.new();
u8.FilterType = Enum.RaycastFilterType.Exclude;

local function CharacterAdded(p9) -- Line: 23
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref), u8 (copy)
    u2 = p9;
    u3 = u2:WaitForChild("Humanoid");
    u4 = u2:WaitForChild("HumanoidRootPart");
    u5 = u2:WaitForChild("Torso");
    u8.FilterDescendantsInstances = { u2 };
end;

local function PilotCharacterAdded(p10) -- Line: 31
    -- upvalues: u6 (ref), u7 (ref)
    u6 = p10;
    u7 = u6:WaitForChild("HumanoidRootPart");
end;

if LocalPlayer.Character then
    task.spawn(CharacterAdded, LocalPlayer.Character);
end;

LocalPlayer.CharacterAdded:Connect(CharacterAdded);
v1.PilotAdded:Connect(PilotCharacterAdded);
v1.PilotRemoved:Connect(function() -- Line: 41
    -- upvalues: u6 (ref), u7 (ref)
    u6 = nil;
    u7 = nil;
end);

local function GetMouseRaycast() -- Line: 46
    -- upvalues: UserInputService (copy), u8 (copy)
    local v11 = UserInputService:GetMouseLocation();
    local v12 = workspace.CurrentCamera:ViewportPointToRay(v11.X, v11.Y);
    local Origin = v12.Origin;
    local Direction = v12.Direction;
    local v13 = workspace:Raycast(Origin, Direction * 5000, u8);
    local v14;

    if v13 then
        v14 = v13.Position;
    else
        v14 = Origin + Direction * 5000;
    end;

    local v15 = {
        Hit = CFrame.lookAlong(v14, Direction)
    };
    local v16;

    if v13 then
        v16 = v13.Instance;
    else
        v16 = nil;
    end;

    v15.Target = v16;

    return v15;
end;

return {
    IsMobile = function() -- Line: 56, Name: IsMobile
        -- upvalues: UserInputService (copy)
        return UserInputService.TouchEnabled;
    end,

    Time = function() -- Line: 59, Name: Time
        return game.Workspace:GetServerTimeNow();
    end,

    CFrame = function() -- Line: 62, Name: CFrame
        -- upvalues: u4 (ref)
        if u4 then
            return u4.CFrame;
        end;

        return nil;
    end,

    Velocity = function() -- Line: 86, Name: Velocity
        -- upvalues: u4 (ref)
        if u4 then
            return u4.Velocity;
        end;

        return nil;
    end,

    MoveDirection = function() -- Line: 116, Name: MoveDirection
        -- upvalues: u3 (ref)
        if u3 then
            return u3.MoveDirection;
        end;

        return nil;
    end,

    MouseHit = function(p17) -- Line: 122, Name: MouseHit
        -- upvalues: GetMouseRaycast (copy)
        local MouseRaycast = p17.MouseRaycast;

        if MouseRaycast then
            return MouseRaycast.Hit;
        end;

        local v18 = GetMouseRaycast();
        p17.MouseRaycast = v18;

        return v18.Hit;
    end,

    MouseTarget = function(p19) -- Line: 131, Name: MouseTarget
        -- upvalues: GetMouseRaycast (copy)
        local MouseRaycast = p19.MouseRaycast;

        if MouseRaycast then
            return MouseRaycast.Target;
        end;

        local v20 = GetMouseRaycast();
        p19.MouseRaycast = v20;

        return v20.Target;
    end,

    CameraCFrame = function() -- Line: 140, Name: CameraCFrame
        -- upvalues: CurrentCamera (copy)
        if CurrentCamera then
            return CurrentCamera.CFrame;
        end;

        return nil;
    end,

    TorsoCFrame = function() -- Line: 146, Name: TorsoCFrame
        -- upvalues: u5 (ref)
        if u5 then
            return u5.CFrame;
        end;

        return nil;
    end,

    IsGrounded = function() -- Line: 152, Name: IsGrounded
        -- upvalues: u3 (ref)
        if u3 then
            return (u3:GetState() == Enum.HumanoidStateType.Running or u3:GetState() == Enum.HumanoidStateType.RunningNoPhysics) and true or u3:GetState() == Enum.HumanoidStateType.Landed;
        end;

        return nil;
    end,

    IsSprinting = function() -- Line: 158, Name: IsSprinting
        -- upvalues: u3 (ref), u2 (ref)
        local v21 = u3 and u3:GetState();

        return v21 and (u2 and (u2:GetAttribute("Running") == true and (u3.MoveDirection.Magnitude ~= 0 and (v21 == Enum.HumanoidStateType.Running or v21 == Enum.HumanoidStateType.RunningNoPhysics)))) and true or false;
    end,

    SprintEnabled = function() -- Line: 169, Name: SprintEnabled
        -- upvalues: u2 (ref)
        return u2 and u2:GetAttribute("Running") == true and true or false;
    end,

    FloorMaterial = function() -- Line: 176, Name: FloorMaterial
        -- upvalues: u3 (ref)
        return u3 and tostring(u3.FloorMaterial) or nil;
    end
};