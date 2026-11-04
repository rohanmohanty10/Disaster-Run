  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local EmitModule = require(ReplicatedStorage.Shared.EmitModule);
local u2 = { {
        Rig = "Rower1",
        AnimationId = "rbxassetid://104210449510399"
    }, {
        Rig = "Rower2",
        AnimationId = "rbxassetid://138533560714930"
    } };

local function playRigAnimation(p3, p4) -- Line: 21
    local v5 = p3.Humanoid:FindFirstChildOfClass("Animator");
    local Animation = Instance.new("Animation");
    Animation.AnimationId = p4;
    Animation.Parent = p3;
    local v6 = v5:LoadAnimation(Animation);
    v6.Looped = true;
    v6.Priority = Enum.AnimationPriority.Action4;
    v6:Play();

    return v6;
end;

local function pickFriendIds(p7, p8) -- Line: 33
    -- upvalues: Players (copy)
    local v9 = {};

    if not p7 then
        return v9;
    end;

    local success, result = pcall(Players.GetFriendsAsync, Players, p7.UserId);

    if not success then
        return v9;
    end;

    local success2, result2 = pcall(result.GetCurrentPage, result);

    if not success2 then
        return v9;
    end;

    local v10 = {};

    for _, v in result2 do
        table.insert(v10, v.Id);
    end;

    while #v10 > 0 and #v9 < p8 do
        table.insert(v9, table.remove(v10, math.random(#v10)));
    end;

    return v9;
end;

local function applyRowerLooks(u11, p12) -- Line: 50
    -- upvalues: Players (copy), pickFriendIds (copy)
    local u13 = pickFriendIds(Players:GetPlayerFromCharacter(u11) or Players.LocalPlayer, #p12);
    local u14 = nil;
    pcall(function() -- Line: 54
        -- upvalues: u14 (ref), u11 (copy)
        u14 = u11.Humanoid:GetAppliedDescription();
    end);

    for i, v in p12 do
        task.spawn(function() -- Line: 58
            -- upvalues: u13 (copy), i (copy), Players (ref), u14 (ref), v (copy)
            local u15 = nil;

            if u13[i] then
                pcall(function() -- Line: 61
                    -- upvalues: u15 (ref), Players (ref), u13 (ref), i (ref)
                    u15 = Players:GetHumanoidDescriptionFromUserId(u13[i]);
                end);
            end;

            u15 = u15 or u14;

            if not (u15 and v.Parent) then
                return;
            end;

            pcall(function() -- Line: 67
                -- upvalues: v (ref), u15 (ref)
                v.Humanoid:ApplyDescription(u15);
            end);
        end);
    end;
end;

return v1({
    animationId = "rbxassetid://124481609933420",
    looped = true,
    maxWalkDistance = 1,
    meta = {
        rarity = "Mythic"
    },

    effect = function(p16: any, u17: userdata, p18: any) -- Line: 79, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), playRigAnimation (copy), u2 (copy), applyRowerLooks (copy), RunService (copy), EmitModule (copy)
        local u19 = Trove.new();
        local HumanoidRootPart = p16:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return u19;
        end;

        local VikingRow = ReplicatedStorage.Assets.Misc.VikingRow;
        local HumanoidRootPart2 = VikingRow.HumanoidRootPart;
        local u20 = {};

        local function disableCollision(p21) -- Line: 89
            for _, v in p21:IsA("BasePart") and { p21 } or p21:GetDescendants() do
                if v:IsA("BasePart") then
                    v.CanCollide = false;
                    v.CanQuery = false;
                    v.CanTouch = false;
                end;
            end;

            if not p21:IsA("BasePart") then
                for _, descendant in p21:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.Massless = true;
                    end;
                end;
            end;
        end;

        local function placeClone(p22, p23) -- Line: 107
            -- upvalues: HumanoidRootPart2 (copy), HumanoidRootPart (copy), disableCollision (copy), u19 (copy), u20 (copy)
            local v24 = p22:Clone();
            local v25 = HumanoidRootPart2.CFrame:ToObjectSpace(p22:GetPivot());
            v24:PivotTo(HumanoidRootPart.CFrame * v25);
            local v26 = v24:IsA("Model") and v24:FindFirstChild("Humanoid");

            if v26 then
                v26.EvaluateStateMachine = false;
            end;

            disableCollision(v24);

            if p23 then
                v24.HumanoidRootPart.Anchored = true;
            else
                for _, v in v24:IsA("BasePart") and { v24 } or v24:GetDescendants() do
                    if v:IsA("BasePart") then
                        v.Anchored = true;
                    end;
                end;
            end;

            v24.Parent = workspace.Debris;
            task.defer(disableCollision, v24);
            u19:Add(v24);
            table.insert(u20, {
                Instance = v24,
                Offset = v25
            });

            return v24;
        end;

        local u27 = { (playRigAnimation(placeClone(VikingRow.Stuff, true), "rbxassetid://83685686834483")) };
        local v28 = {};

        for _, v in u2 do
            local v29 = placeClone(VikingRow[v.Rig], true);
            local v30 = playRigAnimation(v29, v.AnimationId);
            table.insert(u27, v30);
            table.insert(v28, v29);
        end;

        task.spawn(applyRowerLooks, p16, v28);
        placeClone(VikingRow.Rain);
        local u31 = placeClone(VikingRow.DrumEmit);
        local CFrame = HumanoidRootPart.CFrame;
        u19:Add(RunService.Heartbeat:Connect(function() -- Line: 149
            -- upvalues: HumanoidRootPart (copy), CFrame (ref), u20 (copy)
            if not HumanoidRootPart.Parent then
                return;
            end;

            local CFrame2 = HumanoidRootPart.CFrame;

            if (CFrame2.Position - CFrame.Position).Magnitude <= 0.005 and (CFrame2.LookVector - CFrame.LookVector).Magnitude <= 0.005 then
                return;
            end;

            CFrame = CFrame2;

            for _, v in u20 do
                if v.Instance.Parent then
                    v.Instance:PivotTo(CFrame2 * v.Offset);
                end;
            end;
        end));
        local Sound = Instance.new("Sound");
        Sound.SoundId = "rbxassetid://83070080312706";
        Sound.Looped = false;
        Sound.Parent = HumanoidRootPart;
        u19:Add(Sound);
        local u32 = true;
        u19:Add(function() -- Line: 170
            -- upvalues: u32 (ref)
            u32 = false;
        end);
        task.spawn(function() -- Line: 174
            -- upvalues: u32 (ref), u17 (copy), u27 (copy), u31 (copy), EmitModule (ref), Sound (copy)
            local v33 = os.clock() + 5;

            while u32 and os.clock() < v33 do
                local v34 = u17.Length > 0;

                for _, v in u27 do
                    if v.Length <= 0 then
                        v34 = false;
                    end;
                end;

                if v34 then
                    break;
                end;

                task.wait(0.05);
            end;

            if not u32 then
                return;
            end;

            u17.TimePosition = 0;

            for _, v in u27 do
                v.TimePosition = 0;
            end;

            local ServerTimeNow = workspace:GetServerTimeNow();
            task.spawn(function() -- Line: 191
                -- upvalues: u32 (ref), ServerTimeNow (copy), u31 (ref), EmitModule (ref), Sound (ref)
                while u32 do
                    local v35 = (workspace:GetServerTimeNow() - ServerTimeNow - 0.08) / 2.5;
                    local math_ceil_ret = math.ceil(v35);
                    local math_max_ret = math.max(math_ceil_ret, 0);

                    while u32 and workspace:GetServerTimeNow() < ServerTimeNow + 0.08 + math_max_ret * 2.5 do
                        task.wait();
                    end;

                    if not u32 then
                        return;
                    end;

                    if u31.Parent then
                        pcall(EmitModule.emit, u31);
                    end;

                    task.delay(0.2, function() -- Line: 203
                        -- upvalues: u32 (ref), Sound (ref)
                        if not (u32 and Sound.Parent) then
                            return;
                        end;

                        Sound.TimePosition = 0;
                        Sound:Play();
                        task.delay(1, function() -- Line: 207
                            -- upvalues: Sound (ref)
                            if Sound.Parent then
                                Sound:Stop();
                            end;
                        end);
                    end);
                    task.wait(0.1);
                end;
            end);

            while u32 do
                task.wait(0.5);

                if u17.IsPlaying then
                    local TimePosition = u17.TimePosition;

                    for _, v in u27 do
                        if v.IsPlaying and math.abs((v.TimePosition - TimePosition + 1.25) % 2.5 - 1.25) > 0.05 then
                            v.TimePosition = TimePosition;
                        end;
                    end;
                end;
            end;
        end);

        return u19;
    end
});