  

 

local u1 = {};
u1.__index = u1;

local function Lerp(p2, p3, p4) -- Line: 4
    return p2 + (p3 - p2) * p4;
end;

function u1.new(p5, p6) -- Line: 8
    -- upvalues: u1 (copy)
    local v7 = setmetatable({}, u1);
    v7.Character = p5.Parent;
    v7.Humanoid = p5;
    v7.Animator = p5:WaitForChild("Animator");
    v7.Weighted = false;
    v7.Animations = p6;
    v7.State = Enum.HumanoidStateType.Running;
    v7.Speed = 0;
    v7.RunThreshold = 20;
    v7.Jumped = false;
    v7.Last = {
        Name = nil,
        Animation = nil,
        Track = nil,
        ID = nil,
        Interpolation = 0.1
    };
    v7.Current = {
        Name = nil,
        Animation = nil,
        Track = nil,
        ID = nil,
        Interpolation = 0.1
    };

    return v7;
end;

function u1.Get(p8, p9) -- Line: 44
    for _, descendant in pairs(p8.Animations:GetDescendants()) do
        if descendant:GetAttribute("State") == p9 and descendant:GetAttribute("Enabled") and (p8.Current.Name ~= p9 or p8.Current.ID ~= descendant.AnimationId and p8.Current.Animation == descendant or (p8.Current.Animation ~= descendant and descendant:GetAttribute("StatePriority") > (p8.Current.Animation:GetAttribute("StatePriority") or 0) or not p8.Current.Animation:GetAttribute("Enabled"))) then
            return descendant;
        end;
    end;
end;

function u1.Play(p10, p11, p12, p13, p14) -- Line: 54
    for _, descendant in pairs(p10.Animations:GetDescendants()) do
        if descendant:GetAttribute("State") == p11 and descendant:GetAttribute("Enabled") and (p10.Current.Name ~= p11 or p10.Current.ID ~= descendant.AnimationId and p10.Current.Animation == descendant or (p10.Current.Animation ~= descendant and descendant:GetAttribute("StatePriority") > (p10.Current.Animation:GetAttribute("StatePriority") or 0) or not p10.Current.Animation:GetAttribute("Enabled"))) then
            p10:Stop(p12);
            local v15 = p10.Animator:LoadAnimation(descendant);
            v15:Play((p12 or 1) * (descendant:GetAttribute("Transition") or 1), (p13 or 1) * (descendant:GetAttribute("Weight") or 1), (p14 or 1) * (descendant:GetAttribute("Speed") or 1));
            p10.Current.Name = p11;
            p10.Current.Animation = descendant;
            p10.Current.Track = v15;
            p10.Current.ID = descendant.AnimationId;
            p10.Current.Interpolation = descendant:GetAttribute("Interpolation") or 0.1;
            p10.Current.Transition = (p12 or 1) * (descendant:GetAttribute("Transition") or 1);
            p10.Current.Weight = (p13 or 1) * (descendant:GetAttribute("Weight") or 1);
            p10.Current.Speed = (p14 or 1) * (descendant:GetAttribute("Speed") or 1);
            p10.Current.StatePriority = descendant:GetAttribute("StatePriority") or 1;
        end;
    end;
end;

function u1.Stop(p16, p17) -- Line: 77
    if p16.Current.Name then
        if p16.Weighted then
            if p16.Last.Track then
                p16.Last.Track:Stop(p16.Last.Transition or 0.25);
            end;
        elseif p16.Current.Track then
            p16.Current.Track:Stop(p16.Current.Transition or 0.25);
        end;

        for i, v in pairs(p16.Current) do
            p16.Last[i] = v;
            p16.Current[i] = nil;
        end;
    end;
end;

