 
 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local v1 = {
    __index = {}
};
local actionUtil = require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.packets);
local Mouse = Players.LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;

function v1.skill4(p2) -- Line: 18
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
    local v3 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2) or Vector2.new(Mouse.X, Mouse.Y, Mouse.Hit.p);
    local v4 = nil;
    local v5 = nil;

    for _, child in pairs(workspace.characters:GetChildren()) do
        if not table.find({ child }, p2.character) then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

            if child:FindFirstChildOfClass("Humanoid").Health > 0 and (HumanoidRootPart and (actionUtil.checksameTeam(p2.character, child) and (HumanoidRootPart.Position - p2.humanoidRootPart.Position).magnitude < 10000)) then
                local v6, v7 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                local Vector2_new_ret = Vector2.new(v6.X, v6.Y);

                if v7 then
                    local magnitude = (v3 - Vector2_new_ret).magnitude;

                    if v4 and v5 then
                        if magnitude < v5 then
                            v5 = magnitude;
                            v4 = child;
                        end;
                    else
                        v5 = magnitude;
                        v4 = child;
                    end;
                end;
            end;
        end;
    end;

    p2:senduse({ "skill4", v4 });
end;

return v1;