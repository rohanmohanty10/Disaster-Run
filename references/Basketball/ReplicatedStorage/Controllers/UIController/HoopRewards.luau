 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("Lighting");
game:GetService("SoundService");
game:GetService("UserInputService");
game:GetService("GuiService");
game:GetService("MarketplaceService");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Packages.RelicsXYZ);
local Trove = require(ReplicatedStorage.Packages.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.GetUnixTime);
require(ReplicatedStorage.Shared.Tables.Rarities);
local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
local HoopRewards = require(ReplicatedStorage.Shared.Tables.HoopRewards);
local LocalPlayer = Players.LocalPlayer;
local HoopRewards2 = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HoopRewards");
local u1 = Knit.CreateController({
    Name = "HoopRewardsController"
});
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = {};
local u7 = Trove.new();
local u8 = Trove.new();
local u9 = Trove.new();
local u24 = {
    ["Style Spins"] = function(p10: userdata, p11: any) -- Line: 40
        p10.Image = "rbxassetid://111333169806568";
    end,

    ["Lucky Style Spins"] = function(p12: userdata, p13: any, p14: any) -- Line: 44
        p12.Image = "rbxassetid://111333169806568";
        p14:Add(script.Rainbow:Clone()).Parent = p12;
    end,

    ["Zone Spins"] = function(p15: userdata, p16: any) -- Line: 50
        p15.Image = "rbxassetid://71537410313776";
    end,

    ["Lucky Zone Spins"] = function(p17: userdata, p18: any, p19: any) -- Line: 54
        p17.Image = "rbxassetid://71537410313776";
        p19:Add(script.Rainbow:Clone()).Parent = p17;
    end,

    Emotes = function(u20: userdata, u21: userdata, u22: any) -- Line: 60
        -- upvalues: Knit (copy)
        task.spawn(function() -- Line: 61
            -- upvalues: u20 (copy), u22 (copy), Knit (ref), u21 (copy)
            u20.ImageTransparency = 1;
            local v23 = u22:Add(Instance.new("ViewportFrame", u20));
            v23.Size = UDim2.fromScale(1, 1);
            v23.Ambient = Color3.fromRGB(255, 255, 255);
            v23.BackgroundTransparency = 1;
            v23.ZIndex = u20.ZIndex;
            local Controller = Knit.GetController("EmotesController");

            while not Controller.CharacterRig do
                task.wait();
            end;

            Controller:CreatePreview(u21, v23, Controller.CharacterRig);
        end);
    end
};

function u1.Confirmation(p25, p26, u27) -- Line: 81
    -- upvalues: u9 (copy), HoopRewards2 (copy)
    u9:Clean();
    local Confirmation = HoopRewards2.Confirmation;
    Confirmation.Visible = true;
    Confirmation.Label.Text = p26;
    u9:Add(Confirmation.Yes.MouseButton1Click:Connect(function() -- Line: 89
        -- upvalues: u9 (ref), Confirmation (copy), u27 (copy)
        u9:Clean();
        Confirmation.Visible = false;
        u27();
    end));
    u9:Add(Confirmation.Cancel.MouseButton1Click:Connect(function() -- Line: 95
        -- upvalues: u9 (ref), Confirmation (copy)
        u9:Clean();
        Confirmation.Visible = false;
    end));
end;

