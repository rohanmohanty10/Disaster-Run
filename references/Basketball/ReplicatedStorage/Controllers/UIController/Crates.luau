 
 

local MarketplaceService = game:GetService("MarketplaceService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Knit = require(ReplicatedStorage.Packages.Knit);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
local SeasonPass = require(ReplicatedStorage.Shared.Tables.SeasonPass);
local CratesItems = require(ReplicatedStorage.Shared.Tables.CratesItems);
local v1 = Knit.CreateController({
    Name = "Crates"
});

function v1.KnitInit(p2) -- Line: 24
end;

function v1.DataUpdate(p3) -- Line: 28
    -- upvalues: NumberUtil (copy)
    p3.UI.BG.CurrencyCounter.Amount.Text = NumberUtil.WithCommas(p3.SeasonPassData.Currency);
end;

function v1.Open(u4, u5, u6) -- Line: 32
    -- upvalues: TweenService (copy), CratesItems (copy), SeasonPass (copy), Effects (copy)
    u4.Opening = true;
    u4.HighlightPosition.Value = u4.HighlightPosition.Value % 8;

    if u4.HighlightPosition.Value == 0 then
        u4.HighlightPosition.Value = 8;
    end;

    u4.Tween = TweenService:Create(u4.HighlightPosition, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 80 + u5
    });
    u4.Tween:Play();
    u4.UI.BG.Open.Label.Text = "Skip";
    u4.Tween.Completed:Connect(function() -- Line: 45
        -- upvalues: u4 (copy), CratesItems (ref), u5 (copy), u6 (copy), SeasonPass (ref), Effects (ref)
        u4.UI.BG.Open.Label.Text = 150;
        local v7 = CratesItems.Rewards[u5];
        local v8;

        if u6 and v7[3].LuckySpins then
            v8 = `Duplicate! Received {v7[3].LuckySpins} Lucky Style Spins!`;
        elseif u6 and v7[3].SeasonPassCurrency then
            v8 = `Duplicate! Received {v7[3].SeasonPassCurrency} {SeasonPass.Items.Currency.DisplayName}!`;
        elseif typeof(v7[3]) == "number" and v7[3] > 0 then
            v8 = `You got {v7[3]} {v7[2]}!`;
        else
            v8 = `You got {v7[2]}!`;
        end;

        Effects:Popup(v8, 2, Color3.new(1, 0.74902, 0));
        u4.Debounce = tick() + 1;
        u4.SpinDebounce = tick() + 0.25;
        u4.Opening = false;
    end);
end;

