  

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
local u1 = nil;
local u2 = nil;

local function offsetY(p3, p4: number) -- Line: 19
    return UDim2.new(p3.X.Scale, p3.X.Offset, p3.Y.Scale + p4, p3.Y.Offset);
end;

return function(p5: userdata, p6: number, p7: number) -- Line: 23
    -- upvalues: u1 (ref), u2 (ref), TweenService (copy), Debris (copy), RunService (copy)
    local BarouMVPCutscene = p5:FindFirstChild("BarouMVPCutscene");

    if not BarouMVPCutscene then
        warn("BarouMVPCutscene frame missing under MVPCutsceneGoal");

        return;
    end;

    local GoalText = BarouMVPCutscene.GoalText;
    local GoalDetail = BarouMVPCutscene.GoalDetail;
    local GoalDarkness = BarouMVPCutscene.GoalDarkness;
    local GoalGlow = BarouMVPCutscene.GoalGlow;
    local ScoreDarkness = BarouMVPCutscene.ScoreDarkness;
    local Separator = BarouMVPCutscene.Separator;
    local Score1Frame = Separator.Score1Frame;
    local Score2Frame = Separator.Score2Frame;
    local CurrentScore = Score1Frame.CurrentScore;
    local NewScore = Score1Frame.NewScore;
    local CurrentScore2 = Score2Frame.CurrentScore;
    local NewScore2 = Score2Frame.NewScore;

    if u1 == nil then
        u1 = {
            goalText = GoalText.Position,
            goalDetail = GoalDetail.Position,
            goalDarkness = GoalDarkness.Position,
            goalGlow = GoalGlow.Position,
            separator = Separator.Position,
            scoreDarkness = ScoreDarkness.Position
        };
    end;

    if u2 == nil then
        u2 = {
            goalText = GoalText.ImageTransparency,
            goalDetail = GoalDetail.ImageTransparency,
            goalDarkness = GoalDarkness.ImageTransparency,
            goalGlow = GoalGlow.ImageTransparency
        };
    end;

    local goalText = u1.goalText;
    local goalDetail = u1.goalDetail;
    local goalDarkness = u1.goalDarkness;
    local goalGlow = u1.goalGlow;
    local separator = u1.separator;
    local scoreDarkness = u1.scoreDarkness;
    local UDim2_new_ret = UDim2.new(goalText.X.Scale, goalText.X.Offset, goalText.Y.Scale + -1.05, goalText.Y.Offset);
    local UDim2_new_ret2 = UDim2.new(goalDetail.X.Scale, goalDetail.X.Offset, goalDetail.Y.Scale + -1.05, goalDetail.Y.Offset);
    local UDim2_new_ret3 = UDim2.new(goalDarkness.X.Scale, goalDarkness.X.Offset, goalDarkness.Y.Scale + -1.05, goalDarkness.Y.Offset);
    local UDim2_new_ret4 = UDim2.new(goalGlow.X.Scale, goalGlow.X.Offset, goalGlow.Y.Scale + -1.05, goalGlow.Y.Offset);
    local UDim2_new_ret5 = UDim2.new(separator.X.Scale, separator.X.Offset, separator.Y.Scale + 0.75, separator.Y.Offset);
    local UDim2_new_ret6 = UDim2.new(scoreDarkness.X.Scale, scoreDarkness.X.Offset, scoreDarkness.Y.Scale + 0.75, scoreDarkness.Y.Offset);
    local UDim2_fromScale_ret = UDim2.fromScale(0.5, 0.5);
    local UDim2_fromScale_ret2 = UDim2.fromScale(0.5, -0.5);
    local UDim2_fromScale_ret3 = UDim2.fromScale(0.5, 1.5);
    local ShineEffect = GoalText:FindFirstChild("ShineEffect");

    if ShineEffect then
        ShineEffect:Destroy();
    end;

    for _, child in BarouMVPCutscene:GetChildren() do
        if child.Name == "GoalAfterimage" or child.Name == "GoalShadow" then
            child:Destroy();
        end;
    end;

    for _, child in Separator:GetChildren() do
        if child.Name == "Score1NewShadow" or child.Name == "Score2NewShadow" then
            child:Destroy();
        end;
    end;

    local u8 = tonumber(p6) or 0;
    local u9 = tonumber(p7) or 0;
    CurrentScore.Text = "0";
    CurrentScore.Position = UDim2_fromScale_ret;
    NewScore.Position = UDim2_fromScale_ret2;
    CurrentScore2.Text = "0";
    CurrentScore2.Position = UDim2_fromScale_ret;
    NewScore2.Position = UDim2_fromScale_ret2;
    GoalText.Position = UDim2_new_ret;
    GoalText.ImageTransparency = 1;
    GoalDetail.Position = UDim2_new_ret2;
    GoalDetail.ImageTransparency = u2.goalDetail;
    GoalDarkness.Position = UDim2_new_ret3;
    GoalDarkness.ImageTransparency = u2.goalDarkness;
    GoalGlow.Position = UDim2_new_ret4;
    GoalGlow.ImageTransparency = u2.goalGlow;
    Separator.Position = UDim2_new_ret5;
    ScoreDarkness.Position = UDim2_new_ret6;
    local Frame = p5:FindFirstChild("Frame");
    local v10;

    if Frame then
        v10 = Frame.Visible;
    else
        v10 = Frame;
    end;

    if Frame then
        Frame.Visible = false;
    end;

    local Visible = BarouMVPCutscene.Visible;
    BarouMVPCutscene.Visible = true;
    p5.Enabled = true;
    local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v11 = TweenService:Create(Separator, TweenInfo_new_ret, {
        Position = separator
    });
    TweenService:Create(ScoreDarkness, TweenInfo_new_ret, {
        Position = scoreDarkness
    }):Play();
    v11:Play();
    v11.Completed:Wait();
    task.wait(0.35);
    local TweenInfo_new_ret2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v12 = TweenService:Create(GoalText, TweenInfo_new_ret2, {
        ImageTransparency = 0,
        Position = goalText
    });
    TweenService:Create(GoalDetail, TweenInfo_new_ret2, {
        Position = goalDetail
    }):Play();
    TweenService:Create(GoalDarkness, TweenInfo_new_ret2, {
        Position = goalDarkness
    }):Play();
    TweenService:Create(GoalGlow, TweenInfo_new_ret2, {
        Position = goalGlow
    }):Play();
    v12:Play();
    local u13 = true;
    task.spawn(function() -- Line: 143
        -- upvalues: u13 (ref), GoalText (copy), BarouMVPCutscene (copy), TweenService (ref), Debris (ref)
        while u13 do
            local v14 = GoalText:Clone();
            v14.Name = "GoalAfterimage";
            v14:ClearAllChildren();
            v14.Position = GoalText.Position;
            v14.ImageTransparency = math.min(1, GoalText.ImageTransparency + 0.3);
            v14.ZIndex = GoalText.ZIndex - 1;
            v14.Parent = BarouMVPCutscene;
            TweenService:Create(v14, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                ImageTransparency = 1
            }):Play();
            Debris:AddItem(v14, 0.3);
            task.wait(0.03);
        end;
    end);
    v12.Completed:Connect(function() -- Line: 159
        -- upvalues: u13 (ref)
        u13 = false;
    end);

    local function flickScore(p15, p16, p17) -- Line: 165
        -- upvalues: UDim2_fromScale_ret2 (copy), TweenService (ref), UDim2_fromScale_ret (copy), UDim2_fromScale_ret3 (copy)
        if p17 <= 0 then
            return p15;
        end;

        local TweenInfo_new_ret3 = TweenInfo.new(0.4 / p17, Enum.EasingStyle.Linear);

        for i = 1, p17 do
            p16.Text = tostring(i);
            p16.Position = UDim2_fromScale_ret2;
            TweenService:Create(p16, TweenInfo_new_ret3, {
                Position = UDim2_fromScale_ret
            }):Play();
            local v18 = TweenService:Create(p15, TweenInfo_new_ret3, {
                Position = UDim2_fromScale_ret3
            });
            v18:Play();
            v18.Completed:Wait();
            local _ = i;
            local v19 = p15;
            p15 = p16;
            p16 = v19;
        end;

        return p15;
    end;

    local u20 = CurrentScore;
    local u21 = CurrentScore2;
    local u22 = 2;
    task.spawn(function() -- Line: 184
        -- upvalues: u20 (ref), flickScore (copy), CurrentScore (copy), NewScore (copy), u8 (copy), u22 (ref)
        u20 = flickScore(CurrentScore, NewScore, u8);
        u22 = u22 - 1;
    end);
    task.spawn(function() -- Line: 188
        -- upvalues: u21 (ref), flickScore (copy), CurrentScore2 (copy), NewScore2 (copy), u9 (copy), u22 (ref)
        u21 = flickScore(CurrentScore2, NewScore2, u9);
        u22 = u22 - 1;
    end);

    while u22 > 0 do
        RunService.Heartbeat:Wait();
    end;

    local AbsolutePosition = Separator.AbsolutePosition;
    local AbsoluteSize = Separator.AbsoluteSize;

    local function spawnScoreShadow(p23, p24, p25) -- Line: 198
        -- upvalues: AbsolutePosition (copy), AbsoluteSize (copy), Separator (copy), TweenService (ref), Debris (ref)
        local AbsoluteSize2 = p23.AbsoluteSize;
        local v26 = (p23.AbsolutePosition + AbsoluteSize2 * 0.5 - AbsolutePosition) / AbsoluteSize;
        local v27 = AbsoluteSize2 / AbsoluteSize;
        local v28 = p23:Clone();
        v28.Name = p25;
        v28:ClearAllChildren();
        v28.AnchorPoint = Vector2.new(0.5, 0.5);
        v28.Position = UDim2.fromScale(v26.X, v26.Y);
        v28.Size = UDim2.fromScale(v27.X, v27.Y);
        v28.Text = p23.Text;
        v28.TextTransparency = 0;
        v28.ZIndex = p24.ZIndex - 1;
        v28.Parent = Separator;
        local UDim2_fromScale_ret4 = UDim2.fromScale(v27.X * 2.25, v27.Y * 2.25);
        local v29 = TweenService:Create(v28, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1,
            Size = UDim2_fromScale_ret4
        });
        v29:Play();
        Debris:AddItem(v28, 0.7);

        return v29;
    end;

    spawnScoreShadow(u20, Score1Frame, "Score1NewShadow");
    local v30 = spawnScoreShadow(u21, Score2Frame, "Score2NewShadow");
    local v31 = GoalText:Clone();
    v31.Name = "GoalShadow";
    v31:ClearAllChildren();
    v31.AnchorPoint = GoalText.AnchorPoint;
    v31.Position = GoalText.Position;
    v31.Size = GoalText.Size;
    v31.ImageTransparency = 0;
    v31.ZIndex = GoalText.ZIndex - 1;
    v31.Parent = BarouMVPCutscene;
    local UDim2_new_ret7 = UDim2.new(GoalText.Size.X.Scale * 1.5, GoalText.Size.X.Offset * 1.5, GoalText.Size.Y.Scale * 1.5, GoalText.Size.Y.Offset * 1.5);
    TweenService:Create(v31, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 1,
        Size = UDim2_new_ret7
    }):Play();
    Debris:AddItem(v31, 0.7);
    v30.Completed:Wait();
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "ShineEffect";
    UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1));
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.35, 0),
        NumberSequenceKeypoint.new(0.5, 0.7),
        NumberSequenceKeypoint.new(0.65, 0),
        NumberSequenceKeypoint.new(1, 0)
    });
    UIGradient.Rotation = 75;
    UIGradient.Offset = Vector2.new(-1, 0);
    UIGradient.Enabled = true;
    UIGradient.Parent = GoalText;
    TweenService:Create(UIGradient, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Offset = Vector2.new(1, 0)
    }):Play();
    task.delay(0.2, function() -- Line: 271
        -- upvalues: TweenService (ref), UIGradient (copy)
        TweenService:Create(UIGradient, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Offset = Vector2.new(1, 0)
        }):Play();
    end);
    task.wait(0.15);
    local TweenInfo_new_ret3 = TweenInfo.new(1);
    TweenService:Create(GoalText, TweenInfo_new_ret3, {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(GoalDetail, TweenInfo_new_ret3, {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(GoalDarkness, TweenInfo_new_ret3, {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(GoalGlow, TweenInfo_new_ret3, {
        ImageTransparency = 1
    }):Play();
    task.wait(0.55);
    UIGradient:Destroy();
    local TweenInfo_new_ret4 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
    TweenService:Create(GoalText, TweenInfo_new_ret4, {
        Position = UDim2_new_ret
    }):Play();
    TweenService:Create(GoalDetail, TweenInfo_new_ret4, {
        Position = UDim2_new_ret2
    }):Play();
    TweenService:Create(GoalDarkness, TweenInfo_new_ret4, {
        Position = UDim2_new_ret3
    }):Play();
    TweenService:Create(GoalGlow, TweenInfo_new_ret4, {
        Position = UDim2_new_ret4
    }):Play();
    local v32 = TweenService:Create(Separator, TweenInfo_new_ret4, {
        Position = UDim2_new_ret5
    });
    TweenService:Create(ScoreDarkness, TweenInfo_new_ret4, {
        Position = UDim2_new_ret6
    }):Play();
    v32:Play();
    TweenService:Create(u20, TweenInfo.new(0.4), {
        TextTransparency = 1
    }):Play();
    TweenService:Create(u21, TweenInfo.new(0.4), {
        TextTransparency = 1
    }):Play();
    v32.Completed:Wait();
    p5.Enabled = false;
    GoalText.Position = goalText;
    GoalText.ImageTransparency = u2.goalText;
    GoalDetail.Position = goalDetail;
    GoalDetail.ImageTransparency = u2.goalDetail;
    GoalDarkness.Position = goalDarkness;
    GoalDarkness.ImageTransparency = u2.goalDarkness;
    GoalGlow.Position = goalGlow;
    GoalGlow.ImageTransparency = u2.goalGlow;
    Separator.Position = separator;
    ScoreDarkness.Position = scoreDarkness;
    CurrentScore.Position = UDim2_fromScale_ret;
    NewScore.Position = UDim2_fromScale_ret2;
    CurrentScore2.Position = UDim2_fromScale_ret;
    NewScore2.Position = UDim2_fromScale_ret2;
    CurrentScore.TextTransparency = 0;
    NewScore.TextTransparency = 0;
    CurrentScore2.TextTransparency = 0;
    NewScore2.TextTransparency = 0;
    BarouMVPCutscene.Visible = Visible;

    if Frame then
        Frame.Visible = v10;
    end;
end;