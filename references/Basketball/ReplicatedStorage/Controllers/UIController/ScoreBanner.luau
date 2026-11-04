 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Packages.Trove);
local InGame = LocalPlayer.PlayerGui:WaitForChild("InGame");
local ScoreBanner = InGame:WaitForChild("BG"):WaitForChild("ScoreBanner");
local ScoreBanner2 = ScoreBanner:WaitForChild("ScoreBanner");
local Contents = ScoreBanner2:WaitForChild("Contents");
local UIGradient = ScoreBanner2:WaitForChild("UIGradient");
local UIScale = ScoreBanner2:WaitForChild("UIScale");
local ScoreLabel = Contents.ScoringTeam.ScoreLabel;
local ScoreLabel2 = Contents.ScoredBy.ScoreLabel;
local TrophyFx = ScoreBanner2:WaitForChild("TrophyFx");
local Template = TrophyFx:WaitForChild("Template");
local Basketball = ScoreBanner:WaitForChild("Basketball");
Template.Visible = false;
local Vignette = ScoreBanner2:WaitForChild("Vignette");
local u1 = { " posterizes %s!", " puts %s on a poster!", " rises above %s for the slam!", " catches %s lacking at the rim!", " sends %s straight to the poster!", " destroys %s at the basket!" };
local u2 = { " knocks it down!", " splashes the jumper!", " drills the shot!", " cashes it in!", " hits nothing but net!", " drops it in!" };
local u3 = { " launches it from half court and hits!", " banks in the half-court heave!", " drains it from midcourt!", " buries the half-court shot!", " connects from way downtown!", " hits an unbelievable half-court shot!" };
local u4 = { " lays it in!", " glides in for the layup!", " gets the easy two!", " slips it off the glass!", " takes it strong to the basket!", " gets it to fall at the rim!" };
local v5 = Knit.CreateController({
    Name = "ScoreBanner"
});
local u6 = 0;
local u7 = 0;

local function StartContentsWobble() -- Line: 66
    -- upvalues: u6 (ref), Contents (copy), ScoreBanner (copy), TweenService (copy)
    u6 = u6 + 1;
    local u8 = u6;
    Contents.Rotation = 0;
    task.spawn(function() -- Line: 72
        -- upvalues: ScoreBanner (ref), u6 (ref), u8 (copy), TweenService (ref), Contents (ref)
        local v9 = 1;

        while ScoreBanner.Visible and u6 == u8 do
            local v10 = TweenService:Create(Contents, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Rotation = v9 * 2
            });
            v10:Play();
            v10.Completed:Wait();
            v9 = v9 * -1;
        end;
    end);
end;

local function StopContentsWobble() -- Line: 96
    -- upvalues: u6 (ref), TweenService (copy), Contents (copy)
    u6 = u6 + 1;
    TweenService:Create(Contents, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Rotation = 0
    }):Play();
end;

local function PlayBannerSlamShake() -- Line: 112
    -- upvalues: u7 (ref), Contents (copy)
    u7 = u7 + 1;
    local u11 = u7;
    local Position = Contents.Position;
    local u12 = { -8, 7, -5, 4, -2, 0 };
    task.spawn(function() -- Line: 127
        -- upvalues: u12 (copy), u7 (ref), u11 (copy), Contents (ref), Position (copy)
        for _, v in ipairs(u12) do
            if u7 ~= u11 then
                return;
            end;

            Contents.Position = UDim2.new(Position.X.Scale, Position.X.Offset + v, Position.Y.Scale, Position.Y.Offset);
            task.wait(0.025);
        end;

        Contents.Position = Position;
    end);
end;

