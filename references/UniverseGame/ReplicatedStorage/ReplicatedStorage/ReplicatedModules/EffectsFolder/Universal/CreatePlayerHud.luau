  

 

local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local PlayerHud = script.PlayerHud;
require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").PVEPackage.TraitHandler);
local Trove = require(game.ReplicatedStorage.ReplicatedModules.KnitPackage.Trove);
local ItemData = require(game.ReplicatedStorage.ReplicatedModules.ItemData);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local u1 = Knit.GetService("ChatRestrictionService");
local _ = {
    Common = Color3.fromRGB(225, 225, 225),
    Rare = Color3.fromRGB(75, 150, 255),
    Epic = Color3.fromRGB(175, 90, 255),
    Legendary = Color3.fromRGB(255, 150, 75),
    Mythic = Color3.fromRGB(255, 85, 0),
    Hexed = Color3.fromRGB(128, 0, 255)
};
local u2 = { "Vanished", "TimeErase" };
local u3 = {};

for _, v in u2 do
    CollectionService:GetInstanceAddedSignal(v):Connect(function(p4) -- Line: 40
        -- upvalues: u3 (copy)
        u3[p4].Enabled = false;
    end);
    CollectionService:GetInstanceRemovedSignal(v):Connect(function(p5) -- Line: 44
        -- upvalues: u3 (copy)
        u3[p5].Enabled = true;
    end);
end;

task.spawn(function() -- Line: 49
    -- upvalues: u3 (copy), u2 (copy), CollectionService (copy)
    local LocalPlayer = game.Players.LocalPlayer;
    local Settings = LocalPlayer:WaitForChild("Settings", 10);

    if not Settings then
        return;
    end;

    local HideAllPlayerHud = Settings:WaitForChild("HideAllPlayerHud", 5);

    if not HideAllPlayerHud then
        return;
    end;

    local function UpdateAllHuds(p6) -- Line: 56
        -- upvalues: u3 (ref), u2 (ref), CollectionService (ref), LocalPlayer (copy), Settings (copy)
        for i, v in u3 do
            if p6 then
                v.Enabled = false;
            else
                local v7 = false;

                for _, v2 in u2 do
                    if CollectionService:HasTag(i, v2) then
                        v7 = true;
                        break;
                    end;
                end;

                local v8 = game.Players:GetPlayerFromCharacter(i) == LocalPlayer;
                local v9 = Settings:FindFirstChild("ShowSelfHud") and Settings.ShowSelfHud.Value;
                local v10 = not (v7 or i:GetAttribute("NoPlayerHud")) and (not v8 or v9);
                v.Enabled = v10;
            end;
        end;
    end;

    UpdateAllHuds(HideAllPlayerHud.Value);
    HideAllPlayerHud.Changed:Connect(function(p11) -- Line: 81
        -- upvalues: UpdateAllHuds (copy)
        UpdateAllHuds(p11);
    end);
end);