function u1.Update(p18) -- Line: 95
    p18.State = p18.Humanoid:GetState();
    local v19 = p18.RootPart or p18.Humanoid.RootPart;

    if v19 then
        p18.Speed = (v19.Velocity * (p18.State == Enum.HumanoidStateType.Climbing and Vector3.new(0, 1, 0) or Vector3.new(1, 0, 1))).Magnitude;
    else
        p18.Speed = 0;
    end;

    if p18.State == Enum.HumanoidStateType.Jumping or p18.State == Enum.HumanoidStateType.Freefall then
        if p18.Jumped then
            if p18.Jumped and (p18.Current.Name ~= "Jump" or not p18.Current.Track.IsPlaying) then
                p18:Play("Fall");
            end;
        else
            p18.Jumped = true;
            p18:Play("Jump");
        end;
    else
        p18.Jumped = false;
    end;

    if p18.State == Enum.HumanoidStateType.Landed and (p18.Current.Name ~= "Landed" or not p18.Current.Track.IsPlaying) then
        p18:Play("Landed");
    end;

    if p18.State == Enum.HumanoidStateType.Running or p18.State == Enum.HumanoidStateType.RunningNoPhysics then
        if p18.Speed > 0.01 then
            if p18.Humanoid.WalkSpeed > p18.RunThreshold then
                p18:Play(p18.Animations:FindFirstChild("Run_Back") and (p18.Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) and (p18.Humanoid.RootPart and (p18.Humanoid.MoveDirection - -p18.Humanoid.RootPart.CFrame.LookVector).Magnitude <= 1)) and "Run_Back" or "Run");
            else
                p18:Play("Walk");
            end;

            p18.Current.Track:AdjustSpeed(p18.Speed / 14.5 * p18.Current.Speed);
        elseif p18.Current.Name ~= "Landed" or not p18.Current.Track.IsPlaying then
            p18:Play("Idle");
        end;
    end;

    if p18.State == Enum.HumanoidStateType.Climbing then
        p18:Play("Climb");
        p18.Current.Track:AdjustSpeed(p18.Current.Speed + p18.Speed / 14.5);
    end;

    if p18.State == Enum.HumanoidStateType.Seated then
        p18:Play("Sit");
    end;

    if p18.State == Enum.HumanoidStateType.Swimming then
        p18:Play("Walk");
    end;

    local v20 = p18.Character:FindFirstChildWhichIsA("Tool");

    if v20 and (v20:FindFirstChild("Handle") and not v20:GetAttribute("NoHoldAnim")) then
        if p18.Animations:FindFirstChild("Tool") and not p18.ToolTrack then
            p18.ToolTrack = p18.Animator:LoadAnimation(p18.Animations.Tool);
            p18.ToolTrack:Play(p18.Animations.Tool:GetAttribute("Transition"), p18.Animations.Tool:GetAttribute("Weight"), p18.Animations.Tool:GetAttribute("Speed"));
        end;
    elseif p18.ToolTrack then
        p18.ToolTrack:Stop(0.1);
        p18.ToolTrack = nil;
    end;

    if p18.Weighted then
        if p18.Current.Track and p18.Current.Track.Looped then
            local WeightCurrent = p18.Current.Track.WeightCurrent;
            p18.Current.Track:AdjustWeight(WeightCurrent + (1 - WeightCurrent) * 0.9, p18.Current.Interpolation);
        end;

        if p18.Last.Track and p18.Last.Track.Looped then
            p18.Last.Track:SetAttribute("EasingOut", true);

            if p18.Last.Track.IsPlaying then
                if p18.Last.Track.WeightCurrent <= 0.05 then
                    p18.Last.Track:Stop(0.25);
                else
                    local WeightCurrent = p18.Last.Track.WeightCurrent;
                    p18.Last.Track:AdjustWeight(WeightCurrent + (0.01 - WeightCurrent) * 0.9, p18.Last.Interpolation);
                end;
            end;
        end;

        if p18.Last.Track and (p18.Last.Track.IsPlaying and p18.Last.Track.Looped) then
            for _, v in pairs(p18.Animator:GetPlayingAnimationTracks()) do
                if v.Animation and not v.Animation:IsDescendantOf(p18.Animations) then
                    p18.Last.Track:Stop(0.25);

                    return;
                end;
            end;
        end;
    end;
end;

function u1.Destroy(p21) -- Line: 195
    if p21.Last.Track and p21.Last.Track.IsPlaying then
        p21.Last.Track:Stop(0);
    end;

    if p21.Current.Track and p21.Current.Track.IsPlaying then
        p21.Current.Track:Stop(0);
    end;

    setmetatable(p21, nil);
end;

return u1;