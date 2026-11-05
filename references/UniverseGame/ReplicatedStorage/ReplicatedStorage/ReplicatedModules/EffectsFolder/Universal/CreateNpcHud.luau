  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local NpcHud = script.NpcHud;
local Trove = require(game.ReplicatedStorage.ReplicatedModules.KnitPackage.Trove);
local _ = {
    Common = Color3.fromRGB(225, 225, 225),
    Rare = Color3.fromRGB(75, 150, 255),
    Epic = Color3.fromRGB(175, 90, 255),
    Legendary = Color3.fromRGB(255, 150, 75),
    Mythic = Color3.fromRGB(255, 85, 0),
    Hexed = Color3.fromRGB(128, 0, 255)
};

return function(u1) -- Line: 25
    -- upvalues: NpcHud (copy), RunService (copy), Trove (copy), TweenService (copy)
    if not u1:GetAttribute("NPC") then
        return;
    end;

    if not u1:WaitForChild("Head", 15) then
        return;
    end;

    local Ability = u1:WaitForChild("Data"):WaitForChild("Ability");
    local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    local _ = u1.Head;

    if HumanoidRootPart:FindFirstChild("NpcHud") then
        HumanoidRootPart:FindFirstChild("NpcHud"):Destroy();
    end;

    local Humanoid = u1:WaitForChild("Humanoid");
    local u2 = NpcHud:Clone();
    local Content = u2:WaitForChild("Content");
    u2.Adornee = HumanoidRootPart;
    task.defer(function() -- Line: 45
        -- upvalues: u1 (copy), u2 (copy)
        local v3 = u1:GetExtentsSize().Y / 2 + 1.5;
        local v4 = math.min(6, v3);
        u2.StudsOffsetWorldSpace = Vector3.new(0, v4, 0);
    end);
    local Health = Content.Health;
    local Fade = Health.Fade;
    local HealthDisplay = Health.HealthDisplay;
    local Percent = Health.Percent;
    Content.Display.Text = Humanoid.DisplayName;
    local DisplayName = Humanoid.DisplayName;

    if Ability:GetAttribute("AbilityLevel") then
        DisplayName = DisplayName .. `[ LVL {Ability:GetAttribute("AbilityLevel")} ]`;
    end;

    if Ability:GetAttribute("Trait") then
        DisplayName = DisplayName .. ` • [ {Ability:GetAttribute("Trait"):upper()} ]`;
    end;

    Content.Display.Text = DisplayName;
    u2.Parent = HumanoidRootPart;
    RunService.Heartbeat:Wait();

    if not u2:IsDescendantOf(game) then
        u2:Destroy();

        return;
    end;

    local v5 = Trove.new();
    v5:AttachToInstance(u2);
    local Health2 = Humanoid.Health;
    local MaxHealth = Humanoid.MaxHealth;
    local Shield = Health.Shield;
    local v6 = (u1:GetAttribute("Shield") or 0) / Humanoid.MaxHealth;
    local v7 = math.clamp(v6, 0, 1);
    math.clamp(Health2 / Humanoid.MaxHealth, 0, 1);
    Health.Shield.Size = UDim2.fromScale(v7, 1);
    local u8 = nil;
    local u9 = nil;
    u9 = Humanoid.HealthChanged:Connect(function(p10) -- Line: 114
        -- upvalues: u2 (copy), u9 (ref), Humanoid (copy), TweenService (ref), Percent (copy), u8 (ref), Fade (copy), HealthDisplay (copy), MaxHealth (ref), u1 (copy), Shield (copy)
        if p10 <= 0 then
            u2.Enabled = false;
            u9:Disconnect();
        end;

        if not u2.Parent then
            u9:Disconnect();

            return;
        end;

        local u11 = math.clamp(p10 / Humanoid.MaxHealth, 0, 1);
        TweenService:Create(Percent, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(u11, 1)
        }):Play();

        if u8 then
            task.cancel(u8);
        end;

        u8 = task.delay(0.8, function() -- Line: 151
            -- upvalues: TweenService (ref), Fade (ref), u11 (copy)
            TweenService:Create(Fade, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(u11, 1)
            }):Play();
        end);
        local v12 = math.clamp(p10, 0, Humanoid.MaxHealth);
        HealthDisplay.Text = math.round(v12) .. " / " .. Humanoid.MaxHealth .. " HP";

        if Humanoid.MaxHealth ~= MaxHealth then
            MaxHealth = Humanoid.MaxHealth;
            local v13 = (u1:GetAttribute("Shield") or 0) / Humanoid.MaxHealth;
            local v14 = math.clamp(v13, 0, 1);
            TweenService:Create(Shield, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(v14, 1)
            }):Play();
        end;
    end);
    v5:Add(u9);
    HealthDisplay.Text = math.round(Humanoid.Health) .. " / " .. Humanoid.MaxHealth .. " HP";
    v5:Connect(u1:GetAttributeChangedSignal("Shield"), function() -- Line: 167
        -- upvalues: u1 (copy), Humanoid (copy), TweenService (ref), Shield (copy)
        local v15 = (u1:GetAttribute("Shield") or 0) / Humanoid.MaxHealth;
        local v16 = math.clamp(v15, 0, 1);
        TweenService:Create(Shield, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = UDim2.fromScale(v16, 1)
        }):Play();
    end);
end;