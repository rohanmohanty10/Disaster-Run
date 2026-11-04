  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("PathfindingService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("TweenService");
game:GetService("GuiService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.TeamColors);
require(ReplicatedStorage.Shared.Essentials);
local LocalPlayer = Players.LocalPlayer;
local _ = ReplicatedStorage.Assets.Vfx;
local SpinHistory = LocalPlayer.PlayerGui:WaitForChild("SpinHistory");
local TextLabel = ReplicatedStorage.Assets.UI.StyleHistory.TextLabel;
local Popup = require(ReplicatedStorage.Shared.Popup);
local v1 = Knit.CreateController({
    Name = "StyleHistoryController"
});
local u2 = { "Holder", "Lead", "Lead Developer", "community admin", "Mod" };

function v1.Clear(p3) -- Line: 36
    -- upvalues: SpinHistory (copy)
    for _, child in SpinHistory.Frame.ScrollingFrame:GetChildren() do
        if child:IsA("TextLabel") then
            child:Destroy();
        end;
    end;
end;

function v1.Check(p4, p5) -- Line: 45
    -- upvalues: Popup (copy), TextLabel (copy), SpinHistory (copy)
    local History = p4.StyleHistoryService:GetHistory(p5);

    if History == nil then
        Popup.Popup(nil, "Style history failed to load");

        return;
    end;

    if #History ~= 0 then
        Popup.Popup(nil, "Style history loaded!");

        for _, v in History do
            local v6 = TextLabel:Clone();
            v6.Text = v;
            v6.Parent = SpinHistory.Frame.ScrollingFrame;
        end;

        return;
    end;

    local v7 = TextLabel:Clone();
    v7.Text = "No Mythic+ Style history yet";
    v7.Parent = SpinHistory.Frame.ScrollingFrame;
    Popup.Popup(nil, "No history");
end;

function v1.KnitStart(u8) -- Line: 70
    -- upvalues: LocalPlayer (copy), u2 (copy), Knit (copy), SpinHistory (copy), Popup (copy)
    local success, result = pcall(function() -- Line: 72
        -- upvalues: LocalPlayer (ref)
        return LocalPlayer:GetRoleInGroup(34671275);
    end);

    if not success then
        return;
    end;

    if not table.find(u2, result) then
        return;
    end;

    u8.StyleHistoryService = Knit.GetService("StyleHistoryService");
    game:GetService("UserInputService").InputBegan:Connect(function(p9, p10) -- Line: 82
        -- upvalues: u8 (copy), SpinHistory (ref)
        if p10 then
            return;
        end;

        if p9.KeyCode == Enum.KeyCode.H then
            u8:Clear();
            SpinHistory.Enabled = not SpinHistory.Enabled;
        end;
    end);
    SpinHistory.Check.Activated:Connect(function() -- Line: 93
        -- upvalues: SpinHistory (ref), Popup (ref), u8 (copy)
        local v11 = game.Players:FindFirstChild(SpinHistory.Frame.TextBox.Text);

        if not v11 then
            Popup.Popup(nil, "Player is not in game...");

            return;
        end;

        u8:Clear();
        Popup.Popup(nil, "Loading Style history...");
        u8:Check(v11);
        SpinHistory.Frame.TextBox.Text = "";
    end);
    SpinHistory.Close.Activated:Connect(function() -- Line: 105
        -- upvalues: SpinHistory (ref)
        SpinHistory.Enabled = false;
    end);
end;

return v1;