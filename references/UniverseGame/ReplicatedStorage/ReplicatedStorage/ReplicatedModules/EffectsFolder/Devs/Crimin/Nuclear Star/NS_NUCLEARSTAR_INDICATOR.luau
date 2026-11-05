  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Whitelist;
u2.FilterDescendantsInstances = { workspace.Map };

return function(u3, p4) -- Line: 12
    -- upvalues: u1 (copy), RunService (copy), u2 (copy)
    local v5 = u3:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v5) then
        return;
    end;

    if not p4 then
        local Indicator = u3:FindFirstChild("Indicator");

        if Indicator then
            Indicator.Name = "IndicatorOff";

            for _, descendant in pairs(Indicator:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2.5, function() -- Line: 43
                -- upvalues: Indicator (copy)
                Indicator:Destroy();
            end);
        end;

        return;
    end;

    local u6 = u1["Nuclear Star"].Indicator:Clone();
    u6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
    u6.Parent = u3;
    local u7 = nil;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 25
        -- upvalues: u3 (copy), u7 (ref), HumanoidRootPart (copy), u2 (ref), u6 (copy)
        if not u3:FindFirstChild("Indicator") then
            u7:Disconnect();
        end;

        local v9 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -20, 0), u2);

        if v9 then
            u6.CFrame = CFrame.new(v9.Position) * CFrame.new(0, 0.1, 0);
        end;
    end);
end;