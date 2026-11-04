 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {
    __index = {}
};
local actionUtil = require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.packets);
local Mouse = Players.LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;

function v1.skill3(p2) -- Line: 14
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
    local humanoidRootPart = p2.humanoidRootPart;
    local v3 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X, workspace_CurrentCamera.ViewportSize.Y) / 2 or Vector2.new(Mouse.X, Mouse.Y);
    local v4 = nil;
    local v5 = nil;
    local v6 = false;

    for _, child in ipairs(workspace.characters:GetChildren()) do
        if child ~= p2.character then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

            if child:FindFirstChildWhichIsA("Humanoid").Health > 0 and (HumanoidRootPart and actionUtil.checksameTeam(p2.character, child)) then
                local Magnitude = (HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude;
                local v7 = Magnitude > 200;

                if Magnitude <= 215 then
                    local v8, v9 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                    local Vector2_new_ret = Vector2.new(v8.X, v8.Y);

                    if v9 then
                        local Magnitude2 = (v3 - Vector2_new_ret).Magnitude;

                        if not (v4 and (v5 and Magnitude2 >= v5)) then
                            v6 = v7;
                            v5 = Magnitude2;
                            v4 = child;
                        end;
                    end;
                end;
            end;
        end;
    end;

    p2:senduse({ "skill3", v4, v6 });
end;

function v1.skill4(p10) -- Line: 59
    local v11 = p10.humanoidRootPart.CFrame:VectorToObjectSpace(p10.human.MoveDirection);
    local v12 = math.round(v11.X) == -1 and "left" or (math.round(v11.X) == 1 and "right" or (math.round(v11.Z) == 1 and "back" or "front"));
    p10:senduse({ "skill4", v12 });
    print("direction on client is", v12);
end;

return v1;