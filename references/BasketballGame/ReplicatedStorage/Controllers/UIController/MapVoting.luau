 
 

local GuiService = game:GetService("GuiService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Effects);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local HUD = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HUD");
local MapVoting = HUD:WaitForChild("MapVoting");
local v1 = Knit.CreateController({
    Name = "MapVotingController"
});
local Random_new_ret = Random.new();

function v1.PopulateMaps(u2, p3) -- Line: 20
    -- upvalues: MapVoting (copy), SfxManager (copy), GuiService (copy), UserInputService (copy)
    for _, child in MapVoting.Holder.Content.Container:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    local v4 = { 1, 2, 3 };

    for i, v in p3 do
        local v5 = #v4 > 1 and (math.random(1, #v4) or 1) or 1;
        local v6 = v4[v5];
        table.remove(v4, v5);
        local u7 = script.Map:Clone();
        u7.Name = i;
        u7.MapContainer.Render.Image = v.screenshot;
        u7.MapName.Text = v.display;
        u7.MapName.TextColor3 = v.displayColor;
        u7.Tag.TextLabel.Text = `0{v6}`;
        u7.Event.Visible = v.event;
        u7.LayoutOrder = v6;
        u7.Parent = MapVoting.Holder.Content.Container;
        u7.ImageButton.MouseButton1Down:Connect(function() -- Line: 47
            -- upvalues: SfxManager (ref), GuiService (ref), UserInputService (ref), u7 (copy), u2 (copy), i (copy)
            SfxManager:playSound({
                Sound = "MapVoting",
                Parent = workspace
            });
            local GuiInset = GuiService:GetGuiInset();
            local v8 = UserInputService:GetMouseLocation() - GuiInset - u7.AbsolutePosition;
            local UDim2_fromScale_ret = UDim2.fromScale(v8.X / u7.AbsoluteSize.X, v8.Y / u7.AbsoluteSize.Y);
            u2.MatchService.MapVote:Fire(i, UDim2_fromScale_ret);
        end);
    end;
end;

function v1.KnitStart(u9) -- Line: 59
    -- upvalues: Knit (copy), MapVoting (copy), TweenService (copy), HUD (copy), ReplicatedStorage (copy), LocalPlayer (copy), Random_new_ret (copy)
    u9.MatchService = Knit.GetService("MatchService");
    u9.MatchService.MapVote:Connect(function(p10, p11) -- Line: 62
        -- upvalues: u9 (copy), MapVoting (ref), TweenService (ref), HUD (ref), ReplicatedStorage (ref)
        if p10 then
            u9.CanVote = true;
            u9:PopulateMaps(p11);
            MapVoting.Position = UDim2.fromScale(0.5, -0.5);
            MapVoting.Visible = true;
            TweenService:Create(MapVoting, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Position = UDim2.fromScale(0.5, 0.103)
            }):Play();
            task.delay(0.25, function() -- Line: 78
                -- upvalues: u9 (ref), HUD (ref)
                if u9.CanVote then
                    HUD.MatchTimer.Visible = false;
                end;
            end);

            while u9.CanVote do
                MapVoting.Holder.Header.Content.Timer.Text = `VOTE ENDS IN {math.floor(ReplicatedStorage.GameValues.Timer.Value - 10)}`;
                task.wait();
            end;
        else
            if not u9.CanVote then
                return;
            end;

            u9.CanVote = false;
            local MapName = MapVoting.Holder.Content.Container:FindFirstChild(p11).MapName;
            local TextColor3 = MapName.TextColor3;

            for i = 1, 5 do
                MapName.TextColor3 = Color3.new(0, 1, 0);
                task.wait(0.1);
                MapName.TextColor3 = TextColor3;
                task.wait(0.1);
                local _ = i;
            end;

            MapName.TextColor3 = Color3.new(0, 1, 0);
            task.delay(1, function() -- Line: 107
                -- upvalues: HUD (ref), TweenService (ref), MapVoting (ref), u9 (ref)
                HUD.MatchTimer.Visible = true;
                TweenService:Create(MapVoting, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Position = UDim2.fromScale(0.5, -0.5)
                }):Play();
                task.wait(0.25);

                if not u9.CanVote then
                    MapVoting.Visible = false;
                end;
            end);
        end;
    end);
    u9.MatchService.VoteChanged:Connect(function(p12, p13, p14, p15) -- Line: 123
        -- upvalues: LocalPlayer (ref), MapVoting (ref), TweenService (ref), Random_new_ret (ref)
        if p12 ~= nil and (p12 == LocalPlayer.UserId and (p13 == nil or p13 ~= p14)) then
            for _, child in MapVoting.Holder.Content.Container:GetChildren() do
                if child:IsA("Frame") then
                    if child.Name == p13 or child.Name == p14 then
                        child.VotedTab.GroupTransparency = 0;
                        local NumberValue = Instance.new("NumberValue");
                        NumberValue.Changed:Connect(function() -- Line: 132
                            -- upvalues: NumberValue (copy), child (copy)
                            local math_clamp_ret = math.clamp(NumberValue.Value - 0.08, 0, 1);
                            local math_clamp_ret2 = math.clamp(NumberValue.Value + 0.08, 0, 1);
                            child.VotedTab.UIGradient.Transparency = NumberSequence.new({
                                NumberSequenceKeypoint.new(0, 0),
                                NumberSequenceKeypoint.new(math_clamp_ret, 0),
                                NumberSequenceKeypoint.new(math_clamp_ret2, 1),
                                NumberSequenceKeypoint.new(1, 1)
                            });
                        end);

                        if child.Name == p13 then
                            NumberValue.Value = 1;
                            TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Value = 0
                            }):Play();
                        elseif child.Name == p14 then
                            TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Value = 1
                            }):Play();
                        end;

                        task.delay(0.25, function() -- Line: 152
                            -- upvalues: NumberValue (copy)
                            NumberValue:Destroy();
                        end);
                    else
                        child.VotedTab.GroupTransparency = 1;
                    end;
                end;
            end;
        end;

        local v16 = MapVoting.Holder.Content.Container:FindFirstChild(p14);
        local VotingPlayers = v16.VotingPlayers;

        if p13 ~= nil then
            local v17 = MapVoting.Holder.Content.Container:FindFirstChild(p13);
            local VotingPlayers2 = v17.VotingPlayers;

            for _, child in VotingPlayers2:GetChildren() do
                if child:GetAttribute("UserId") == p12 then
                    child:Destroy();
                end;
            end;

            v17.VoteCount.Text = #VotingPlayers2:GetChildren();
        end;

        local v18 = script.UserVote:Clone();
        local Size = v18.Size;
        v18.Size = v18.Size + UDim2.fromScale(0.125, 0.125);
        v18:SetAttribute("UserId", p12);
        v18.Name = p12;
        v18.Image = `rbxthumb://type=AvatarHeadShot&id={p12}&w=60&h=60`;
        v18.Rotation = Random_new_ret:NextNumber(-25, 25);
        v18.Position = p15;
        v18.UIStroke.Color = BrickColor.Random().Color;
        v18.Parent = VotingPlayers;
        TweenService:Create(v18, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Size
        }):Play();
        v16.VoteCount.Text = #VotingPlayers:GetChildren();
    end);
end;

return v1;