local function playBasketballArc(p13: number) -- Line: 147
    -- upvalues: Basketball (copy), PlayBannerSlamShake (copy), TweenService (copy)
    local math_clamp_ret = math.clamp(p13 * 0.18, 0.45, 0.9);
    local math_clamp_ret2 = math.clamp(p13 * 0.035, 0.08, 0.18);
    local Vector2_new_ret = Vector2.new(-0.28, 0.78);
    local Vector2_new_ret2 = Vector2.new(0.5, -0.12);
    local Vector2_new_ret3 = Vector2.new(1.25, 0.72);
    Basketball.Position = UDim2.fromScale(Vector2_new_ret.X, Vector2_new_ret.Y);
    Basketball.Visible = true;
    Basketball.ImageTransparency = 0;
    Basketball.Rotation = 0;
    local u14 = Basketball:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    u14.Parent = Basketball;
    u14.Scale = 0.75;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 0;
    local u15 = false;
    local u19 = NumberValue.Changed:Connect(function(p16) -- Line: 170
        -- upvalues: Vector2_new_ret (copy), Vector2_new_ret2 (copy), Vector2_new_ret3 (copy), Basketball (ref), u15 (ref), PlayBannerSlamShake (ref), u14 (copy)
        local v17 = 1 - p16;
        Basketball.Position = UDim2.fromScale(v17 * v17 * Vector2_new_ret.X + 2 * v17 * p16 * Vector2_new_ret2.X + p16 * p16 * Vector2_new_ret3.X, v17 * v17 * Vector2_new_ret.Y + 2 * v17 * p16 * Vector2_new_ret2.Y + p16 * p16 * Vector2_new_ret3.Y);
        Basketball.Rotation = 520 * p16;
        local v18 = math.sin(p16 * 3.141592653589793) * 0.75 + 0.75;

        if p16 > 0.8 and not u15 then
            u15 = true;
            PlayBannerSlamShake();
        end;

        u14.Scale = v18;
        u14.Scale = v18;
    end);
    TweenService:Create(NumberValue, TweenInfo.new(math_clamp_ret, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        Value = 1
    }):Play();
    task.delay(math_clamp_ret, function() -- Line: 198
        -- upvalues: u19 (ref), NumberValue (copy), TweenService (ref), Basketball (ref), math_clamp_ret2 (copy), u14 (copy)
        if u19 then
            u19:Disconnect();
        end;

        NumberValue:Destroy();
        local v20 = TweenService:Create(Basketball, TweenInfo.new(math_clamp_ret2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        });
        v20:Play();
        v20.Completed:Once(function() -- Line: 209
            -- upvalues: Basketball (ref), u14 (ref)
            Basketball.Visible = false;
            Basketball.ImageTransparency = 1;
            Basketball.Rotation = 0;
            u14.Scale = 1;
        end);
    end);
end;

local function popScoringTeamText() -- Line: 218
    -- upvalues: ScoreLabel (copy), TweenService (copy)
    local u21 = ScoreLabel:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");
    u21.Parent = ScoreLabel;
    u21.Scale = 0.75;
    TweenService:Create(u21, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1.4
    }):Play();
    task.delay(0.14, function() -- Line: 229
        -- upvalues: TweenService (ref), u21 (copy)
        TweenService:Create(u21, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
    end);
end;

local function setScoreBannerReveal(p22: number) -- Line: 238
    -- upvalues: ScoreBanner2 (copy), UIGradient (copy)
    local math_clamp_ret = math.clamp(p22, 0, 1);

    if math_clamp_ret <= 0 then
        ScoreBanner2.GroupTransparency = 1;
        UIGradient.Transparency = NumberSequence.new(1);

        return;
    end;

    ScoreBanner2.GroupTransparency = 0;
    local v23 = math_clamp_ret * 1.18;
    local math_clamp_ret2 = math.clamp(v23 - 0.18, 0, 1);
    local math_clamp_ret3 = math.clamp(v23, 0, 1);

    if math_clamp_ret2 >= 1 then
        UIGradient.Transparency = NumberSequence.new(0);

        return;
    end;

    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(math_clamp_ret2, 0),
        NumberSequenceKeypoint.new(math_clamp_ret3, 1),
        NumberSequenceKeypoint.new(1, 1)
    });
end;

local function setScoreBannerRevealClose(p24) -- Line: 268
    -- upvalues: ScoreBanner2 (copy), UIGradient (copy)
    local math_clamp_ret = math.clamp(p24, 0, 1);

    if math_clamp_ret <= 0 then
        ScoreBanner2.GroupTransparency = 1;
        UIGradient.Transparency = NumberSequence.new(1);

        return;
    end;

    ScoreBanner2.GroupTransparency = 0;
    local v25 = math_clamp_ret * 0.5;
    local v26 = 0.5 - v25;
    local v27 = 0.5 + v25;
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(math.max(0, v26 - 0.16), 1),
        NumberSequenceKeypoint.new(v26, 0),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(v27, 0),
        NumberSequenceKeypoint.new(math.min(1, v27 + 0.16), 1),
        NumberSequenceKeypoint.new(1, 1)
    });
