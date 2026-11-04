 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local CrateEvent = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Crates"):WaitForChild("CrateEvent");
local u1 = {
    [Enum.KeyCode.Seven] = "Draw",
    [Enum.KeyCode.Eight] = "Stab",
    [Enum.KeyCode.Nine] = "Dive",
    [Enum.KeyCode.KeypadSeven] = "Draw",
    [Enum.KeyCode.KeypadEight] = "Stab",
    [Enum.KeyCode.KeypadNine] = "Dive"
};
local u2 = (-1 / 0);
UserInputService.InputBegan:Connect(function(p3, p4) -- Line: 18
    -- upvalues: u1 (copy), UserInputService (copy), LocalPlayer (copy), u2 (ref), CrateEvent (copy)
    local v5 = u1[p3.KeyCode];

    if not v5 or (p4 or UserInputService:GetFocusedTextBox()) then
        return;
    end;

    if LocalPlayer:GetAttribute("InMatch") == true or (LocalPlayer:GetAttribute("GameRole") or "Lobby") ~= "Lobby" then
        return;
    end;

    if os.clock() - u2 < 0.55 then
        return;
    end;

    u2 = os.clock();
    CrateEvent:FireServer("KnifeAction", v5);
end);