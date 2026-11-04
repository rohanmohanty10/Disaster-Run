  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
game:GetService("RunService");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game.Players.LocalPlayer;
local Item = ReplicatedStorage.Assets.UI.ProdigyTrack.Item;
local Knit = require(ReplicatedStorage.Packages.Knit);
local ProdigyTrackData = require(ReplicatedStorage.Shared.Configs.ProdigyTrackData);
local ProdigyTrackInfo = require(ReplicatedStorage.Shared.Configs.ProdigyTrackInfo);
local Random_new_ret = Random.new();
local v1 = Knit.CreateController({
    Name = "ProdigyTrackController"
});
local u2 = false;

function v1.Spin(u3, p4, p5) -- Line: 23
    -- upvalues: u2 (ref), TweenService (copy), Random_new_ret (copy), ReplicatedStorage (copy)
    u2 = true;

    local function ease(p6) -- Line: 28
        -- upvalues: TweenService (ref)
        return TweenService:GetValue(p6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end;

    local u7 = nil;

    local function move(p8: number) -- Line: 36
        -- upvalues: u7 (ref), TweenService (ref), u3 (copy)
        if u7 then
            TweenService:Create(u3.tiles[u7].UIScale, TweenInfo.new(0.1), {
                Scale = 1
            }):Play();
        end;

        if p8 then
            TweenService:Create(u3.tiles[p8].UIScale, TweenInfo.new(0.1), {
                Scale = 1.1
            }):Play();
            u7 = p8;
        end;
    end;

    for i = 1, 14 do
        local v9 = i;
        local v10 = {};

        for i2 = 1, 8 do
            local v11;

            if i2 == u7 or i2 == p4 and v9 == 13 then
                v11 = i2;
            else
                table.insert(v10, i2);
                v11 = i2;
            end;
        end;

        move(v10[Random_new_ret:NextInteger(1, #v10)]);
        ReplicatedStorage.Assets.Sfx.WheelTick:Play();
        task.wait(v9 / 14 * 0.4 + 0.12);
    end;

    move(p4);
    ReplicatedStorage.Assets.Sfx.WheelTick:Play();
    task.wait(1.5);

    if u7 then
        TweenService:Create(u3.tiles[u7].UIScale, TweenInfo.new(0.1), {
            Scale = 1
        }):Play();
    end;

    u2 = false;
end;

function v1.KnitStart(u12) -- Line: 75
    -- upvalues: Knit (copy), LocalPlayer (copy), ProdigyTrackData (copy), u2 (ref), ReplicatedStorage (copy), MarketplaceService (copy), Item (copy), ProdigyTrackInfo (copy), TweenService (copy)
    local Service = Knit.GetService("ProdigyTrackService");
    u12.Instance = LocalPlayer.PlayerGui:WaitForChild("ProdigyTrack");
    u12.tiles = {};

    for _, child in u12.Instance.ProdigyCrate.Contents.ItemHolder.Items:GetChildren() do
        if child:IsA("ImageLabel") then
            u12.tiles[tonumber(child.Name)] = child;
            child.Reward.Text = ProdigyTrackData[tonumber(child.Name)][1];
            child.Chance.Text = ProdigyTrackData[tonumber(child.Name)][2] .. "%";
            child:SetAttribute("Size", child.Size);
        end;
    end;

    local TopBar = u12.Instance.TopBarHolder.TopBar;
    TopBar.Crate.Activated:Connect(function() -- Line: 91
        -- upvalues: u12 (copy), TopBar (copy)
        if u12.Instance.ProdigyCrate.Visible then
            return;
        end;

        TopBar.Crate.Overlay.Visible = false;
        u12.Instance.ProdigyCrate.Visible = true;
        TopBar.Track.Overlay.Visible = true;
        u12.Instance.ProdigyTrack.Visible = false;
    end);
    TopBar.Track.Activated:Connect(function() -- Line: 101
        -- upvalues: u12 (copy), TopBar (copy)
        if u12.Instance.ProdigyTrack.Visible then
            return;
        end;

        TopBar.Crate.Overlay.Visible = true;
        u12.Instance.ProdigyCrate.Visible = false;
        TopBar.Track.Overlay.Visible = false;
        u12.Instance.ProdigyTrack.Visible = true;
    end);
    u12.Instance.ProdigyCrate.Contents.ItemHolder.Buttons.SpinMain.Activated:Connect(function() -- Line: 112
        -- upvalues: u2 (ref), Service (copy)
        if u2 then
            return;
        end;

        Service:Spin();
    end);
    Service.SpinResults:Connect(function(p13) -- Line: 122
        -- upvalues: u12 (copy)
        u12:Spin(p13.prize, 6);
    end);
    local RngUtil = require(ReplicatedStorage.Shared.RngUtil);
    local v16 = RngUtil.ConvertToWeightMap(ProdigyTrackData, function(p14, p15) -- Line: 128
        return p14, p15[2];
    end);
    RngUtil.ToChances(v16);

    for _, child in u12.Instance.ProdigyCrate.Contents.ItemHolder.Buttons:GetChildren() do
        if child:IsA("ImageButton") and child:GetAttribute("ID") then
            child.Activated:Connect(function() -- Line: 136
                -- upvalues: MarketplaceService (ref), LocalPlayer (ref), child (copy)
                MarketplaceService:PromptProductPurchase(LocalPlayer, child:GetAttribute("ID"));
            end);
        end;
    end;

    local function createFrame(p17, p18, p19) -- Line: 146
        -- upvalues: Item (ref), ProdigyTrackInfo (ref), Service (copy), u12 (copy)
        local v20 = Item:Clone();
        local v21 = p18 + p17 - 1;
        v20.LayoutOrder = v21;
        v20.Name = v21;
        local GoalTarget = ProdigyTrackInfo.GetGoalTarget(v21);
        local math_min_ret = math.min(p19, GoalTarget);

        if p17 == 1 then
            v20.ProgressBar.Bar.Size = UDim2.fromScale(math_min_ret / GoalTarget, 1);
            v20.Progress.Text = `{math_min_ret}/{GoalTarget} GOALS`;
        else
            v20.Overlay.Visible = true;
            v20.ProgressBar.Bar.Size = UDim2.fromScale(0, 1);
            v20.Progress.Text = `0/{GoalTarget} GOALS`;
        end;

        v20.Activated:Connect(function() -- Line: 167
            -- upvalues: Service (ref)
            Service:ClaimReward();
        end);
        v20.Parent = u12.Instance.ProdigyTrack.Contents.ItemHolder.Items;
    end;

    task.spawn(function() -- Line: 176
        -- upvalues: Service (copy), u12 (copy), createFrame (copy), TweenService (ref), ProdigyTrackInfo (ref)
        local v22 = nil;
        local v23 = nil;

        while true do
            while true do
                local Data = Service:GetData();

                if not Data then
                    break;
                end;

                local Tokens = Data.Tokens;
                local Goals = Data.Goals;
                local Tier = Data.Tier;

                if not v22 then
                    createFrame(1, Tier, Goals);
                    createFrame(2, Tier, Goals);
                    createFrame(3, Tier, Goals);
                    createFrame(4, Tier, Goals);
                    v23 = Tier;
                    v22 = true;
                end;

                if v23 ~= Tier then
                    createFrame(4, Tier, Goals);
                    local v24 = TweenService:Create(u12.Instance.ProdigyTrack.Contents.ItemHolder.Items, TweenInfo.new(1.5), {
                        CanvasPosition = Vector2.new(u12.Instance.ProdigyTrack.Contents.ItemHolder.Items.AbsoluteSize.X / 2.8, 0)
                    });
                    v24:Play();
                    v24.Completed:Wait();
                    u12.Instance.ProdigyTrack.Contents.ItemHolder.Items:FindFirstChild((tostring(v23))):Destroy();
                    v23 = Tier;
                end;

                local v25 = u12.Instance.ProdigyTrack.Contents.ItemHolder.Items[tostring(Tier)];
                v25.Overlay.Visible = false;
                local GoalTarget = ProdigyTrackInfo.GetGoalTarget(Tier);
                local math_min_ret = math.min(Goals, GoalTarget);
                v25.Progress.Text = `{math_min_ret}/{GoalTarget} GOALS`;
                v25.ProgressBar.Bar.Size = UDim2.fromScale(math_min_ret / GoalTarget, 1);
                u12.Instance.ProdigyCrate.Contents.ItemHolder.Buttons.SpinMain.Text.Text = "Spin (" .. Tokens .. ")";
                task.wait(1);
            end;

            u12.Instance.ProdigyCrate.Contents.ItemHolder.Buttons.SpinMain.Text.Text = "Loading";
            task.wait(0.1);
        end;
    end);
end;

return v1;