end;

local function spawnFallingTemplate(u28: userdata, p29: table?) -- Line: 300
    -- upvalues: TweenService (copy)
    local v30 = p29 or {};
    local Parent = u28.Parent;

    if Parent then
        local u31 = v30.Rotate ~= false;
        local u32 = v30.RandomScale ~= false;
        local u33 = v30.HorizontalJitter ~= false;
        local u34 = v30.SpawnInterval or 0.6;
        local u35 = v30.FallDuration or 3;
        local u36 = v30.Scale or 1;
        local u37 = v30.Reverse == true;
        u28.Visible = false;
        local u38 = true;
        local v39 = {
            Stop = function() -- Line: 317
                -- upvalues: u38 (ref)
                u38 = false;
            end
        };
        task.spawn(function() -- Line: 321
            -- upvalues: u38 (ref), Parent (copy), u33 (copy), u37 (copy), u28 (copy), u31 (copy), u32 (copy), u36 (copy), TweenService (ref), u35 (copy), u34 (copy)
            while u38 do
                local X = Parent.AbsoluteSize.X;
                local v40;

                if u33 then
                    local v41 = X * 0.3;
                    local v42 = X * 0.7;

                    if math.random() < 0.5 then
                        v40 = math.random() * v41;
                    else
                        v40 = v42 + math.random() * (X - v42);
                    end;
                else
                    v40 = X / 2;
                end;

                local v43, v44;

                if u37 then
                    v43 = Parent.AbsoluteSize.Y + u28.AbsoluteSize.Y / 2;
                    v44 = -u28.AbsoluteSize.Y / 2;
                else
                    v43 = -u28.AbsoluteSize.Y / 2;
                    v44 = Parent.AbsoluteSize.Y + u28.AbsoluteSize.Y / 2;
                end;

                local u45 = u28:Clone();
                u45.Visible = true;
                u45.Position = UDim2.new(0, v40, 0, v43);
                u45.AnchorPoint = Vector2.new(0.5, 0.5);
                u45.Rotation = u31 and math.random(-360, 360) or 0;
                u45.Parent = Parent;
                local v46 = u45:FindFirstChildOfClass("UIScale");

                if not v46 then
                    v46 = Instance.new("UIScale");
                    v46.Parent = u45;
                end;

                if u32 then
                    v46.Scale = u36 + math.random() * 0.4;
                else
                    v46.Scale = u36;
                end;

                local v47 = u31 and (math.random(60, 120) * (math.random(0, 1) == 0 and -1 or 1) or 0) or 0;

                if u33 then
                    v40 = v40 + math.random(-50, 50) or v40;
                end;

                local v48 = TweenService:Create(u45, TweenInfo.new(u35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0, v40, 0, v44),
                    Rotation = u45.Rotation + v47
                });
                v48:Play();
                v48.Completed:Once(function() -- Line: 376
                    -- upvalues: u45 (copy)
                    if u45 then
                        u45:Destroy();
                    end;
                end);
                task.wait(u34);
            end;
        end);

        return v39;
    end;
end;

local function playScoreTrophyFx(p49) -- Line: 389
    -- upvalues: TrophyFx (copy), Template (copy), spawnFallingTemplate (copy)
    TrophyFx.Visible = true;
    TrophyFx.GroupTransparency = 0;
    Template.ImageColor3 = p49;
    local u50 = spawnFallingTemplate(Template, {
        Reverse = true,
        SpawnInterval = 0.12,
        FallDuration = 1.6,
        Scale = 0.75,
        RandomScale = true,
        HorizontalJitter = true,
        Rotate = true
    });
    task.delay(2.2, function() -- Line: 404
        -- upvalues: u50 (copy)
        if u50 then
            u50.Stop();
        end;
    end);
    task.delay(3.8, function() -- Line: 410
        -- upvalues: TrophyFx (ref)
        TrophyFx.Visible = false;
    end);
end;

function v5.KnitInit(p51) -- Line: 415
end;