function u1.SpawnPlayers(p28) -- Line: 101
    -- upvalues: HoopRewards2 (copy), u5 (ref), Effects (copy), u1 (copy), u6 (copy), Players (copy), LocalPlayer (copy), HoopRewards (copy), u7 (copy)
    local RequestFrame = HoopRewards2.BG.RequestFrame;
    local u29 = {};

    local function Invite(p30) -- Line: 106
        -- upvalues: u5 (ref), Effects (ref)
        local v31, v32 = u5:Invite(p30);

        if v31 then
            Effects:Popup("Request sent!");

            return;
        end;

        Effects:Popup(v32);
    end;

    local function ConnectionsFunc(p33, u34) -- Line: 115
        -- upvalues: u29 (ref), u1 (ref), u5 (ref), Effects (ref), u6 (ref)
        local u35 = tick();
        u29[p33] = p33.MouseButton1Click:Connect(function() -- Line: 117
            -- upvalues: u35 (ref), u1 (ref), u34 (copy), u5 (ref), Effects (ref)
            if u35 > tick() then
                return;
            end;

            u35 = tick() + 1;
            u1:Confirmation("ARE YOU SURE YOU WANT TO REQUEST A DUO? ALL PROGRESSION WILL BE RESET AND WILL NOT SAVE IF YOU LEAVE.", function() -- Line: 121
                -- upvalues: u34 (ref), u5 (ref), Effects (ref)
                local v36, v37 = u5:Invite(u34);

                if v36 then
                    Effects:Popup("Request sent!");

                    return;
                end;

                Effects:Popup(v37);
            end);
        end);
        u29[p33.Name .. "Request"] = p33.Request.MouseButton1Click:Connect(function() -- Line: 126
            -- upvalues: u35 (ref), u1 (ref), u34 (copy), u5 (ref), Effects (ref)
            if u35 > tick() then
                return;
            end;

            u35 = tick() + 1;
            u1:Confirmation("ARE YOU SURE YOU WANT TO REQUEST A DUO? ALL PROGRESSION WILL BE RESET AND WILL NOT SAVE IF YOU LEAVE.", function() -- Line: 130
                -- upvalues: u34 (ref), u5 (ref), Effects (ref)
                local v38, v39 = u5:Invite(u34);

                if v38 then
                    Effects:Popup("Request sent!");

                    return;
                end;

                Effects:Popup(v39);
            end);
        end);
        u29[p33.Name .. "Accept"] = p33.Accept.MouseButton1Click:Connect(function() -- Line: 135
            -- upvalues: u35 (ref), u6 (ref), u34 (copy), u1 (ref), u5 (ref), Effects (ref)
            if u35 > tick() then
                return;
            end;

            u35 = tick() + 1;

            if not u6[u34.Name] then
                return;
            end;

            u1:Confirmation("ARE YOU SURE YOU WANT TO ACCEPT? ALL PROGRESSION WILL BE RESET AND WILL NOT SAVE IF YOU LEAVE.", function() -- Line: 141
                -- upvalues: u5 (ref), u34 (ref), Effects (ref)
                local v40, v41 = u5:AcceptRequest(u34.Name);

                if not v40 then
                    Effects:Popup(v41);
                end;
            end);
        end);
    end;

    local function Clear() -- Line: 152
        -- upvalues: RequestFrame (copy), u29 (ref)
        for _, child in RequestFrame.ScrollingFrame:GetChildren() do
            if u29[child] then
                u29[child]:Disconnect();
                u29[child] = nil;
            end;

            if u29[child.Name .. "Accept"] then
                u29[child.Name .. "Accept"]:Disconnect();
                u29[child.Name .. "Accept"] = nil;
            end;

            if u29[child.Name .. "Request"] then
                u29[child.Name .. "Request"]:Disconnect();
                u29[child.Name .. "Request"] = nil;
            end;

            if child:IsA("ImageButton") then
                child:Destroy();
            end;
        end;

        u29 = {};
    end;

    local function Lobby() -- Line: 164
        -- upvalues: Players (ref), LocalPlayer (ref), RequestFrame (copy), u6 (ref), ConnectionsFunc (copy)
        for _, v in Players:GetPlayers() do
            if v ~= LocalPlayer and (v.Character and (v.Character:FindFirstChild("HumanoidRootPart") and not RequestFrame.ScrollingFrame:FindFirstChild(v.Name))) then
                local v42 = script.OptionPlayer:Clone();
                v42.Name = v.Name;
                v42.DisplayName.Text = tostring(v.DisplayName);
                v42.Username.Text = `@{v.Name}`;
                v42.Icon.Image = `rbxthumb://type=AvatarHeadShot&id={v.UserId}&w=180&h=180`;
                v42.Parent = RequestFrame.ScrollingFrame;

                if u6[v.Name] then
                    v42.Accept.Visible = true;
                    v42.Request.Visible = false;
                end;

                if LocalPlayer:IsFriendsWith(v.UserId) then
                    v42.LayoutOrder = 0;
                else
                    v42.LayoutOrder = 1;
                end;

                ConnectionsFunc(v42, v);
            end;
        end;
    end;

    LocalPlayer:GetAttributeChangedSignal("HoopRewardsDuo"):Connect(function() -- Line: 191
        -- upvalues: LocalPlayer (ref), Players (ref), Effects (ref), HoopRewards2 (ref), HoopRewards (ref), u7 (ref)
        if not LocalPlayer:GetAttribute("HoopRewardsDuo") then
            Effects:Popup("Your duo has left you!");
            HoopRewards2.BG.Leave.Visible = false;
            HoopRewards2.BG.Request.Visible = true;
            HoopRewards2.BG.Duo.Icon.Visible = false;
            HoopRewards2.BG.Duo.Progress.Amount.Text = "";
            HoopRewards2.BG.Duo.Progress.Bar.Size = UDim2.new(0, 0, 0.83, 0);
            u7:Clean();

            return;
        end;

        local v43 = Players:FindFirstChild(LocalPlayer:GetAttribute("HoopRewardsDuo"));

        if not v43 then
            return;
        end;

        Effects:Popup((`You and {LocalPlayer:GetAttribute("HoopRewardsDuo")} are now a duo!`));
        HoopRewards2.BG.Leave.Visible = true;
        HoopRewards2.BG.Request.Visible = false;
        HoopRewards2.BG.Duo.Icon.Visible = true;
        HoopRewards2.BG.Duo.Icon.Image = `rbxthumb://type=AvatarHeadShot&id={v43.UserId}&w=180&h=180`;
        HoopRewards2.BG.Duo.Icon.Username.Text = `@{LocalPlayer:GetAttribute("HoopRewardsDuo")}`;
        local HoopRewardsScore = LocalPlayer:WaitForChild("HoopRewardsScore");
        local HoopRewardsScore2 = v43:WaitForChild("HoopRewardsScore");

        local function UpdateScore() -- Line: 208
            -- upvalues: HoopRewardsScore (copy), HoopRewardsScore2 (copy), HoopRewards (ref), HoopRewards2 (ref)
            local v44 = HoopRewardsScore.Value + HoopRewardsScore2.Value;
            local v45 = 0;

            for i, v in ipairs(HoopRewards) do
                if v.Amount <= v44 then
                    v45 = i;
                end;
            end;

            local v46 = v45 > 0 and (HoopRewards[v45].Amount or 0) or 0;
            local v47;

            if #HoopRewards <= v45 then
                v47 = 1;
            else
                local v48 = HoopRewards2.BG.Progress:FindFirstChild(v45);
                local v49 = HoopRewards2.BG.Progress:FindFirstChild(v45 + 1);
                v47 = (v48 and v48.Position.X.Scale - v48.Size.X.Scale / 2 or 0) + (v44 - v46) / (HoopRewards[v45 + 1].Amount - v46) * (v49 and (v49.Position.X.Scale - v49.Size.X.Scale / 2 - v45 / 6 or 0) or 0);
            end;

            HoopRewards2.BG.Total.Amount.Text = v44;
            HoopRewards2.BG.Player.Progress.Amount.Text = HoopRewardsScore.Value;
            HoopRewards2.BG.Duo.Progress.Amount.Text = HoopRewardsScore2.Value;
            HoopRewards2.BG.Progress.Bar.Size = UDim2.new(v47, 0, 0.83, 0);
            HoopRewards2.BG.Player.Progress.Bar.Size = UDim2.new(v47 / 2 * (HoopRewardsScore.Value / HoopRewardsScore2.Value), 0, 0.83, 0);
            HoopRewards2.BG.Duo.Progress.Bar.Size = UDim2.new(v47 / 2 * (HoopRewardsScore2.Value / HoopRewardsScore.Value), 0, 0.83, 0);
        end;

        u7:Connect(HoopRewardsScore:GetPropertyChangedSignal("Value"), function() -- Line: 239
            -- upvalues: UpdateScore (copy)
            UpdateScore();
        end);
        u7:Connect(HoopRewardsScore2:GetPropertyChangedSignal("Value"), function() -- Line: 243
            -- upvalues: UpdateScore (copy)
            UpdateScore();
        end);
        UpdateScore();
    end);
    u5.InviteReceived:Connect(function(u50) -- Line: 262
        -- upvalues: Effects (ref), RequestFrame (copy), u6 (ref)
        Effects:Popup((`{u50} invited you to their party!`));

        if RequestFrame.ScrollingFrame:FindFirstChild(u50) then
            RequestFrame.ScrollingFrame[u50].Accept.Visible = true;
            RequestFrame.ScrollingFrame[u50].Request.Visible = false;
        end;

        u6[u50] = true;
        task.delay(55, function() -- Line: 271
            -- upvalues: u6 (ref), u50 (copy), RequestFrame (ref)
            u6[u50] = nil;

            if RequestFrame.ScrollingFrame:FindFirstChild(u50) then
                RequestFrame.ScrollingFrame[u50].Accept.Visible = false;
                RequestFrame.ScrollingFrame[u50].Request.Visible = true;
            end;
        end);
    end);
    Lobby();
    RequestFrame:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 283
        -- upvalues: RequestFrame (copy), Clear (copy), Lobby (copy)
        if RequestFrame.Visible then
            Clear();
            Lobby();
        end;
    end);
    HoopRewards2.BG.Request.MouseButton1Click:Connect(function() -- Line: 290
        -- upvalues: RequestFrame (copy)
        RequestFrame.Visible = true;
    end);
    HoopRewards2.BG.Leave.MouseButton1Click:Connect(function() -- Line: 294
        -- upvalues: u1 (ref), u5 (ref)
        u1:Confirmation("ARE YOU SURE YOU WANT TO LEAVE YOUR DUO? ALL PROGRESSION WILL BE RESET.", function() -- Line: 296
            -- upvalues: u5 (ref)
            u5:Leave();
        end);
    end);
