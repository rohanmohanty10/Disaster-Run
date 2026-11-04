  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local v11 = v1({
    animationId = "rbxassetid://133728818910723",
    looped = true,
    maxWalkDistance = (1 / 0),
    meta = {
        rarity = "Limited",
        continuousDisplay = true
    },

    effect = function(u2, u3, u4) -- Line: 12, Name: effect
        -- upvalues: Trove (copy), RunService (copy)
        local u5 = Trove.new();
        local HumanoidRootPart = u2.HumanoidRootPart;
        local Humanoid = u2.Humanoid;
        local Attribute = script:GetAttribute("ReferenceCFrame");
        local v6 = script.Visuals:Clone();
        v6.Name = "EagleRideVisuals";
        u5:Add(v6);

        for _, descendant in v6:GetDescendants() do
            if descendant:IsA("BasePart") then
                local v7 = Attribute:ToObjectSpace(descendant.CFrame);
                descendant.CFrame = HumanoidRootPart.CFrame * v7;
                descendant.Anchored = false;
                descendant.Massless = true;
                descendant.CanCollide = false;
                descendant.CanTouch = false;
                descendant.CanQuery = false;
                local Weld = Instance.new("Weld");
                Weld.Name = "EagleRideWeld";
                Weld.C0 = v7;
                Weld.Part0 = HumanoidRootPart;
                Weld.Part1 = descendant;
                Weld.Parent = descendant;
            end;
        end;

        v6.Parent = u2;
        local Animator = v6.Phoenix.AnimationController.Animator;
        local success, result = pcall(function() -- Line: 43
            -- upvalues: Animator (copy)
            return Animator:LoadAnimation(script.PhoenixAnimation);
        end);

        if not success then
            warn("Eagle Ride could not load its phoenix animation:", result);
            u3:Stop(0);
            u5:Destroy();

            return u5;
        end;

        result.Looped = true;
        result.Priority = Enum.AnimationPriority.Action4;
        u5:Add(result, "Stop");
        result:Play(0);

        local function syncTracks() -- Line: 59
            -- upvalues: result (copy), u3 (copy)
            local Length = result.Length;

            if Length <= 0 then
                return;
            end;

            if not result.IsPlaying and u3.IsPlaying then
                result:Play(0);
            end;

            local v8 = u3.TimePosition % Length;
            local math_abs_ret = math.abs(result.TimePosition - v8);
            local math_abs_ret2 = math.abs(Length - math_abs_ret);

            if math.min(math_abs_ret, math_abs_ret2) > 0.05 then
                result.TimePosition = v8;
            end;

            if result.Speed ~= u3.Speed then
                result:AdjustSpeed(u3.Speed);
            end;
        end;

        syncTracks();
        u5:Add(u3.DidLoop:Connect(syncTracks));

        local function stop() -- Line: 79
            -- upvalues: u3 (copy), u5 (copy)
            u3:Stop(0);
            u5:Destroy();
        end;

        u5:Add(u3.Stopped:Connect(function() -- Line: 83
            -- upvalues: u5 (copy)
            u5:Destroy();
        end));
        u5:Add(Humanoid.Died:Connect(stop));
        u5:Add(u2.Destroying:Connect(stop));
        local u9 = 0;
        u5:Add(RunService.Heartbeat:Connect(function(p10) -- Line: 90
            -- upvalues: u2 (copy), HumanoidRootPart (copy), u3 (copy), u5 (copy), u4 (copy), Humanoid (copy), u9 (ref), syncTracks (copy)
            if not (u2.Parent and HumanoidRootPart.Parent) then
                u3:Stop(0);
                u5:Destroy();

                return;
            end;

            if u4 == "Game" and Humanoid.Jump then
                u3:Stop(0);
                u5:Destroy();

                return;
            end;

            u9 = u9 + p10;

            if u9 >= 0.25 then
                u9 = 0;
                syncTracks();
            end;
        end));

        return u5;
    end
});
v11.isMount = true;

return v11;