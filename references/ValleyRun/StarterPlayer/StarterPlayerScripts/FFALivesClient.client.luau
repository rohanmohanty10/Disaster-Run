 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local Session = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("Session");
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "FFALives";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 63;
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "Lives";
TextLabel.AnchorPoint = Vector2.new(1, 0.5);
TextLabel.Position = UDim2.fromScale(0.98, 0.44);
TextLabel.Size = UDim2.fromScale(0.19, 0.09);
TextLabel.BackgroundTransparency = 1;
TextLabel.TextColor3 = Color3.fromRGB(255, 218, 138);
TextLabel.TextStrokeTransparency = 0.25;
TextLabel.Font = Enum.Font.GothamBold;
TextLabel.TextScaled = true;
TextLabel.TextWrapped = true;
TextLabel.Parent = ScreenGui;
local u1 = true;
local u2 = {};
local u3 = nil;

local function render() -- Line: 25
    -- upvalues: u3 (ref), LocalPlayer (copy), TextLabel (copy), Session (copy), u1 (ref), render (copy)
    if u3 then
        task.cancel(u3);
        u3 = nil;
    end;

    local Attribute = LocalPlayer:GetAttribute("FFALives");
    local v4;

    if Session:GetAttribute("AdminMatchMode") == "FFACatchers" and type(Attribute) == "number" then
        v4 = Attribute > 0;
    else
        v4 = false;
    end;

    TextLabel.Visible = v4;

    if not TextLabel.Visible then
        return;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v5 = LocalPlayer:GetAttribute("FFADownUntil") or 0;
    local v6 = LocalPlayer:GetAttribute("FFAImmuneUntil") or 0;
    local v7 = ServerTimeNow < v5 and "GET UP IN " .. math.ceil(v5 - ServerTimeNow) or (ServerTimeNow < v6 and ("INVINCIBLE · " .. math.ceil(v6 - ServerTimeNow) or "LAST ONE STANDING") or "LAST ONE STANDING");
    TextLabel.Text = string.format("%d / 3 LIVES\n%s", Attribute, v7);
    TextLabel.TextColor3 = ServerTimeNow < v6 and Color3.fromRGB(110, 220, 255) or Color3.fromRGB(255, 218, 138);
    local v8 = ServerTimeNow < v5 and v5 and v5 or (ServerTimeNow < v6 and v6 and v6 or nil);

    if v8 then
        local v9 = v8 - ServerTimeNow;
        local v10 = v9 - (math.ceil(v9) - 1) + 0.02;
        u3 = task.delay(math.clamp(v10, 0.05, 1.02), function() -- Line: 47
            -- upvalues: u3 (ref), u1 (ref), render (ref)
            u3 = nil;

            if u1 then
                render();
            end;
        end);
    end;
end;

for _, v in { "FFALives", "FFADownUntil", "FFAImmuneUntil" } do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u2, AttributeChangedSignal:Connect(render));
end;

local AttributeChangedSignal = Session:GetAttributeChangedSignal("AdminMatchMode");
table.insert(u2, AttributeChangedSignal:Connect(render));
script.Destroying:Connect(function() -- Line: 59
    -- upvalues: u1 (ref), u3 (ref), u2 (copy), ScreenGui (copy)
    u1 = false;

    if u3 then
        task.cancel(u3);
        u3 = nil;
    end;

    for _, v in u2 do
        v:Disconnect();
    end;

    ScreenGui:Destroy();
end);
render();