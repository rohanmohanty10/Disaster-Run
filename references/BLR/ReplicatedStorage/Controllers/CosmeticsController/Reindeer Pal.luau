  

local v1 = {};
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(p2, p3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy), RunService (copy)
    local u4 = script.Reindeer:Clone();
    local v5 = p2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(u4:GetPivot());
    u4.Parent = p2;
    local u6 = Essentials:WeldOffset(p2.HumanoidRootPart, u4.RootPart, CFrame.new());
    local u7 = p2.HumanoidRootPart.CFrame:ToObjectSpace(v5);
    u6.C0 = u7;
    local Animation = Instance.new("Animation");
    Animation.AnimationId = "rbxassetid://129048524406768";
    local u8 = u4.AnimationController.Animator:LoadAnimation(Animation);
    local Animation2 = Instance.new("Animation");
    Animation2.AnimationId = "rbxassetid://131034024223012";
    local u9 = u4.AnimationController.Animator:LoadAnimation(Animation2);
    CollectionService:AddTag(u4, (`Cosmetic{p3}`));
    local u10 = p2:FindFirstChildOfClass("Humanoid");

    if not u10 then
        return;
    end;

    local HipHeight = u10.HipHeight;

    local function updateWeldForHipHeight() -- Line: 41
        -- upvalues: u10 (copy), HipHeight (copy), u6 (copy), u7 (copy)
        u6.C0 = u7 * CFrame.new(0, -(u10.HipHeight - HipHeight), 0);
    end;

    u6.C0 = u7 * CFrame.new(0, -(u10.HipHeight - HipHeight), 0);
    local u11 = u10:GetPropertyChangedSignal("HipHeight"):Connect(function() -- Line: 53
        -- upvalues: u10 (copy), HipHeight (copy), u6 (copy), u7 (copy)
        u6.C0 = u7 * CFrame.new(0, -(u10.HipHeight - HipHeight), 0);
    end);
    u8:Play();
    local u12 = u8;
    local u13 = nil;
    u13 = RunService.Heartbeat:Connect(function() -- Line: 63
        -- upvalues: u4 (copy), u13 (ref), u11 (copy), u10 (copy), u12 (ref), u9 (copy), u8 (copy)
        if not (u4 and u4.Parent) then
            u13:Disconnect();
            u11:Disconnect();

            return;
        end;

        local v14 = u10.MoveDirection.Magnitude > 0;

        if not v14 or u12 == u9 then
            if not v14 and u12 ~= u8 then
                u9:Stop();
                u8:Play();
                u12 = u8;
            end;

            return;
        end;

        u8:Stop();
        u9:Play();
        u12 = u9;
    end);
    u4.Destroying:Connect(function() -- Line: 84
        -- upvalues: u13 (ref), u11 (copy)
        if u13 then
            u13:Disconnect();
        end;

        if u11 then
            u11:Disconnect();
        end;
    end);
end;

return v1;