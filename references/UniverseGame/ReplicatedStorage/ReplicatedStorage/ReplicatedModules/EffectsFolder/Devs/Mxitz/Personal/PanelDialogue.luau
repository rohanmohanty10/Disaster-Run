  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local TableUtil = require(ReplicatedStorage.ReplicatedRoot.Libraries.Utility.TableUtil);
local PsuedoDebris = require(ReplicatedStorage.ReplicatedModules.RandomMxitzUtilities.PsuedoDebris);
local u1 = table.freeze({
    Text = "?",
    Lifetime = 3,
    DoTweenIn = true,
    TweenOut = {
        EasingStyle = Enum.EasingStyle.Sine,
        EasingDirection = Enum.EasingDirection.Out
    },
    TweenIn = {
        EasingStyle = Enum.EasingStyle.Sine,
        EasingDirection = Enum.EasingDirection.Out
    },
    Position = UDim2.fromScale(0.3, 0.5)
});
local Dialogue = script.Dialogue;
local Template = script.Template;

return function(p2) -- Line: 55
    -- upvalues: Dialogue (copy), TableUtil (copy), u1 (copy), Template (copy), TweenService (copy), PsuedoDebris (copy)
    local v3 = typeof(p2) == "table";
    assert(v3, "no data provided");
    local v4 = typeof(p2.Adornee) == "Instance";
    assert(v4, "invalid data, adornee is not an instance");
    local v5 = typeof(p2.Panels) == "table";
    assert(v5, "invalid data, no panels provided");
    local v6 = Dialogue:Clone();
    local v7 = 0;

    for _, v in p2.Panels do
        local v8 = typeof(v) == "table";
        assert(v8, "invalid panel data, not a table");
        local v9 = TableUtil.Reconcile(v, u1);
        v7 = math.max(v7, v9.Lifetime);
        local u10 = Template:Clone();
        u10.Sub.Text = v9.Text;
        local v11;

        if v9.StartingPosition then
            v11 = v9.StartingPosition;
        else
            v11 = v9.Position;
        end;

        u10.Position = v11;

        if v9.DoTweenIn then
            u10.BackgroundTransparency = 1;
            u10.Sub.TextTransparency = 1;
            local v12 = TweenInfo.new(v9.TweenIn.TweenDuration or v9.Lifetime, v9.TweenIn.EasingStyle, v9.TweenIn.EasingDirection);
            TweenService:Create(u10.Sub, v12, {
                TextTransparency = 0
            }):Play();
            TweenService:Create(u10, v12, {
                BackgroundTransparency = 0,
                Position = v9.Position
            }):Play();
        end;

        local u13 = TweenInfo.new(v9.TweenOut.TweenDuration or v9.Lifetime, v9.TweenOut.EasingStyle, v9.TweenOut.EasingDirection);

        if v9.TweenDelay and v9.TweenDelay > 0 then
            task.delay(v9.TweenDelay, function() -- Line: 93
                -- upvalues: u10 (copy), TweenService (ref), u13 (copy)
                if not (u10 and u10.Sub) then
                    return;
                end;

                TweenService:Create(u10.Sub, u13, {
                    TextTransparency = 1
                }):Play();
                TweenService:Create(u10, u13, {
                    BackgroundTransparency = 1
                }):Play();
            end);
        else
            TweenService:Create(u10.Sub, u13, {
                TextTransparency = 1
            }):Play();
            TweenService:Create(u10, u13, {
                BackgroundTransparency = 1
            }):Play();
        end;

        u10.Parent = v6;
    end;

    if v7 == 0 then
        v6:Destroy();
        warn("nothing had a lifetime or it was js below 0 wth dude...");

        return;
    end;

    v6.Adornee = p2.Adornee;
    v6.Parent = p2.Adornee;
    PsuedoDebris(v6, v7);
end;