end;

function u1.KnitInit(p51) -- Line: 303
end;

function u1.KnitStart(p52) -- Line: 307
    -- upvalues: u2 (ref), Knit (copy), u3 (ref), u4 (ref), u5 (ref), HoopRewards2 (copy), u8 (copy), HoopRewards (copy), Customization (copy), u24 (copy), LocalPlayer (copy)
    u2 = Knit.GetController("Shop");
    u3 = Knit.GetController("Network");
    u4 = Knit.GetController("UIController");
    u5 = Knit.GetService("HoopRewardsService");
    HoopRewards2:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 314
        -- upvalues: u8 (ref), HoopRewards2 (ref), HoopRewards (ref), Customization (ref), u24 (ref), u2 (ref), u3 (ref), LocalPlayer (ref), u4 (ref)
        u8:Clean();

        if HoopRewards2.Enabled then
            for _, child in HoopRewards2.BG.Progress:GetChildren() do
                if child:IsA("ImageLabel") then
                    local Reward = HoopRewards[tonumber(child.Name)].Reward;
                    child.Reward.Label.Text = Customization[Reward.Type] and Reward.Name or `{Reward.Value or ""} {Reward.Name}`;

                    if u24[Reward.Type or Reward.Name] then
                        local v53;

                        if Reward.Type == "Emotes" then
                            v53 = Reward.Name;
                        else
                            v53 = false;
                        end;

                        u24[Reward.Type or Reward.Name](child.Reward.Icon, v53, u8);
                    elseif Reward.Type == "GoalEffects" then
                        child.Reward.Icon.Image = u2.GoalIcons[Reward.Name] or "";
                    elseif Reward.Type == "Cards" then
                        child.Reward.Icon.Image = u2.Cards[Reward.Name] or "";
                    else
                        local v54 = Customization[Reward.Type][Reward.Name];

                        if v54.IconId then
                            child.Reward.Icon.Image = `rbxassetid://{v54.IconId}`;
                        end;
                    end;

                    if table.find(u3.Player.ClaimedHoopRewards, child.Name) then
                        for _, descendant in child:GetDescendants() do
                            if descendant:IsA("UIGradient") and (descendant.Name ~= "Rainbow" and descendant.Parent.Name ~= "Requirement") then
                                descendant.Color = ColorSequence.new(Color3.fromRGB(0, 254, 4));
                            end;
                        end;
                    end;
                end;
            end;

            if not LocalPlayer:GetAttribute("HoopRewardsDuo") then
                local HoopRewardsScore = u3.Player.HoopRewardsScore;
                local v55 = 0;

                for i, v in ipairs(HoopRewards) do
                    if v.Amount <= HoopRewardsScore then
                        v55 = i;
                    end;
                end;

                local v56 = v55 > 0 and (HoopRewards[v55].Amount or 0) or 0;
                local v57;

                if #HoopRewards <= v55 then
                    v57 = 1;
                else
                    local v58 = HoopRewards2.BG.Progress:FindFirstChild(v55);
                    local v59 = HoopRewards2.BG.Progress:FindFirstChild(v55 + 1);
                    v57 = (v58 and v58.Position.X.Scale - v58.Size.X.Scale / 2 or 0) + (HoopRewardsScore - v56) / (HoopRewards[v55 + 1].Amount - v56) * (v59 and (v59.Position.X.Scale - v59.Size.X.Scale / 2 - v55 / 6 or 0) or 0);
                end;

                HoopRewards2.BG.Total.Amount.Text = HoopRewardsScore;
                HoopRewards2.BG.Player.Progress.Amount.Text = HoopRewardsScore;
                HoopRewards2.BG.Progress.Bar.Size = UDim2.new(v57, 0, 0.83, 0);
                HoopRewards2.BG.Player.Progress.Bar.Size = UDim2.new(v57, 0, 0.83, 0);
            end;
        else
            u4:Focus(false, HoopRewards2.BG);
        end;
    end);
    HoopRewards2.BG.CloseButton.MouseButton1Click:Connect(function() -- Line: 383
        -- upvalues: HoopRewards2 (ref), LocalPlayer (ref)
        if HoopRewards2.BG.RequestFrame.Visible then
            HoopRewards2.BG.RequestFrame.Visible = false;

            return;
        end;

        LocalPlayer.PlayerGui.HUD.Enabled = true;
        HoopRewards2.Enabled = false;
    end);
    p52:SpawnPlayers();
end;

return u1;