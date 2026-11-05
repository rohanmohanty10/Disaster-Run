  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

local function Lerp(p1, p2, p3) -- Line: 6
    return p1 + (p2 - p1) * p3;
end;

return function(p4) -- Line: 11
    -- upvalues: Trove (copy), Knit (copy)
    local u5 = p4 or game.Players.LocalPlayer.Character;
    local HumanoidRootPart = u5:FindFirstChild("HumanoidRootPart");
    local Humanoid = u5:FindFirstChild("Humanoid");
    local v6;

    if Humanoid then
        v6 = Humanoid:FindFirstChild("Animator");
    else
        v6 = Humanoid;
    end;

    if not (Humanoid and HumanoidRootPart) then
        return;
    end;

    local u7 = Trove.new();
    u7:AttachToInstance(u5);
    u7:Connect(u5.AncestryChanged, function() -- Line: 24
        -- upvalues: u5 (copy), u7 (copy)
        if not u5:IsDescendantOf(workspace) then
            u7:Destroy();
        end;
    end);
    u7:Connect(Knit.CollectionService:GetInstanceRemovedSignal("TimeAffected"), function(p8) -- Line: 29
        -- upvalues: u5 (copy), u7 (copy)
        if u5 == p8 then
            u7:Destroy();
        end;
    end);
    local u9 = true;
    local u10 = {};

    local function AnimationPlayed(p11) -- Line: 37
        -- upvalues: u10 (copy), u9 (ref)
        if not p11:GetAttribute("__OriginalSpeed") then
            p11:SetAttribute("__OriginalSpeed", p11.Speed);
        end;

        if not u10[p11] then
            u10[p11] = true;
        end;

        local Speed = p11.Speed;
        local v12 = os.clock();

        while os.clock() - v12 <= 0.2 and (p11.IsPlaying and u9) do
            local v13 = os.clock() - v12;
            local v14 = math.abs(v13) / 0.2;
            local v15 = math.clamp(v14, 0, 1);
            p11:AdjustSpeed(Speed + (0 - Speed) * v15);
            task.wait();
        end;

        if p11.IsPlaying and u9 then
            p11:AdjustSpeed(0);
        end;
    end;

    for _, v in pairs(Humanoid:GetPlayingAnimationTracks()) do
        task.spawn(AnimationPlayed, v);
    end;

    for _, v in pairs(v6:GetPlayingAnimationTracks()) do
        task.spawn(AnimationPlayed, v);
    end;

    u7:Connect(Humanoid.AnimationPlayed, AnimationPlayed);
    u7:Connect(v6.AnimationPlayed, AnimationPlayed);
    u7:Add(function() -- Line: 71
        -- upvalues: u9 (ref), u10 (copy)
        u9 = false;
        task.defer(function() -- Line: 73
            -- upvalues: u10 (ref)
            for i, _ in pairs(u10) do
                local v16 = i:GetAttribute("__OriginalSpeed");

                if v16 then
                    i:AdjustSpeed(v16);
                end;
            end;
        end);
    end);
end;