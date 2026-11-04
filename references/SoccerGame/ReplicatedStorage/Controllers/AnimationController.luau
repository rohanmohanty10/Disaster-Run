  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("ContentProvider");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local Trove = require(ReplicatedStorage.Shared.Trove);
local LocalPlayer = Players.LocalPlayer;
require(ReplicatedStorage.Shared.Essentials);
local Animations = require(ReplicatedStorage.Assets.Animations);
local CamAnimations = require(ReplicatedStorage.Assets.CamAnimations);
local u1 = {
    Loki = require(ReplicatedStorage.Assets.Animations.Loki),
    Rin = require(ReplicatedStorage.Assets.Animations.Rin),
    Snuffy = require(ReplicatedStorage.Assets.Animations.Snuffy)
};
local AnimationEffects = require(ReplicatedStorage2.Assets.AnimationEffects);
local Observers = require(ReplicatedStorage2.Packages.Observers);
local u2 = { "SixthSenseIdle", "CustomW", "CustomWBack", "CustomR", "Idle", "GoalieIdle", "OnBallIdle", "OnBallCustomW", "OnBallCustomR", "MiroIdle", "MiroCustomW", "MiroCustomR", "MiroBallIdle" };
local u3 = { "Idle", "MiroBallIdle", "Walk", "OnBallIdle", "OnBallWalk" };
local u4 = nil;
local u5 = nil;
local u6 = nil;
local buffer_copy = buffer.copy;
local buffer_create = buffer.create;
local buffer_len = buffer.len;

function deepCopy(p7)
    -- upvalues: buffer_copy (copy), buffer_create (copy), buffer_len (copy)
    if type(p7) ~= "table" then
        return p7;
    end;

    local table_clone_ret = table.clone(p7);

    for i, v in p7 do
        if type(v) == "table" then
            table_clone_ret[i] = deepCopy(v);
        elseif type(v) == "buffer" then
            table_clone_ret[i] = buffer_copy(v, 0, buffer_create(buffer_len(v)));
        end;
    end;

    return table_clone_ret;
end;

local v8 = {
    Name = "AnimationController"
};
local u9 = {};

function v8.Watch(p10: table, p11: userdata) -- Line: 87
    -- upvalues: u9 (copy)
    if not table.find(u9, p11) then
        table.insert(u9, p11);
    end;
end;

function v8.StopAnims(p12) -- Line: 93
    -- upvalues: u9 (copy)
    p12:StopReceive();

    for _, v in u9 do
        v:Stop();
    end;

    table.clear(u9);

    for _, v in pairs(p12) do
        if typeof(v) == "table" then
            for _, v2 in pairs(v) do
                if typeof(v2) == "Instance" then
                    v2:Stop();
                end;
            end;
        end;
    end;
end;

function v8.StopReceive(p13) -- Line: 111
    p13.PendingReceive = nil;
    local ActiveReceive = p13.ActiveReceive;
    p13.ActiveReceive = nil;

    if ActiveReceive then
        ActiveReceive.characterTrack:Stop(0.05);
        ActiveReceive.ballTrack:Stop(0.05);
    end;
end;

function v8.ReceiveBall(p14, p15, p16, p17) -- Line: 121
    -- upvalues: u4 (ref), LocalPlayer (copy)
    if p15 ~= u4 or (p15 ~= LocalPlayer.Character or not (p16 and (type(p17) == "number" and (p14.Movement and (p14.Movement.Receive and (p14.Ball and p14.Ball.Receive)))))) then
        return;
    end;

    if p14.LastReceiveCharacter == p15 and p17 <= (p14.LastReceiveId or 0) then
        return;
    end;

    p14:StopReceive();
    p14.LastReceiveCharacter = p15;
    p14.LastReceiveId = p17;
    p14.PendingReceive = {
        character = p15,
        ball = p16,
        possessionId = p17,
        characterTrack = p14.Movement.Receive,
        ballTrack = p14.Ball.Receive,
        deadline = os.clock() + 0.75
    };
end;

