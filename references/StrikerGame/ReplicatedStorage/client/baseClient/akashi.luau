 

 

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

function v1.skill1(p2) -- Line: 17
    local v3 = p2.humanoidRootPart.CFrame:VectorToObjectSpace(p2.human.MoveDirection);
    p2:senduse({ "skill1", math.round(v3.X) == -1 and "left" or (math.round(v3.X) == 1 and "right" or "front") });
end;

function v1.skill4(p4) -- Line: 33
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
    local v5 = p4.character:GetAttribute("RinNoPlay") and 10000 or 375;
    local v6 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2) or Vector2.new(Mouse.X, Mouse.Y, Mouse.Hit.p);
    local v7 = nil;
    local v8 = nil;

    for _, child in pairs(workspace.characters:GetChildren()) do
        if not table.find({ child }, p4.character) then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");
            local v9 = child:FindFirstChildOfClass("Humanoid");

            if v9 and (v9.Health > 0 and (HumanoidRootPart and (actionUtil.checksameTeam(p4.character, child) and v5 > (HumanoidRootPart.Position - p4.humanoidRootPart.Position).magnitude))) then
                local v10, v11 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                local Vector2_new_ret = Vector2.new(v10.X, v10.Y);

                if v11 then
                    local magnitude = (v6 - Vector2_new_ret).magnitude;

                    if v7 and v8 then
                        if magnitude < v8 then
                            v8 = magnitude;
                            v7 = child;
                        end;
                    else
                        v8 = magnitude;
                        v7 = child;
                    end;
                end;
            end;
        end;
    end;

    p4:senduse({ "skill4", v7 });
end;

return v1;