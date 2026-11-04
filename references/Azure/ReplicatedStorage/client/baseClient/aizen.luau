 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local v1 = {
    __index = {}
};
local Mouse = Players.LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;

local function get_screen_target_pos() -- Line: 13
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy)
    if not (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) then
        return Vector2.new(Mouse.X, Mouse.Y);
    end;

    local ViewportSize = workspace_CurrentCamera.ViewportSize;

    return Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5);
end;

local function get_closest_aimed_character(p2: any, p3: number, p4: boolean?, p5: boolean?) -- Line: 21
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
    local v6 = nil;
    local v7 = nil;
    local Position = p2.humanoidRootPart.Position;
    local v8;

    if UserInputService.GamepadEnabled or UserInputService.TouchEnabled then
        local ViewportSize = workspace_CurrentCamera.ViewportSize;
        v8 = Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5);
    else
        v8 = Vector2.new(Mouse.X, Mouse.Y);
    end;

    for _, child in workspace.characters:GetChildren() do
        if child ~= p2.character then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");
            local v9 = child:FindFirstChildWhichIsA("Humanoid");

            if HumanoidRootPart and (v9 and (v9.Health > 0 and actionUtil.ingame(child))) then
                local v10 = actionUtil.checksameTeam(p2.character, child);

                if not (p4 and not v10 or (p5 == false and v10 or p3 < (HumanoidRootPart.Position - Position).Magnitude)) then
                    local v11, v12 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);

                    if v12 then
                        local Magnitude = (v8 - Vector2.new(v11.X, v11.Y)).Magnitude;

                        if not (v6 and (v7 and Magnitude >= v7)) then
                            v7 = Magnitude;
                            v6 = child;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v6;
end;

local function get_mouse_world_position(p13) -- Line: 75
    -- upvalues: Mouse (copy), UserInputService (copy), workspace_CurrentCamera (copy)
    local v14 = Mouse;

    if v14 and v14.Hit then
        return v14.Hit.Position;
    end;

    local v15;

    if UserInputService.GamepadEnabled or UserInputService.TouchEnabled then
        local ViewportSize = workspace_CurrentCamera.ViewportSize;
        v15 = Vector2.new(ViewportSize.X * 0.5, ViewportSize.Y * 0.5);
    else
        v15 = Vector2.new(Mouse.X, Mouse.Y);
    end;

    local v16 = workspace_CurrentCamera:ViewportPointToRay(v15.X, v15.Y);
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = { p13.character };
    local v17 = workspace:Raycast(v16.Origin, v16.Direction * 800, RaycastParams_new_ret);

    if v17 then
        return v17.Position;
    end;

    local v18 = v16.Origin + v16.Direction * 80;

    return Vector3.new(v18.X, p13.humanoidRootPart.Position.Y, v18.Z);
end;

function v1.skill1(p19) -- Line: 96
    -- upvalues: get_closest_aimed_character (copy)
    p19:senduse({ "skill1", (get_closest_aimed_character(p19, 70, nil, true)) });
end;

function v1.skill2(p20) -- Line: 101
    -- upvalues: get_closest_aimed_character (copy)
    local v21 = get_closest_aimed_character(p20, 70, nil, true);

    if not v21 then
        return;
    end;

    p20:senduse({ "skill2", v21 });
end;

function v1.skill4(p22) -- Line: 109
    -- upvalues: actionUtil (copy), get_mouse_world_position (copy)
    if actionUtil.checkball(p22.character) then
        p22:senduse({ "skill4" });

        return;
    end;

    p22:senduse({ "skill4", (get_mouse_world_position(p22)) });
end;

return v1;