function v8.UpdateReceive(p18) -- Line: 146
    -- upvalues: u4 (ref), LocalPlayer (copy), u5 (ref), u6 (ref), ReplicatedStorage (copy)
    local v19 = p18.ActiveReceive or p18.PendingReceive;

    if not v19 then
        return;
    end;

    if v19.character ~= u4 or (u4 ~= LocalPlayer.Character or not (u4 and (u4.Parent and (u5 and (u5.Health > 0 and (u6 and not (u6.Anchored or (p18.Movement.Receive ~= v19.characterTrack or p18.Ball.Receive ~= v19.ballTrack)))))))) then
        p18:StopReceive();

        return;
    end;

    local Values = u4:FindFirstChild("Values");
    local IsRagdoll = u4:FindFirstChild("IsRagdoll");
    local v20 = not Values or IsRagdoll and IsRagdoll.Value or (p18.StatesController and p18.StatesController.States.Ability or ReplicatedStorage.GameValues.AwakeningCutscene.Value);

    if Values then
        for _, v in { "InCutscene", "Stunned", "Sliding", "Diving", "Dribbling" } do
            local v21 = Values:FindFirstChild(v);

            if v21 and v21.Value then
                v20 = true;
            end;
        end;
    end;

    local v22 = u4:GetAttribute("BallPossessionId") or 0;

    if v20 or v19.possessionId < v22 then
        p18:StopReceive();

        return;
    end;

    local HasBall = Values:FindFirstChild("HasBall");
    local Char = v19.ball:FindFirstChild("Char");

    if v22 == v19.possessionId then
        local v23 = HasBall and HasBall.Value;

        if v23 then
            if v19.ball.Parent == u4 then
                if Char then
                    Char = Char.Value == u4;
                end;
            else
                Char = false;
            end;
        else
            Char = v23;
        end;
    else
        Char = false;
    end;

    if not p18.PendingReceive then
        if not (Char and (v19.characterTrack.IsPlaying and v19.ballTrack.IsPlaying)) then
            p18:StopReceive();
        end;

        return;
    end;

    if not Char then
        if os.clock() >= v19.deadline then
            p18:StopReceive();
        end;

        return;
    end;

    p18.PendingReceive = nil;
    p18.ActiveReceive = v19;
    v19.characterTrack.Priority = Enum.AnimationPriority.Action2;
    v19.ballTrack.Priority = Enum.AnimationPriority.Action2;
    v19.characterTrack.Looped = false;
    v19.ballTrack.Looped = false;
    v19.characterTrack:Play(0.05);
    v19.ballTrack:Play(0.05);
end;

