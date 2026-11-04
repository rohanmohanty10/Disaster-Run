  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local CameraCFrame = script.Parent.CameraCFrame;
local ClientComponent = require(ReplicatedStorage.CharRepBooster.CharRepBooster):GetClientComponent();
require(ReplicatedStorage.CharRepBooster.CharRepBooster.Components.GlobalConfig);
ClientComponent.Initiate();

local function OnCharacterObjectAdded(u1) -- Line: 13
    -- upvalues: Players (copy), RunService (copy)
    if u1.Player == Players.LocalPlayer then
        RunService:BindToRenderStep("CustomShiftLockCorrection", Enum.RenderPriority.Character.Value + 1, function() -- Line: 15
            -- upvalues: u1 (copy)
            u1.LastClientSnapshot.CFrame = u1.HumanoidRootPart.CFrame;
        end);
        u1.Trove:Add(function() -- Line: 18
            -- upvalues: RunService (ref)
            RunService:UnbindFromRenderStep("CustomShiftLockCorrection");
        end);
    end;

    local function Process(p2) -- Line: 23
        p2:SetAttribute("Invis", true);
    end;

    u1.CharacterDebugCloneAdded:Connect(function(p3) -- Line: 26
        p3:SetAttribute("Invis", true);

        for _, descendant in p3:GetDescendants() do
            descendant:SetAttribute("Invis", true);
        end;
    end);
    u1.CharacterDebugVelocityAdded:Connect(function(p4) -- Line: 30
        p4:SetAttribute("Invis", true);

        for _, descendant in p4:GetDescendants() do
            descendant:SetAttribute("Invis", true);
        end;
    end);
end;

for _, v in ClientComponent.CharacterObjects do
    task.spawn(OnCharacterObjectAdded, v);
end;

ClientComponent.CharacterObjectAdded:Connect(OnCharacterObjectAdded);

while true do
    CameraCFrame:FireServer(workspace.CurrentCamera.CFrame);
    task.wait(0.1);
end;