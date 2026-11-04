 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
require(ReplicatedStorage.Shared.Utility.Effects);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.NumberUtil);
require(ReplicatedStorage.Shared.Tables.StatsSettings);
local RankingBrackets = require(ReplicatedStorage.Shared.Tables.RankingBrackets);
local v3 = Knit.CreateController({
    Name = "RankupController"
});
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local Random_new_ret = Random.new();

function v3.KnitStart(p8) -- Line: 32
    -- upvalues: u7 (ref), LocalPlayer (copy), u4 (ref), Knit (copy), u5 (ref), u6 (ref), RankingBrackets (copy), TweenService (copy), SfxManager (copy), RunService (copy), Random_new_ret (copy), ReplicatedStorage (copy)
    u7 = LocalPlayer.PlayerGui:WaitForChild("Rankup");
    u4 = Knit.GetController("Network");
    u5 = Knit.GetService("StatsService");
    u6 = Knit.GetService("MatchService");

    if u4.Gamemode == "Normal" then
        return;
    end;

    local u9 = u4.Gamemode:sub(7);
    local RR = u4.Player.Ranked[u9].RR;
    local u10 = nil;

    local function showNewRankIfNeeded() -- Line: 48
        -- upvalues: u10 (ref), RR (copy), RankingBrackets (ref), u7 (ref), u9 (copy), TweenService (ref), SfxManager (ref), RunService (ref), Random_new_ret (ref)
        while u10 == nil do
            task.wait();
        end;

        if RR == u10 then
            return;
        end;

        local u11, v12;

        if RR > -1 then
            u11, v12 = RankingBrackets:GetRankFromRR(RR);
        else
            u11 = "Unplaced";
            v12 = nil;
        end;

        local RankFromRR, v13 = RankingBrackets:GetRankFromRR(u10);

        local function showRank(p14, p15, p16) -- Line: 67
            -- upvalues: RankingBrackets (ref), u7 (ref), u9 (ref), TweenService (ref), SfxManager (ref)
            local v17;

            if p15 then
                v17 = RankingBrackets.Icons[p14][p15];
            else
                v17 = RankingBrackets.Icons[p14];
            end;

            u7.BG.RankupFrame.RankIcon.Image = v17;
            u7.BG.RankupFrame.CompetitiveText.Text = `{u9:upper()} RANK`;

            if p15 then
                u7.BG.RankupFrame.RankText.Text = `{p14:upper()} {string.rep("I", p15)}`;
            else
                u7.BG.RankupFrame.RankText.Text = p14:upper();
            end;

            u7.BG.RankupFrame.RankText.TextColor3 = Color3.fromHex(RankingBrackets.ChatTags[p14][2]);
            local Size = u7.BG.RankupFrame.RankIcon.Size;
            u7.BG.RankupFrame.RankIcon.Size = UDim2.fromScale(Size.X.Scale + 0.05, Size.Y.Scale + 0.05);
            TweenService:Create(u7.BG.RankupFrame.RankIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = Size
            }):Play();

            if p16 == nil and true or p16 then
                SfxManager:playSound({
                    Sound = "UnlockStyle",
                    Parent = workspace
                });
            end;
        end;

        showRank(u11, v12, false);
        u7.Enabled = true;
        TweenService:Create(u7.BG, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0
        }):Play();
        TweenService:Create(u7.BG.Pattern, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0
        }):Play();
        u7.BG.Close.Visible = false;
        u7.BG.RankupFrame.CongratulationsText.Visible = false;
        u7.BG.RankupFrame.PromotedText.Visible = false;
        u7.BG.RankupFrame.Starburst.Visible = false;
        u7.BG.RankupFrame.Glow.Visible = false;

        if RR ~= -1 then
            if RR >= RankingBrackets:GetMaxRR() then
                u7.BG.RankupFrame.RRText.Text = `{RR}`;
            else
                local RRToNextRank, v18 = RankingBrackets:GetRRToNextRank(RR);
                u7.BG.RankupFrame.RRText.Text = `{RRToNextRank}/{v18}`;
            end;

            u7.BG.RankupFrame.RRText.Visible = true;
            task.wait(1);
            local math_abs_ret = math.abs(u10 - RR);

            if RR < u10 then
                u7.BG.RankupFrame.RRGainText.Text = `+{math_abs_ret} RR`;
                u7.BG.RankupFrame.RRGainText.TextColor3 = Color3.fromRGB(0, 255, 0);
            else
                u7.BG.RankupFrame.RRGainText.Text = `-{math_abs_ret} RR`;
                u7.BG.RankupFrame.RRGainText.TextColor3 = Color3.fromRGB(255, 0, 0);
            end;

            SfxManager:playSound({
                Sound = "HoverUI",
                Parent = workspace
            });
            u7.BG.RankupFrame.RRGainText.Position = UDim2.fromScale(0.5, 1.05);
            u7.BG.RankupFrame.RRGainText.TextTransparency = 1;
            u7.BG.RankupFrame.RRGainText.Visible = true;
            TweenService:Create(u7.BG.RankupFrame.RRGainText, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                TextTransparency = 0,
                Position = UDim2.fromScale(0.5, 1)
            }):Play();
            task.wait(1.5);
            local IntValue = Instance.new("IntValue");
            IntValue.Value = RR;
            local u19 = false;
            local u20 = false;
            local u21 = nil;
            local u22 = nil;
            u21 = IntValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 161
                -- upvalues: SfxManager (ref), IntValue (copy), RankingBrackets (ref), u7 (ref), u19 (ref), showRank (copy), u20 (ref), u11 (ref), u21 (ref), u22 (ref), u10 (ref), RR (ref)
                SfxManager:playSound({
                    Sound = "Spin",
                    Parent = workspace
                });

                if IntValue.Value >= RankingBrackets:GetMaxRR() then
                    u7.BG.RankupFrame.RRText.Text = `{IntValue.Value}`;

                    return;
                end;

                local RRToNextRank, v23 = RankingBrackets:GetRRToNextRank(IntValue.Value);

                if u19 then
                    local RankFromRR2, v24 = RankingBrackets:GetRankFromRR(IntValue.Value);
                    showRank(RankFromRR2, v24);
                    u19 = false;
                elseif u20 then
                    local RankFromRR2, v25 = RankingBrackets:GetRankFromRR(IntValue.Value);

                    if RankFromRR2 == u11 then
                        showRank(RankFromRR2, v25);
                    else
                        u21:Disconnect();
                        u22:Cancel();
                        RRToNextRank = 100;
                    end;

                    u20 = false;
                elseif RRToNextRank == 0 then
                    u19 = true;
                elseif RRToNextRank == 99 and RR < u10 then
                    u20 = true;
                end;

                u7.BG.RankupFrame.RRText.Text = `{RRToNextRank}/{v23}`;
            end);
            u22 = TweenService:Create(IntValue, TweenInfo.new(math_abs_ret * 0.025), {
                Value = u10
            });
            u22:Play();
            u22.Completed:Wait();
            IntValue:Destroy();
            task.wait(1);
            TweenService:Create(u7.BG.RankupFrame.RRGainText, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                TextTransparency = 1
            }):Play();
            TweenService:Create(u7.BG.RankupFrame.RRText, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                TextTransparency = 1
            }):Play();
            task.wait(0.5);
        end;

        if RankFromRR ~= u11 and RR < u10 then
            task.wait(1);
            SfxManager:playSound({
                Sound = "RankUp",
                Parent = workspace
            });
            local Position = u7.BG.RankupFrame.RankIcon.Position;
            local Size = u7.BG.RankupFrame.RankIcon.Size;
            local u26 = 0;
            local v29 = RunService.PreRender:Connect(function(p27) -- Line: 227
                -- upvalues: u26 (ref), TweenService (ref), u7 (ref), Position (copy), Random_new_ret (ref)
                u26 = u26 + p27;
                local v28 = 0.025 * TweenService:GetValue(u26, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
                u7.BG.RankupFrame.RankIcon.Position = UDim2.fromScale(Position.X.Scale + Random_new_ret:NextNumber(-v28, v28), Position.Y.Scale + Random_new_ret:NextNumber(-v28, v28));
            end);
            TweenService:Create(u7.BG.RankupFrame.RankIcon, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
                Size = UDim2.fromScale(Size.X.Scale + 0.2, Size.Y.Scale + 0.2)
            }):Play();
            task.wait(1.5);
            u7.Flash.Visible = true;
            showRank(RankFromRR, v13, false);
            task.wait(0.5);
            v29:Disconnect();
            u7.BG.RankupFrame.RankIcon.Position = Position;
            u7.BG.RankupFrame.RankIcon.Size = Size;
            u7.BG.RankupFrame.Starburst.Visible = true;
            u7.BG.RankupFrame.Glow.Visible = true;
            u7.BG.RankupFrame.CongratulationsText.Visible = true;
            u7.BG.RankupFrame.PromotedText.Visible = true;
            TweenService:Create(u7.Flash, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                BackgroundTransparency = 1
            }):Play();
        end;

        task.wait(1);
        u7.BG.Close.Position = UDim2.fromScale(0.5, 1.2);
        TweenService:Create(u7.BG.Close, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.913)
        }):Play();
        u7.BG.Close.Visible = true;
    end;

    ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 271
        -- upvalues: RR (copy), u4 (ref), u9 (copy), u10 (ref)
        if RR ~= u4.Player.Ranked[u9].RR then
            u10 = u4.Player.Ranked[u9].RR;
        end;
    end);
    u7.BG.Close.Activated:Connect(function() -- Line: 277
        -- upvalues: u7 (ref)
        u7.Enabled = false;
    end);
    u6.EndMatch:Connect(function() -- Line: 281
        -- upvalues: ReplicatedStorage (ref), showNewRankIfNeeded (copy)
        ReplicatedStorage.GameValues.State:GetPropertyChangedSignal("Value"):Wait();
        showNewRankIfNeeded();
    end);
    RunService.PreRender:Connect(function(p30) -- Line: 286
        -- upvalues: u7 (ref)
        if not u7.Enabled then
            return;
        end;

        local Starburst = u7.BG.RankupFrame.Starburst;
        Starburst.Rotation = Starburst.Rotation + 90 * p30;
    end);
    local u31 = 0;
    RunService.PreRender:Connect(function(p32) -- Line: 297
        -- upvalues: u7 (ref), u31 (ref)
        if not u7.Enabled then
            return;
        end;

        u31 = u31 + 0.03333333333333333 * p32;
        u31 = u31 % 1;
        u7.BG.Pattern.Position = UDim2.fromOffset(-u31 * 500 - 1000, -u31 * 500 - 1000);
    end);
end;

function v3.KnitInit(p33) -- Line: 308
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    LocalPlayer.CharacterAdded:Connect(function(p34) -- Line: 309
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p34;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
end;

return v3;