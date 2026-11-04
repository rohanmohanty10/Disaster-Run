 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {
    __index = {}
};
require(ReplicatedStorage.packets);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local Mouse = Players.LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;

function v1.skill2(p2) -- Line: 12
    -- upvalues: Mouse (copy), actionUtil (copy), workspace_CurrentCamera (copy)
    local Vector2_new_ret = Vector2.new(Mouse.X, Mouse.Y);
    local v3 = nil;
    local v4 = nil;

    for _, child in workspace.characters:GetChildren() do
        if child ~= p2.character and actionUtil.checksameTeam(p2.character, child) then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");
            local v5 = child:FindFirstChildOfClass("Humanoid");

            if HumanoidRootPart and (v5 and (v5.Health > 0 and (HumanoidRootPart.Position - p2.humanoidRootPart.Position).Magnitude < 250)) then
                local v6, v7 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);

                if v7 then
                    local Magnitude = (Vector2_new_ret - Vector2.new(v6.X, v6.Y)).Magnitude;

                    if not v3 or Magnitude < v3 then
                        v4 = child;
                        v3 = Magnitude;
                    end;
                end;
            end;
        end;
    end;

    print("Got closest entity: ", v4 and (v4.Name or "none") or "none");
    p2:senduse({ "skill2", v4 });
end;

function v1.skill3(p8) -- Line: 53
    local UserInputService = game:GetService("UserInputService");
    local v9 = UserInputService:IsKeyDown(Enum.KeyCode.A) or (UserInputService:IsKeyDown(Enum.KeyCode.Left) or UserInputService:IsKeyDown(Enum.KeyCode.DPadLeft));
    local GamepadState = UserInputService:GetGamepadState(Enum.UserInputType.Gamepad1);

    for _, v in ipairs(GamepadState) do
        if v.KeyCode == Enum.KeyCode.Thumbstick1 and v.Position.X < -0.1 then
            v9 = true;
        end;
    end;

    p8:senduse({ "skill3", v9 and "Left" or "Right" });
end;

return v1;