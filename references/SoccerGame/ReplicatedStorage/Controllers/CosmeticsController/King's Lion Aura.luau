  

local v1 = {};
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

function v1.SetupCosmetic(u2, p3) -- Line: 6
    -- upvalues: CollectionService (copy), RunService (copy)
    local u4 = nil;
    local u5 = script.BarouCosmetic:Clone();
    u5.Parent = u2;
    local v6 = u5.AnimationController:LoadAnimation(u5.Animation);
    v6.Looped = true;
    v6:Play();
    CollectionService:AddTag(u5, (`Cosmetic{p3}`));
    u4 = RunService.RenderStepped:Connect(function(p7) -- Line: 17
        -- upvalues: u2 (copy), u4 (ref), u5 (copy)
        if not (u2 and u2.Parent) then
            u4:Disconnect();
            u5:Destroy();

            return;
        end;

        local HumanoidRootPart = u2:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        u5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-0.5, -2.5, 0));
    end);
end;

return v1;