function v8.WalkAnimations(u24) -- Line: 202
    -- upvalues: LocalPlayer (copy), Trove (copy), u4 (ref), RunService (copy), u5 (ref), u6 (ref), u2 (copy), u3 (copy)
    local u25 = LocalPlayer:FindFirstChild("PlayerStats") and LocalPlayer:FindFirstChild("PlayerStats"):FindFirstChild("Style");

    if u24.WalkTrove then
        u24.WalkTrove:Destroy();
    end;

    u24.Movement.Idle.Priority = Enum.AnimationPriority.Action;
    u24.WalkTrove = Trove.new();

    local function getMovementAnimation(p26) -- Line: 211
        -- upvalues: u4 (ref), u24 (copy)
        if u4.Values.HasBall.Value and u24.Movement[`OnBall{p26}`] then
            return `OnBall{p26}`;
        end;

        return p26;
    end;

    u24.WalkTrove:Connect(RunService.Heartbeat, function() -- Line: 219
        -- upvalues: u24 (copy), u4 (ref), u5 (ref), u6 (ref), u25 (copy), u2 (ref), u3 (ref)
        if u24.Ball == nil then
            return;
        end;

        if u24.Ball.Hold == nil then
            return;
        end;

        if u4 == nil then
            return;
        end;

        if u4:FindFirstChild("Values") == nil then
            return;
        end;

        u24:UpdateReceive();
        u24.Movement.CustomW:AdjustSpeed(u5.WalkSpeed / 14);
        u24.Movement.CustomWBack:AdjustSpeed(u5.WalkSpeed / 24);
        u24.Movement.CustomR:AdjustSpeed(u5.WalkSpeed / 32);

        if u4.Values.Goalie.Value and u4.Values.IsInPenalty.Value then
            if u24.Movement.Hold.IsPlaying == false then
                u24.Movement.Hold.Priority = Enum.AnimationPriority.Action2;
                u24.Movement.Hold:Play();
                u24.Ball.Hold.Priority = Enum.AnimationPriority.Action2;
                u24.Ball.Hold:Play();
            end;
        else
            u24.Movement.Hold:Stop();
            u24.Ball.Hold:Stop();
        end;

        if u4.Values.HasBall.Value then
            if u5.MoveDirection.Magnitude > 0 then
                u24.Ball.Idle:Stop();

                if u24.Ball.Walk.IsPlaying == false then
                    u24.Ball.Walk.Priority = Enum.AnimationPriority.Action;
                    u24.Ball.Walk:Play();
                end;
            else
                u24.Ball.Walk:Stop();

                if u24.Ball.Idle.IsPlaying == false then
                    u24.Ball.Idle.Priority = Enum.AnimationPriority.Action;
                    u24.Ball.Idle:Play();
                end;
            end;
        else
            u24.Movement.Hold:Stop();
            u24.Ball.Hold:Stop();
        end;

        local v27 = nil;
        local v28 = u6.CFrame:VectorToObjectSpace(u5.MoveDirection).Z > 0.1 and "CustomWBack" or "CustomW";

        if u5.MoveDirection.Magnitude > 0 then
            if u25.Value == "Miro" then
                if u24.StatesController.States.Running then
                    v28 = u4.Values.HasBall.Value and u24.Movement.OnBallMiroCustomR and "OnBallMiroCustomR" or "MiroCustomR";
                    v27 = "Walk";
                else
                    v28 = u4.Values.HasBall.Value and u24.Movement.OnBallMiroCustomW and "OnBallMiroCustomW" or "MiroCustomW";
                    v27 = "Walk";
                end;
            elseif u24.StatesController.States.Running then
                v28 = u4.Values.HasBall.Value and u24.Movement.OnBallCustomR and "OnBallCustomR" or "CustomR";
                v27 = "Walk";
            else
                if u4.Values.HasBall.Value and u24.Movement[`OnBall{v28}`] then
                    v28 = `OnBall{v28}`;
                end;

                v27 = "Walk";
            end;
        elseif u4.Values.Goalie.Value and u4.Values.IsInPenalty.Value then
            if u4.Values.HasBall.Value and u24.Movement.OnBallGoalieIdle then
                v28 = "OnBallGoalieIdle";
            else
                v28 = "GoalieIdle";
            end;
        elseif u25.Value == "Miro" then
            if u4.Values.HasBall.Value then
                v28 = u4.Values.HasBall.Value and u24.Movement.OnBallMiroBallIdle and "OnBallMiroBallIdle" or "MiroBallIdle";
                v27 = "MiroBallIdle";
            else
                v28 = u4.Values.HasBall.Value and u24.Movement.OnBallMiroIdle and "OnBallMiroIdle" or "MiroIdle";
                v27 = "Idle";
            end;
        else
            v28 = u4.Values.HasBall.Value and u24.Movement.OnBallIdle and "OnBallIdle" or "Idle";
            v27 = "Idle";
        end;

        for _, v in u2 do
            if u24.Movement[v] then
                if v == v28 then
                    if not u24.Movement[v].IsPlaying then
                        u24.Movement[v]:Play();
                    end;
                elseif u24.Movement[v].IsPlaying then
                    u24.Movement[v]:Stop();
                end;
            end;
        end;

        for _, v in u3 do
            if u24.Ball[v] then
                if v == v27 and not u24.StopBallMovementAnims then
                    if not u24.Ball[v].IsPlaying then
                        u24.Ball[v]:Play();
                        u24.Ball[v].Priority = Enum.AnimationPriority.Movement;
                    end;
                elseif u24.Ball[v].IsPlaying then
                    u24.Ball[v]:Stop();
                end;
            end;
        end;
    end);
end;

function v8.GetTrack(p29: table, p30: string, p31: string) -- Line: 359
    return p29[p30][p31];
end;

function v8.GetBallTrack(p32: table, p33: string) -- Line: 363
    return p32.Ball[p33];
end;

