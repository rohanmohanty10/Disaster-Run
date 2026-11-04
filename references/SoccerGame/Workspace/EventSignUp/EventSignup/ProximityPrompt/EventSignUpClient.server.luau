  

local SocialService = game:GetService("SocialService");
local script_Parent = script.Parent;
local Attribute = workspace:GetAttribute("nextEventId");

if not Attribute then
    workspace:GetAttributeChangedSignal("nextEventId"):Wait();
    Attribute = workspace:GetAttribute("nextEventId");
end;

local function updatePrompt(p1) -- Line: 9
    -- upvalues: script_Parent (copy)
    if p1 == Enum.RsvpStatus.Going then
        script.Parent.RemoteEvent:FireServer();
    end;

    script_Parent.Enabled = true;
end;

local success, result = pcall(function() -- Line: 17
    -- upvalues: SocialService (copy), Attribute (ref)
    return SocialService:GetEventRsvpStatusAsync(Attribute);
end);

if not success then
    warn("Failed to get RSVP status:", result);

    return;
end;

print("CurrentRsvpStatus:", result);
script_Parent.Triggered:Connect(function(p2) -- Line: 31
    -- upvalues: SocialService (copy), Attribute (ref), script_Parent (copy)
    if SocialService:PromptRsvpToEventAsync(Attribute) == Enum.RsvpStatus.Going then
        script.Parent.RemoteEvent:FireServer();
    end;

    script_Parent.Enabled = true;
end);
workspace:GetAttributeChangedSignal("nextEventId"):Connect(function() -- Line: 36
    -- upvalues: Attribute (ref)
    Attribute = workspace:GetAttribute("nextEventId");
end);