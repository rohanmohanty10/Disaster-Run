  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observers = require(ReplicatedStorage.Packages.Observers);
local makePlayerModel = require(ReplicatedStorage.Shared.utils.makePlayerModel);
local Emotes = require(ReplicatedStorage.Shared.Emotes.Emotes);

return Observers.observeTag("EmoteViewport", function(u1: userdata) -- Line: 7
    -- upvalues: Emotes (copy), makePlayerModel (copy)
    local u2 = false;
    local u3 = nil;
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = u1;
    local u4 = nil;

    local function updatePlayingEmote() -- Line: 16
        -- upvalues: u3 (ref), u1 (copy), u4 (ref), Emotes (ref)
        if not u3 then
            return;
        end;

        local Attribute = u1:GetAttribute("Emote");

        if Attribute == "" then
            Attribute = nil;
        end;

        if u4 then
            u4();
            u4 = nil;
        end;

        if not Attribute then
            u3:PivotTo(CFrame.new(0, 100, 0));

            return;
        end;

        if not Emotes[Attribute] then
            print(u1);
            error((`invalid emote "{Attribute}"`));
        end;

        u4 = Emotes[Attribute].play(u3, "VisualUI");
        u3:PivotTo(CFrame.new(0, -3, -5) * CFrame.Angles(0, 3.141592653589793, 0));
    end;

    local u5 = u1:GetAttributeChangedSignal("Emote"):Connect(updatePlayingEmote);
    task.spawn(function() -- Line: 45
        -- upvalues: u3 (ref), makePlayerModel (ref), u2 (ref), WorldModel (copy), updatePlayingEmote (copy)
        u3 = makePlayerModel(true);

        if not u2 then
            u3:PivotTo(CFrame.new(0, 100, 0));
            u3.Parent = WorldModel;
            updatePlayingEmote();
        end;
    end);

    return function() -- Line: 54
        -- upvalues: u2 (ref), WorldModel (copy), u5 (copy)
        u2 = true;
        WorldModel:Destroy();
        u5:Disconnect();
    end;
end, { game.Players, workspace });