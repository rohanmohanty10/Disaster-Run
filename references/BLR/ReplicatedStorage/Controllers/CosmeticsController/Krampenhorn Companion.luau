  

local v1 = {};
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(u2, u3) -- Line: 7
    -- upvalues: Essentials (copy), CollectionService (copy), RunService (copy)
    local function setupCosmeticWithAnimations(p4) -- Line: 8
        -- upvalues: u2 (copy), Essentials (ref), CollectionService (ref), u3 (copy), RunService (ref)
        local u5 = script[p4]:Clone();
        u5:PivotTo(u2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(u5:GetPivot()));
        u5.Parent = u2;
        Essentials:Weld(u2.HumanoidRootPart, u5.RootPart, u5);
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://111982220940976";
        local u6 = u5.AnimationController.Animator:LoadAnimation(Animation);
        local Animation2 = Instance.new("Animation");
        Animation2.AnimationId = "rbxassetid://109701637458874";
        local u7 = u5.AnimationController.Animator:LoadAnimation(Animation2);
        CollectionService:AddTag(u5, (`Cosmetic{u3}`));
        local u8 = u2:FindFirstChildOfClass("Humanoid");

        if not u8 then
            return;
        end;

        u6:Play();
        local u9 = u6;
        local u10 = nil;
        u10 = RunService.Heartbeat:Connect(function() -- Line: 32
            -- upvalues: u5 (copy), u10 (ref), u8 (copy), u9 (ref), u7 (copy), u6 (copy)
            if not (u5 and u5.Parent) then
                u10:Disconnect();

                return;
            end;

            local v11 = u8.MoveDirection.Magnitude > 0;

            if not v11 or u9 == u7 then
                if not v11 and u9 ~= u6 then
                    u7:Stop();
                    u6:Play();
                    u9 = u6;
                end;

                return;
            end;

            u6:Stop();
            u7:Play();
            u9 = u7;
        end);
        u5.Destroying:Connect(function() -- Line: 49
            -- upvalues: u10 (ref)
            if u10 then
                u10:Disconnect();
            end;
        end);
    end;

    setupCosmeticWithAnimations("Krampenhorn");
    setupCosmeticWithAnimations("Krampenhorn2");
end;

return v1;