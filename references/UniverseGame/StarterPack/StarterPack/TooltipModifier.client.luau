  

 

local LocalPlayer = game.Players.LocalPlayer;

local function UpdateToolTip(p1) -- Line: 3
    if not p1:IsA("Tool") then
        return;
    end;

    if not p1:GetAttribute("Purity") then
        return;
    end;

    if p1.ToolTip:lower():find("purity") then
        return;
    end;

    p1.ToolTip = p1.ToolTip .. ` Purity: {p1:GetAttribute("Purity")}%`;
end;

LocalPlayer.Backpack.ChildAdded:Connect(UpdateToolTip);

for _, child in LocalPlayer.Backpack:GetChildren() do
    task.spawn(UpdateToolTip, child);
end;