function v1.KnitStart(u9) -- Line: 71
    -- upvalues: Knit (copy), LocalPlayer (copy), SfxManager (copy), CratesItems (copy), Customization (copy), MarketplaceService (copy), SeasonPass (copy), ReplicatedStorage (copy)
    local Controller = Knit.GetController("Shop");
    local Controller2 = Knit.GetController("Network");
    local Controller3 = Knit.GetController("EmotesController");
    local Service = Knit.GetService("CratesService");
    u9.UI = LocalPlayer.PlayerGui:WaitForChild("Crates");
    u9.HighlightPosition = Instance.new("NumberValue");
    u9.HighlightPosition.Value = 1;
    local u10 = 0;
    u9.HighlightPosition.Changed:Connect(function() -- Line: 84
        -- upvalues: u9 (copy), u10 (ref), SfxManager (ref)
        local math_ceil_ret = math.ceil(u9.HighlightPosition.Value);
        local v11;

        if math_ceil_ret > 8 then
            local v12 = math_ceil_ret % 8;
            v11 = v12 == 0 and 8 or v12;
        else
            v11 = math_ceil_ret <= 0 and 1 or math_ceil_ret;
        end;

        if v11 == u10 then
            return;
        end;

        u10 = v11;

        if u9.Opening then
            SfxManager:playSound({
                Sound = "Spin",
                Parent = workspace
            });
        end;

        for _, child in u9.UI.BG.MainFrame.Rewards:GetChildren() do
            if child:IsA("ImageLabel") then
                if tonumber(child.Name) == u10 then
                    child.Starburst.ImageColor3 = Color3.fromRGB(255, 255, 255);
                else
                    child.Starburst.ImageColor3 = Color3.fromRGB(0, 213, 255);
                end;
            end;
        end;
    end);

    for i, v in CratesItems.Rewards do
        local v13 = v[1];
        local v14 = v[2]:upper();
        local u15 = v[3];
        local v16 = v[4];
        local u17 = u9.UI.BG.MainFrame.Rewards:FindFirstChild(i);

        if u17 then
            if typeof(u15) == "number" and u15 > 0 then
                u17.TextFrame.Text.Text = `{u15} {v14}`;
            else
                u17.TextFrame.Text.Text = v14;
            end;

            if typeof(u15) == "table" then
                if u15.Type == "Emotes" then
                    task.spawn(function() -- Line: 131
                        -- upvalues: u17 (copy), Controller3 (copy), u15 (copy)
                        u17.Icon.ImageTransparency = 1;
                        u17.Icon.Position = UDim2.new(0.5, 0, 0.387, 0);
                        u17.Icon.Size = UDim2.new(0.944, 0, 0.7, 0);
                        local ViewportFrame = Instance.new("ViewportFrame", u17.Icon);
                        ViewportFrame.Size = UDim2.fromScale(1, 1);
                        ViewportFrame.Ambient = Color3.fromRGB(255, 255, 255);
                        ViewportFrame.BackgroundTransparency = 1;
                        ViewportFrame.ZIndex = u17.Icon.ZIndex;

                        while not Controller3.CharacterRig do
                            task.wait();
                        end;

                        Controller3:CreatePreview(u15.Name, ViewportFrame, Controller3.CharacterRig);
                    end);
                elseif u15.Type == "GoalEffects" then
                    u17.Icon.Image = Controller.GoalIcons[u15.Name] or "";
                elseif u15.Type == "ShotEffects" then
                    u17.Icon.Image = Controller.ShotIcons[u15.Name] or "";
                elseif u15.Type == "Cards" then
                    u17.Icon.Image = Controller.Cards[u15.Name] or "";
                else
                    local v18 = Customization[u15.Type][u15.Name];

                    if v18.IconId then
                        u17.Icon.Image = `rbxassetid://{v18.IconId}`;
                    end;
                end;
            else
                local v19 = CratesItems.Icons[v13];

                if v19 then
                    u17.Icon.Image = v19;

                    if v13:match("^Lucky") then
                        script.Rainbow:Clone().Parent = u17.Icon;
                    end;
                else
                    u17.Icon.Visible = false;
                end;
            end;

            u17.Chance.Text = `{v16}%`;
        end;
    end;

    u9.UI.BG.Open.Activated:Connect(function() -- Line: 179
        -- upvalues: u9 (copy), Controller2 (copy), MarketplaceService (ref), LocalPlayer (ref), Service (copy)
        if not u9.SpinDebounce or u9.SpinDebounce - tick() <= 0 then
            if u9.Opening then
                if not Controller2.Player.CanSkipCrates then
                    MarketplaceService:PromptGamePassPurchase(LocalPlayer, 1549557629);

                    return;
                end;

                if u9.Tween then
                    u9.Tween:Cancel();
                end;

                u9.Opening = false;

                return;
            end;

            u9.Opening = true;
            local v20, v21 = Service:OpenCrate();

            if v20 then
                u9:Open(v20, v21);

                return;
            end;

            u9.Opening = false;
        end;
    end);
    u9.UI.BG.TopFrame.Label.Text = `Use {SeasonPass.Items.Currency.DisplayName} to Open Crates!`;
    u9.SeasonPassData = Controller2.Player.SeasonPass;
    u9:DataUpdate();
    ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 213
        -- upvalues: u9 (copy), Controller2 (copy)
        if u9.SeasonPassData ~= Controller2.SeasonPass then
            u9.SeasonPassData = Controller2.Player.SeasonPass;
            u9:DataUpdate();
        end;
    end);
    u9.UI.BG.TabButtonsFrame.QuestsButton.Activated:Connect(function() -- Line: 220
        -- upvalues: u9 (copy), LocalPlayer (ref)
        u9.UI.Enabled = false;
        LocalPlayer.PlayerGui.Quests.Enabled = true;
    end);
    u9.UI.BG.TabButtonsFrame.SeasonPassButton.Activated:Connect(function() -- Line: 225
        -- upvalues: u9 (copy), LocalPlayer (ref)
        u9.UI.Enabled = false;
        LocalPlayer.PlayerGui.SeasonPass.Enabled = true;
    end);
    u9.UI.BG.TabButtonsFrame.CrateSpinsButton.Activated:Connect(function() -- Line: 230
        -- upvalues: u9 (copy), LocalPlayer (ref)
        u9.UI.Enabled = false;
        LocalPlayer.PlayerGui.CrateSpins.Enabled = true;
    end);
    u9.UI.BG.CurrencyCounter.PlusButton.Activated:Connect(function() -- Line: 235
        -- upvalues: u9 (copy), LocalPlayer (ref)
        u9.UI.Enabled = false;
        LocalPlayer.PlayerGui.SeasonPassCurrency.Enabled = true;
    end);
    u9.UI.BG.CloseButton.Activated:Connect(function() -- Line: 240
        -- upvalues: u9 (copy), LocalPlayer (ref)
        u9.UI.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = true;
    end);

    while true do
        if not (u9.Debounce and u9.Debounce - tick() > 0 or (u9.Opening or not u9.UI.Enabled)) then
            local HighlightPosition = u9.HighlightPosition;
            HighlightPosition.Value = HighlightPosition.Value + 1;
        end;

        task.wait(0.5);
    end;
end;

return v1;