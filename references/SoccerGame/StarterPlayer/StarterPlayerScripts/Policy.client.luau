  

local LocalPlayer = game:GetService("Players").LocalPlayer;

local function isRestricted() -- Line: 5
    -- upvalues: LocalPlayer (copy)
    local Attribute = LocalPlayer:GetAttribute("RNGRestricted");

    return Attribute == nil and true or Attribute == true;
end;

local function apply() -- Line: 10
    -- upvalues: LocalPlayer (copy)
    local Attribute = LocalPlayer:GetAttribute("RNGRestricted");
    local v1 = Attribute == nil and true or Attribute == true;
    local Shop = LocalPlayer.PlayerGui:FindFirstChild("Shop");

    if Shop then
        Shop = Shop:FindFirstChild("BG");
    end;

    if Shop then
        Shop = Shop:FindFirstChild("ShopUI");
    end;

    if Shop then
        Shop = Shop:FindFirstChild("Inside");
    end;

    if Shop then
        local Packs = Shop:FindFirstChild("Packs");

        if Packs then
            for _, v in { "Emotes", "Cards", "GoalEffects", "MVP" } do
                local v2 = Packs:FindFirstChild(v);

                if v2 then
                    for _, v3 in { "RobuxButton", "PriceButton", "Gift" } do
                        local v4 = v2:FindFirstChild(v3);

                        if v4 then
                            v4.Visible = not v1;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local Cards = workspace:FindFirstChild("Cards");

    if Cards then
        for _, child in Cards:GetChildren() do
            local Card = child:FindFirstChild("Card");

            if Card then
                local Proximity = Card:FindFirstChild("Proximity");

                if Proximity then
                    if Proximity:IsA("ProximityPrompt") then
                        Proximity.Enabled = not v1;
                    end;

                    for _, descendant in Proximity:GetDescendants() do
                        if descendant:IsA("ProximityPrompt") then
                            descendant.Enabled = not v1;
                        end;
                    end;
                end;

                local RootPart = Card:FindFirstChild("RootPart");

                if RootPart then
                    RootPart = RootPart:FindFirstChild("Robux");
                end;

                if RootPart then
                    RootPart.Enabled = not v1;
                end;
            end;
        end;
    end;
end;

LocalPlayer:GetAttributeChangedSignal("RNGRestricted"):Connect(apply);
task.spawn(function() -- Line: 59
    -- upvalues: apply (copy)
    while true do
        apply();
        task.wait(2);
    end;
end);