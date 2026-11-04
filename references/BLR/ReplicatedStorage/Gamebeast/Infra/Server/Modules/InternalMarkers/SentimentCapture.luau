  

local v1 = {};
local TextService = game:GetService("TextService");
game:GetService("Players");
game:GetService("LocalizationService");
local Utilities = require(script.Parent.Parent.Utilities);
local ServerGate = require(script.Parent.Parent.ServerGate);
local EngagementMarkers = require(script.Parent.Parent.EngagementMarkers);

function v1.Init(p2) -- Line: 44
    -- upvalues: ServerGate (copy), TextService (copy), Utilities (copy), EngagementMarkers (copy)
    ServerGate:OnPlayerAdded(function(u3, p4) -- Line: 45
        -- upvalues: TextService (ref), Utilities (ref), EngagementMarkers (ref)
        p4:Add(u3.Chatted:Connect(function(u5) -- Line: 46
            -- upvalues: TextService (ref), u3 (copy), Utilities (ref), EngagementMarkers (ref)
            local v6 = nil;
            local success, result = pcall(function() -- Line: 50
                -- upvalues: TextService (ref), u5 (copy), u3 (ref)
                return TextService:FilterStringAsync(u5, u3.UserId, Enum.TextFilterContext.PublicChat):GetNonChatStringForBroadcastAsync();
            end);

            if not success then
                Utilities.GBLog("Chat message dropped, filtering failed:", result);

                return;
            end;

            if u3.Character and u3.Character.PrimaryPart then
                v6 = u3.Character.PrimaryPart.Position;
            end;

            EngagementMarkers:SDKMarker("Chat", {
                message = result
            }, {
                player = u3,
                position = v6
            });
        end));
    end);
end;

return v1;