function v8.LoadAnimations(p34) -- Line: 367
    -- upvalues: u5 (ref), u6 (ref), u4 (ref), Animations (copy), ReplicatedStorage (copy), LocalPlayer (copy), u1 (copy), CamAnimations (copy)
    if not (u5 and (u6 and u4)) then
        return;
    end;

    p34:StopAnims();

    if p34.WalkTrove then
        p34.WalkTrove:Destroy();
        p34.WalkTrove = nil;
    end;

    local v35 = deepCopy(Animations);
    local v36 = deepCopy(require(ReplicatedStorage.Assets.BallAnimations));

    for i in v35 do
        for _, v in p34[i] or {} do
            v:Stop(0);
            v:Destroy();
        end;
    end;

    for _, v in p34.Ball or {} do
        v:Stop(0);
        v:Destroy();
    end;

    local PlayerStats = LocalPlayer:FindFirstChild("PlayerStats");
    local v37;

    if PlayerStats then
        v37 = PlayerStats:FindFirstChild("Style");
    else
        v37 = PlayerStats;
    end;

    if PlayerStats then
        PlayerStats = PlayerStats:FindFirstChild("InAwakening");
    end;

    local v38;

    if v37 then
        v38 = u1[v37.Value];
    else
        v38 = v37;
    end;

    if v37 and v38 then
        if v38.Character then
            for i, v in v38.Character do
                if type(v) == "table" then
                    local v39 = i;

                    for i2, v2 in v do
                        v35[v39][i2] = v2;
                    end;
                else
                    v35[i] = v;
                end;
            end;
        end;

        if v38.Ball then
            for i, v in v38.Ball do
                v36[i] = v;
            end;
        end;

        if v38.Awakening and (PlayerStats and PlayerStats.Value) then
            local Awakening = v38.Awakening;

            if Awakening.Character then
                for i, v in Awakening.Character do
                    if type(v) == "table" then
                        local v40 = i;

                        for i2, v2 in v do
                            v35[v40][i2] = v2;
                        end;
                    else
                        v35[i] = v;
                    end;
                end;
            end;

            if Awakening.Ball then
                for i, v in Awakening.Ball do
                    v36[i] = v;
                end;
            end;
        end;
    end;

    for i, v in v35 do
        if i ~= "Awakening" then
            if p34[i] then
                table.clear(p34[i]);
            end;

            p34[i] = {};
            local v41 = i;

            for i2, v2 in pairs(v) do
                if script:FindFirstChild(i2) then
                    script:FindFirstChild(i2):Destroy();
                end;

                local Animation = Instance.new("Animation");
                Animation.Parent = script;
                Animation.Name = i2;
                Animation.AnimationId = v2;
                task.spawn(function() -- Line: 463
                end);
                p34[v41][i2] = u5:LoadAnimation(Animation);
                local v42 = v38 and v38.Looped and v38.Looped.Character;

                if v42 then
                    v42 = v42[v41];
                end;

                if v42 and v42[i2] ~= nil then
                    p34[v41][i2].Looped = v42[i2];
                end;

                if v41 == "Movement" then
                    p34[v41][i2].Priority = Enum.AnimationPriority.Movement;
                else
                    p34[v41][i2].Priority = Enum.AnimationPriority.Action2;
                end;
            end;
        end;
    end;

    for i, v in pairs(CamAnimations) do
        if ReplicatedStorage.Assets.CamAnimations:FindFirstChild(i) then
            ReplicatedStorage.Assets.CamAnimations:FindFirstChild(i):Destroy();
        end;

        local Animation = Instance.new("Animation");
        Animation.Parent = ReplicatedStorage.Assets.CamAnimations;
        Animation.Name = i;
        Animation.AnimationId = v;
        task.spawn(function() -- Line: 492
        end);
    end;

    if p34.Ball then
        table.clear(p34.Ball);
    end;

    local Animator = LocalPlayer.Character:WaitForChild("PlrFootball"):WaitForChild("BallAnims"):WaitForChild("AnimationController"):WaitForChild("Animator");

    for i, v in v36 do
        if ReplicatedStorage.Assets.Animations:FindFirstChild(i) then
            ReplicatedStorage.Assets.Animations:FindFirstChild(i):Destroy();
        end;

        local Animation = Instance.new("Animation");
        Animation.Parent = ReplicatedStorage.Assets.Animations;
        Animation.Name = i;
        Animation.AnimationId = v;
        task.spawn(function() -- Line: 517
        end);
        p34.Ball[i] = Animator:LoadAnimation(Animation);
        local v43 = v38 and v38.Looped and v38.Looped.Ball;

        if v43 and v43[i] ~= nil then
            p34.Ball[i].Looped = v43[i];
        end;

        p34.Ball[i].Priority = Enum.AnimationPriority.Action2;
    end;
end;

