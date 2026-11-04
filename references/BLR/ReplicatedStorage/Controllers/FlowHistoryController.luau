  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local FlowSpinHistory = LocalPlayer.PlayerGui:WaitForChild("FlowSpinHistory");
local TextLabel = ReplicatedStorage.Assets.UI.FlowHistory.TextLabel;
local Popup = require(ReplicatedStorage.Shared.Popup);
local v1 = Knit.CreateController({
    Name = "FlowHistoryController"
});
local u2 = { "Holder", "Lead", "Lead Developer", "community admin", "Mod" };

function v1.Clear(p3) -- Line: 26
    -- upvalues: FlowSpinHistory (copy)
    for _, child in FlowSpinHistory.Frame.ScrollingFrame:GetChildren() do
        if child:IsA("TextLabel") then
            child:Destroy();
        end;
    end;
end;

function v1.Check(p4, p5) -- Line: 33
    -- upvalues: Popup (copy), TextLabel (copy), FlowSpinHistory (copy)
    local History = p4.FlowHistoryService:GetHistory(p5);

    if History == nil then
        Popup.Popup(nil, "Flow history failed to load");

        return;
    end;

    if #History ~= 0 then
        Popup.Popup(nil, "Flow history loaded!");

        for _, v in History do
            local v6 = TextLabel:Clone();
            v6.Text = v;
            v6.Parent = FlowSpinHistory.Frame.ScrollingFrame;
        end;

        return;
    end;

    local v7 = TextLabel:Clone();
    v7.Text = "No Mythic+ Flow history yet";
    v7.Parent = FlowSpinHistory.Frame.ScrollingFrame;
    Popup.Popup(nil, "No history");
end;

function v1.KnitStart(u8) -- Line: 58
    -- upvalues: LocalPlayer (copy), u2 (copy), Knit (copy), FlowSpinHistory (copy), Popup (copy)
    local success, result = pcall(function() -- Line: 59
        -- upvalues: LocalPlayer (ref)
        return LocalPlayer:GetRoleInGroup(34671275);
    end);

    if not success then
        return;
    end;

    if not table.find(u2, result) then
        return;
    end;

    u8.FlowHistoryService = Knit.GetService("FlowHistoryService");
    game:GetService("UserInputService").InputBegan:Connect(function(p9, p10) -- Line: 68
        -- upvalues: u8 (copy), FlowSpinHistory (ref)
        if p10 then
            return;
        end;

        if p9.KeyCode == Enum.KeyCode.J then
            u8:Clear();
            FlowSpinHistory.Enabled = not FlowSpinHistory.Enabled;
        end;
    end);
    FlowSpinHistory.Check.Activated:Connect(function() -- Line: 77
        -- upvalues: FlowSpinHistory (ref), Popup (ref), u8 (copy)
        local v11 = game.Players:FindFirstChild(FlowSpinHistory.Frame.TextBox.Text);

        if not v11 then
            Popup.Popup(nil, "Player is not in game...");

            return;
        end;

        u8:Clear();
        Popup.Popup(nil, "Loading Flow history...");
        u8:Check(v11);
        FlowSpinHistory.Frame.TextBox.Text = "";
    end);
    FlowSpinHistory.Close.Activated:Connect(function() -- Line: 88
        -- upvalues: FlowSpinHistory (ref)
        FlowSpinHistory.Enabled = false;
    end);
end;

return v1;