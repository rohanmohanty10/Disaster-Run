 
 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local script_Parent = script.Parent;

function isWeekend()
    local os_date_ret = os.date("%A");

    return table.find({ "Saturday", "Sunday" }, os_date_ret);
end;

local function isDisabled() -- Line: 14
    -- upvalues: ReplicatedStorage (copy)
    local workspace = ReplicatedStorage:FindFirstChild("workspace");

    if workspace and workspace:FindFirstChild("disabled") then
        return workspace.disabled.Value;
    end;

    return false;
end;

local function isInGame() -- Line: 20
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character and (Character:FindFirstChild("state") and Character.state:FindFirstChild("ingame")) then
        return Character.state.ingame.Value;
    end;

    return false;
end;

local u1 = {};
local u2 = {};

local function stylecurrency_update() -- Line: 31
    -- upvalues: u1 (copy), LocalPlayer (copy), u2 (copy), TweenService (copy)
    if u1.style_currency then
        if u2.style_currency then
            u2.style_currency:Pause();
            u2.style_currency = nil;
        end;

        u2.style_currency = TweenService:Create(u1.style_currency, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = LocalPlayer:GetAttribute("style_currency")
        }):Play();

        return;
    end;

    u1.style_currency = Instance.new("NumberValue");
    u1.style_currency.Value = LocalPlayer:GetAttribute("style_currency");
end;

local function money_update() -- Line: 46
    -- upvalues: u1 (copy), LocalPlayer (copy), u2 (copy), TweenService (copy)
    if u1.money then
        if u2.money then
            u2.money:Pause();
            u2.money = nil;
        end;

        u2.money = TweenService:Create(u1.money, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = LocalPlayer:GetAttribute("money")
        }):Play();

        return;
    end;

    u1.money = Instance.new("NumberValue");
    u1.money.Value = LocalPlayer:GetAttribute("money");
end;

LocalPlayer:GetAttributeChangedSignal("style_currency"):Connect(stylecurrency_update);
LocalPlayer:GetAttributeChangedSignal("money"):Connect(money_update);

if LocalPlayer:GetAttribute("money") then
    money_update();
end;

if LocalPlayer:GetAttribute("style_currency") then
    stylecurrency_update();
end;

RunService.Heartbeat:Connect(function() -- Line: 71
    -- upvalues: LocalPlayer (copy), script_Parent (copy), ReplicatedStorage (copy), u1 (copy)
    local v3 = LocalPlayer:FindFirstChild("setting") and (LocalPlayer.setting:FindFirstChild("CurrencyUI") and LocalPlayer.setting.CurrencyUI.Value) and true or false;

    if v3 then
        local workspace = ReplicatedStorage:FindFirstChild("workspace");
        local v4;

        if workspace and workspace:FindFirstChild("disabled") then
            v4 = workspace.disabled.Value;
        else
            v4 = false;
        end;

        if v4 then
            local Character = LocalPlayer.Character;

            if Character and (Character:FindFirstChild("state") and Character.state:FindFirstChild("ingame")) then
                v4 = Character.state.ingame.Value;
            else
                v4 = false;
            end;
        end;

        v3 = not v4;
    end;

    script_Parent.Enabled = v3;

    if u1.style_currency and u1.money then
        script_Parent.Currency.Text = `$ {math.floor(u1.style_currency.Value)}`;
        script_Parent.Cash.Text = `$ {math.floor(u1.money.Value)}`;
    end;

    if not isWeekend() then
        script_Parent.Weekend.Visible = false;

        return;
    end;

    script_Parent.Weekend.Visible = true;
    script_Parent.Weekend.Text = string.format("Weekend bonus! (%sx)", (tostring("1.5")));
end);