function v8.ResetChecks(u44) -- Line: 530
    -- upvalues: Trove (copy), u5 (ref), u6 (ref), u4 (ref)
    if u44.Reset then
        u44.Reset:Destroy();
    end;

    u44.Reset = Trove.new();
    u44.Reset:Connect(u5.StateChanged, function(p45, p46) -- Line: 534
        -- upvalues: u6 (ref), u4 (ref), u44 (copy)
        if u6 == nil then
            return;
        end;

        if u6.Anchored then
            return;
        end;

        if u4:WaitForChild("IsRagdoll").Value then
            return;
        end;

        if p46 == Enum.HumanoidStateType.Jumping then
            u44.MM.Fall:Stop();
            u44.MM.Jump.Priority = Enum.AnimationPriority.Action;
            u44.MM.Jump:Play();

            return;
        end;

        if p46 ~= Enum.HumanoidStateType.Landed then
            if p46 == Enum.HumanoidStateType.Freefall then
                u44.MM.Fall.Priority = Enum.AnimationPriority.Action;
                u44.MM.Fall:Play();
            end;

            return;
        end;

        u44.MM.Fall:Stop();
        u44.MM.Land.Priority = Enum.AnimationPriority.Action;
        u44.MM.Land:Play();
        u44.MM.Land:AdjustSpeed(1.5);
    end);
end;

function v8.KnitStart(u47) -- Line: 554
    -- upvalues: KnitClient (copy), Observers (copy), LocalPlayer (copy), u4 (ref), u5 (ref), u6 (ref), AnimationEffects (copy), Trove (copy)
    u47.Ball = {};
    u47.EC = KnitClient.GetController("EmoteController");
    u47.StatesController = require(script.Parent.StatesController);
    u47.Trove:Connect(KnitClient.GetService("BallService").ReceivedBall, function(p48, p49, p50) -- Line: 559
        -- upvalues: u47 (copy)
        u47:ReceiveBall(p48, p49, p50);
    end);
    Observers.observeCharacter(LocalPlayer, function(p51, p52) -- Line: 563
        -- upvalues: u4 (ref), u5 (ref), u6 (ref), u47 (copy)
        u4 = p52;
        u5 = u4:WaitForChild("Humanoid");
        u6 = u4:WaitForChild("HumanoidRootPart");
        u4:WaitForChild("PlrFootball"):WaitForChild("BallAnims"):WaitForChild("AnimationController"):WaitForChild("Animator");
        u47:LoadAnimations();
        u47:ResetChecks();
        u47:WalkAnimations();
    end);
    task.spawn(function() -- Line: 575
        -- upvalues: LocalPlayer (ref), u47 (copy)
        LocalPlayer:WaitForChild("PlayerStats"):WaitForChild("Style").Changed:Connect(function(p53) -- Line: 576
            -- upvalues: u47 (ref)
            u47:LoadAnimations();
            u47:ResetChecks();
            u47:WalkAnimations();
        end);
    end);
    task.spawn(function() -- Line: 583
        -- upvalues: LocalPlayer (ref), u47 (copy)
        LocalPlayer:WaitForChild("PlayerStats"):WaitForChild("InAwakening").Changed:Connect(function() -- Line: 584
            -- upvalues: u47 (ref)
            u47:LoadAnimations();
            u47:ResetChecks();
            u47:WalkAnimations();
        end);
    end);
    Observers.observeCharacters(function(p54, p55) -- Line: 591
        -- upvalues: AnimationEffects (ref), Trove (ref)
        local Humanoid = p55:WaitForChild("Humanoid", 900);
        Humanoid:WaitForChild("Animator", 900).AnimationPlayed:Connect(function(p56: userdata) -- Line: 594
            -- upvalues: AnimationEffects (ref), Trove (ref), Humanoid (copy)
            local AnimationId = p56.Animation.AnimationId;

            if AnimationEffects[AnimationId] then
                local u57 = Trove.new();
                u57:Add(AnimationEffects[AnimationId](Humanoid, p56));
                p56.Stopped:Once(function() -- Line: 599
                    -- upvalues: u57 (copy)
                    u57:Destroy();
                end);
            end;
        end);

        for _, v in AnimationEffects.global do
            v(Humanoid);
        end;
    end);
end;

function v8.KnitInit(p58) -- Line: 612
    -- upvalues: Trove (copy)
    p58.Trove = Trove.new();
end;

return KnitClient.CreateController(v8);