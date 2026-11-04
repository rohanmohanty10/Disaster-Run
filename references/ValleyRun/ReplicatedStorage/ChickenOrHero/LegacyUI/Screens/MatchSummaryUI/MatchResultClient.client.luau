 

 

local StarterGui = game:GetService("StarterGui");
local UserInputService = game:GetService("UserInputService");
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");
local script_Parent = script.Parent;

if not game:IsLoaded() then
    game.Loaded:Wait();
end;

local UI = StarterGui:WaitForChild("UI", 30);

if UI then
    UI = UI:WaitForChild("HolderFrame", 30);
end;

if UI then
    UI = UI:WaitForChild("MatchResult", 30);
end;

if not UI then
    warn("MatchResultClient: StarterGui.UI.HolderFrame.MatchResult is missing, so there is no match recap");

    return;
end;

UI.Parent = script_Parent:WaitForChild("HolderFrame");
local u1;

if UI:FindFirstChildOfClass("UIScale") then
    u1 = nil;
else
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "TouchScale";
    UIScale.Scale = UserInputService.PreferredInput == Enum.PreferredInput.Touch and 1.15 or 1.25;
    UIScale.Parent = UI;
    u1 = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 33, Name: fit
        -- upvalues: UIScale (copy), UserInputService (copy)
        UIScale.Scale = UserInputService.PreferredInput == Enum.PreferredInput.Touch and 1.15 or 1.25;
    end);
end;

script.Destroying:Connect(function() -- Line: 40
    -- upvalues: u1 (ref)
    if u1 then
        u1:Disconnect();
        u1 = nil;
    end;
end);
local success, result = pcall(function() -- Line: 48
    -- upvalues: ChickenOrHero (copy), script_Parent (copy)
    require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("Features"):WaitForChild("MatchResultPanel")).start(script_Parent);
end);

if not success then
    warn("MatchResultClient: the match recap failed to start: " .. tostring(result));
end;