return function(u12) -- Line: 86
    -- upvalues: PlayerHud (copy), u1 (copy), u3 (copy), Trove (copy), ItemData (copy), TweenService (copy)
    if u12:GetAttribute("NPC") then
        return;
    end;

    local HumanoidRootPart = u12:WaitForChild("HumanoidRootPart", (1 / 0));
    local Head = u12:WaitForChild("Head", (1 / 0));
    local u13 = game.Players:GetPlayerFromCharacter(u12) or u12;

    if HumanoidRootPart:FindFirstChild("PlayerHud") then
        HumanoidRootPart:FindFirstChild("PlayerHud"):Destroy();
    end;

    local Humanoid = u12:WaitForChild("Humanoid");
    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff;
    local u14 = PlayerHud:Clone();
    local Content = u14:WaitForChild("Content");
    u14.Adornee = HumanoidRootPart;
    local Health = Content.Health;
    local Percent = Health.Percent;
    local Shield = Health.Shield;
    task.defer(function() -- Line: 111
    end);

    if u13 and (u13:IsA("Player") and u13 == game.Players.LocalPlayer) then
        u14.PlayerToHideFrom = u13;

        if u13:FindFirstChild("Settings") and u13.Settings.ShowSelfHud.Value == true then
            u14.PlayerToHideFrom = nil;
        end;
    end;

    Content.Display.Text = Humanoid.DisplayName;
    local u15 = true;

    if u13 and (u13:IsA("Player") and u13 ~= game.Players.LocalPlayer) then
        task.spawn(function() -- Line: 136
            -- upvalues: u1 (ref), u13 (copy), u15 (ref), Content (copy), Humanoid (copy)
            u1:CanChatWith(u13.UserId):andThen(function(p16) -- Line: 137
                -- upvalues: u15 (ref), u13 (ref), Content (ref), Humanoid (ref)
                u15 = p16;
                warn((`[ChatRestriction] CanChatWith {u13.Name} ({u13.UserId}) -> {u15}`));

                if not u15 then
                    Content.Display.Text = `{Humanoid.DisplayName} 🔒`;
                end;
            end):catch(function(p17) -- Line: 143
                -- upvalues: u13 (ref)
                warn((`[ChatRestriction] Failed for {u13.Name} ({u13.UserId}): {p17}`));
            end);
        end);
    end;

    u14.Parent = HumanoidRootPart;
    Content.Display2.Text = "[ LVL 200 ] • [ ASC 0 ]";
    task.spawn(function() -- Line: 164
        -- upvalues: u13 (copy), Content (copy)
        local v18 = u13 and u13:WaitForChild("Data", 30);

        if v18 then
            v18 = v18:WaitForChild("Ability", 30);
        end;

        if v18 then
            Content.Display2.Text = `[ LVL {v18:GetAttribute("AbilityLevel") or 0} ]`;
            local Display2 = Content.Display2;
            Display2.Text = Display2.Text .. ` • [ ASC {v18:GetAttribute("AscensionRank") or 0} ]`;

            if v18:GetAttribute("Trait") then
                local v19 = v18:GetAttribute("Trait"):upper();

                if v18:GetAttribute("HexedTrait") then
                    v19 = `⭐ {v19} ⭐`;
                end;

                local Display22 = Content.Display2;
                Display22.Text = Display22.Text .. ` • [ {v19} ]`;
            end;
        end;
    end);
    u3[u12] = u14;
    local u20 = Trove.new();
    u20:Connect(u14.Destroying, function() -- Line: 189
        -- upvalues: u20 (copy)
        u20:Destroy();
    end);
    u20:Add(function() -- Line: 192
        -- upvalues: u3 (ref), u12 (copy)
        u3[u12] = nil;
    end);

    if u12:GetAttribute("TitleId") then
        local v21 = ItemData.GetTitle(u12:GetAttribute("TitleId"));
        local v22 = v21.DisplayName or v21.Name;

        if v21.NameCallback then
            v22 = v21.NameCallback(v21, {
                Player = u13
            });
        end;

        Content.Title.Font = v21.Font or script.PlayerHud.Content.Title.Font;

        if v21.FontFace then
            Content.Title.FontFace = v21.FontFace;
        end;

        Content.Title.Text = `{v22}`;
        Content.Title.TextColor3 = v21.Color or Content.Title.TextColor3;
        Content.Title.TextStrokeColor3 = v21.StrokeColor or script.PlayerHud.Content.Title.TextStrokeColor3;
        Content.Title.Visible = true;

        if v21.Callback then
            v21.Callback(Content, u12, u20, v21);
        end;
    else
        Content.Title.Visible = false;
        Content.Title.Text = "";
    end;

    local v23 = os.time() + 5;

    while not u14:IsDescendantOf(game) and os.time() <= v23 do
        task.wait(0.1);
    end;

    if not u14:IsDescendantOf(game) then
        u14:Destroy();

        return;
    end;

    local Health2 = Humanoid.Health;
    local MaxHealth = Humanoid.MaxHealth;
    local v24 = (u12:GetAttribute("Shield") or 0) / Humanoid.MaxHealth;
    local v25 = math.clamp(v24, 0, 1);
    local v26 = math.clamp(Health2 / Humanoid.MaxHealth, 0, 1);
    Percent.Size = UDim2.fromScale(v26, 1);
    Health.Fade.Size = UDim2.fromScale(v26, 1);
    Health.Shield.Size = UDim2.fromScale(v25, 1);
    local Fade = Health.Fade;
    local u27 = nil;
    u20:Connect(Humanoid.HealthChanged, function(p28) -- Line: 252
        -- upvalues: u14 (copy), u20 (copy), Humanoid (copy), TweenService (ref), Percent (copy), u27 (ref), Fade (copy), MaxHealth (ref), u12 (copy), Shield (copy)
        if not u14.Parent then
            u20:Destroy();

            return;
        end;

        local u29 = math.clamp(p28 / Humanoid.MaxHealth, 0, 1);
        TweenService:Create(Percent, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(u29, 1)
        }):Play();

        if u27 then
            task.cancel(u27);
        end;

        u27 = task.delay(0.8, function() -- Line: 262
            -- upvalues: TweenService (ref), Fade (ref), u29 (copy)
            TweenService:Create(Fade, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(u29, 1)
            }):Play();
        end);

        if Humanoid.MaxHealth ~= MaxHealth then
            MaxHealth = Humanoid.MaxHealth;
            local v30 = (u12:GetAttribute("Shield") or 0) / Humanoid.MaxHealth;
            local v31 = math.clamp(v30, 0, 1);
            TweenService:Create(Shield, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(v31, 1)
            }):Play();
        end;
    end);
    u20:Connect(Humanoid:GetPropertyChangedSignal("DisplayName"), function() -- Line: 274
        -- upvalues: Content (copy), u15 (ref), Humanoid (copy)
        local Display = Content.Display;
        local v32;

        if u15 then
            v32 = Humanoid.DisplayName;
        else
            v32 = `{Humanoid.DisplayName} 🔒`;
        end;

        Display.Text = v32;
    end);
    u20:Connect(u12:GetAttributeChangedSignal("Shield"), function() -- Line: 278
        -- upvalues: u12 (copy), Humanoid (copy), TweenService (ref), Shield (copy)
        local v33 = (u12:GetAttribute("Shield") or 0) / Humanoid.MaxHealth;
        local v34 = math.clamp(v33, 0, 1);
        TweenService:Create(Shield, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(v34, 1)
        }):Play();
    end);
    u20:Connect(Head:GetPropertyChangedSignal("Transparency"), function() -- Line: 284
        -- upvalues: u14 (copy), Head (copy)
        u14.Enabled = Head.Transparency < 1;
    end);
    u20:Connect(u12:GetAttributeChangedSignal("NoPlayerHud"), function() -- Line: 288
        -- upvalues: u14 (copy), u12 (copy)
        u14.Enabled = not u12:GetAttribute("NoPlayerHud");
    end);
end;