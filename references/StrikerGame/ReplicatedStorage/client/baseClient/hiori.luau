 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.packets);
require(script.Parent);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local v1 = {};
local Mouse = Players.LocalPlayer:GetMouse();
local workspace_CurrentCamera = workspace.CurrentCamera;

function v1.skill1(p2) -- Line: 18
    local v3 = p2.humanoidRootPart.CFrame.RightVector:Dot(p2.human.MoveDirection);
    local v4 = nil;
    local v5;

    if math.abs(v3) < 0.4 then
        v4 = "Forward";
        v5 = "Front";
    elseif v3 < 0 then
        v5 = "Left";
    else
        v5 = "Right";
    end;

    p2:senduse({ "skill1", v4 or "Side", v5 });
end;

function v1.skill2(p6) -- Line: 39
    -- upvalues: workspace_CurrentCamera (copy)
    p6:senduse({ "skill2", workspace_CurrentCamera.CFrame.LookVector });
end;

function v1.skill3(p7: userdata) -- Line: 43
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
    local v8 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2) or Vector2.new(Mouse.X, Mouse.Y, Mouse.Hit.p);
    local v9 = nil;
    local v10 = nil;

    for _, child in pairs(workspace.characters:GetChildren()) do
        if not table.find({ child }, p7.character) then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

            if child:FindFirstChildOfClass("Humanoid").Health > 0 and (HumanoidRootPart and (actionUtil.checksameTeam(p7.character, child) and (HumanoidRootPart.Position - p7.humanoidRootPart.Position).magnitude < 150)) then
                local v11, v12 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                local Vector2_new_ret = Vector2.new(v11.X, v11.Y);

                if v12 then
                    local magnitude = (v8 - Vector2_new_ret).magnitude;

                    if v9 and v10 then
                        if magnitude < v10 then
                            v10 = magnitude;
                            v9 = child;
                        end;
                    else
                        v10 = magnitude;
                        v9 = child;
                    end;
                end;
            end;
        end;
    end;

    p7:senduse({ "skill3", v9 });
end;

function v1.Tspecialer(p13) -- Line: 87
    local shared_moveVector = shared.moveVector;
    local v14 = 10;
    local v15 = nil;

    for i, v in {
        p = Vector3.new(0, 0, 0),
        w = Vector3.new(0, 0, -1),
        s = Vector3.new(0, 0, 1)
    } do
        if (v - shared_moveVector).Magnitude < v14 then
            v14 = (v - shared_moveVector).Magnitude;
            v15 = i;
        end;
    end;

    p13:senduse({ "Tspecialer", v15 == "w" });
end;

function v1.skill4(p16: userdata) -- Line: 113
    -- upvalues: UserInputService (copy), workspace_CurrentCamera (copy), Mouse (copy), actionUtil (copy)
    local v17 = p16.character:GetAttribute("FlowActive") or p16.character:HasTag("awaketest");
    local v18 = (UserInputService.GamepadEnabled or UserInputService.TouchEnabled) and Vector2.new(workspace_CurrentCamera.ViewportSize.X / 2, workspace_CurrentCamera.ViewportSize.Y / 2) or Vector2.new(Mouse.X, Mouse.Y, Mouse.Hit.p);
    local v19 = nil;
    local v20 = v17 and 495 or 350;
    local v21 = nil;
    local v22 = false;

    for _, child in pairs(workspace.characters:GetChildren()) do
        if not table.find({ child }, p16.character) then
            local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart");

            if child:FindFirstChildOfClass("Humanoid").Health > 0 and (HumanoidRootPart and actionUtil.checksameTeam(p16.character, child)) then
                local magnitude = (HumanoidRootPart.Position - p16.humanoidRootPart.Position).magnitude;
                local v23 = v17 and magnitude >= 140 and true or false;

                if v20 > magnitude then
                    local v24, v25 = workspace_CurrentCamera:WorldToScreenPoint(HumanoidRootPart.Position);
                    local Vector2_new_ret = Vector2.new(v24.X, v24.Y);

                    if v25 then
                        local magnitude2 = (v18 - Vector2_new_ret).magnitude;

                        if v21 and v19 then
                            if magnitude2 < v19 then
                                v22 = v23;
                                v21 = child;
                                v19 = magnitude2;
                            end;
                        else
                            v22 = v23;
                            v21 = child;
                            v19 = magnitude2;
                        end;
                    end;
                end;
            end;
        end;
    end;

    p16:senduse({ "skill4", v21, v22 });
end;

return v1;