function v5.KnitStart(p52) -- Line: 419
    -- upvalues: Knit (copy), ScoreBanner (copy), Basketball (copy), Vignette (copy), ScoreBanner2 (copy), ScoreLabel (copy), InGame (copy), ScoreLabel2 (copy), u1 (copy), u3 (copy), u4 (copy), u2 (copy), playScoreTrophyFx (copy), playBasketballArc (copy), u6 (ref), Contents (copy), TweenService (copy), setScoreBannerReveal (copy), popScoringTeamText (copy), setScoreBannerRevealClose (copy), UIScale (copy), StopContentsWobble (copy)
    Knit.GetService("ScoreService").Scored:Connect(function(p53, p54) -- Line: 422
        -- upvalues: ScoreBanner (ref), Basketball (ref), Vignette (ref), ScoreBanner2 (ref), ScoreLabel (ref), InGame (ref), ScoreLabel2 (ref), u1 (ref), u3 (ref), u4 (ref), u2 (ref), playScoreTrophyFx (ref), playBasketballArc (ref), u6 (ref), Contents (ref), TweenService (ref), setScoreBannerReveal (ref), popScoringTeamText (ref), setScoreBannerRevealClose (ref), UIScale (ref), StopContentsWobble (ref)
        if p53.Team == game.Teams.Visitor then
            return;
        end;

        if not p54 then
            return;
        end;

        local Attribute = p53.Team:GetAttribute("Color");
        ScoreBanner.Visible = true;
        Basketball.Visible = false;
        Vignette.GroupColor3 = Attribute;
        ScoreBanner2.GroupTransparency = 1;
        ScoreBanner2.UIScale.Scale = 1;
        ScoreLabel.Text = string.format("<font color=\"#%s\">%s</font> SCORED!", Attribute:ToHex(), InGame.BG.Top[p53.Team.Name].TextLabel.Text);

        if p54.Posterizer then
            ScoreLabel2.Text = "<b>" .. p53.Name .. "</b>" .. string.format(u1[p54.RNG or 1], p54.Posterizer);
        else
            ScoreLabel2.Text = "<b>" .. p53.Name .. "</b>" .. (p54.HalfCourt and u3[p54.RNG or 1] or ((not p54.ThreePointer and p54.Layup and true or false) and u4[p54.RNG or 1] or u2[p54.RNG or 1]));
        end;

        playScoreTrophyFx(Attribute);
        playBasketballArc(3);
        u6 = u6 + 1;
        local u55 = u6;
        Contents.Rotation = 0;
        task.spawn(function() -- Line: 72
            -- upvalues: ScoreBanner (ref), u6 (ref), u55 (copy), TweenService (ref), Contents (ref)
            local v56 = 1;

            while ScoreBanner.Visible and u6 == u55 do
                local v57 = TweenService:Create(Contents, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Rotation = v56 * 2
                });
                v57:Play();
                v57.Completed:Wait();
                v56 = v56 * -1;
            end;
        end);
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0;
        NumberValue.Changed:Connect(function(p58) -- Line: 457
            -- upvalues: setScoreBannerReveal (ref)
            setScoreBannerReveal(p58);
        end);
        TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Value = 1
        }):Play();
        task.delay(0.18, function() -- Line: 471
            -- upvalues: popScoringTeamText (ref)
            popScoringTeamText();
        end);
        task.delay(3, function() -- Line: 475
            -- upvalues: setScoreBannerRevealClose (ref), TweenService (ref), UIScale (ref), StopContentsWobble (ref), NumberValue (copy), setScoreBannerReveal (ref), ScoreBanner (ref)
            local NumberValue2 = Instance.new("NumberValue");
            NumberValue2.Value = 1;
            NumberValue2.Changed:Connect(function(p59) -- Line: 479
                -- upvalues: setScoreBannerRevealClose (ref)
                setScoreBannerRevealClose(p59);
            end);
            local v60 = TweenService:Create(NumberValue2, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                Value = 0
            });
            v60:Play();
            task.delay(0.12, function() -- Line: 491
                -- upvalues: TweenService (ref), UIScale (ref)
                TweenService:Create(UIScale, TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Scale = 0
                }):Play();
            end);
            v60.Completed:Once(function() -- Line: 499
                -- upvalues: StopContentsWobble (ref), NumberValue (ref), NumberValue2 (copy), setScoreBannerReveal (ref), UIScale (ref), ScoreBanner (ref)
                StopContentsWobble();
                NumberValue:Destroy();
                NumberValue2:Destroy();
                setScoreBannerReveal(0);
                UIScale.Scale = 0;
                ScoreBanner.Visible = false;
            end);
        end);
    end);
end;

return v5;