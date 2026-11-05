  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local u1 = ReplicatedStorage["Client Assets"];
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(p2, u3, p4) -- Line: 8
    -- upvalues: u1 (copy), TweenService (copy), Trove (copy)
    local wait = task.wait;
    local v5 = p2:FindFirstChild("Head") or p2:FindFirstChild("Stand Head");

    if not v5 then
        return;
    end;

    if not v5:FindFirstChild("Quote Gui") then
        local v6 = u1.Taunt["Quote Gui"]:Clone();
        v6.Parent = v5;
        v6.Quote.Text = "";
    end;

    if v5:FindFirstChild("Quote Gui") and v5["Quote Gui"].Quote.Text ~= "" then
        return;
    end;

    local u7 = v5:FindFirstChild("Quote Gui");
    local Sound = Instance.new("Sound");
    u7.Quote.TextTransparency = 1;
    TweenService:Create(u7.Quote, TweenInfo.new(0.5), {
        TextTransparency = 0
    }):Play();
    Sound.Name = "QuoteSound";
    Sound.SoundId = u3[2];
    Sound.Volume = u3[4] or 0.5;
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
    Sound.RollOffMaxDistance = 200;
    Sound.RollOffMinDistance = 20;
    Sound.Parent = p2.PrimaryPart or p2.Head;
    os.clock();
    local u8 = nil;
    local u9 = Trove.new();
    u9:Add(Sound):Play();
    u9:Add(function() -- Line: 35
        -- upvalues: u7 (copy)
        u7.Quote.TextTransparency = 0;
        u7.Quote.Text = "";
    end);

    local function CleanUp() -- Line: 39
        -- upvalues: u8 (ref), wait (copy), u9 (copy)
        while not u8 do
            wait(0.1);
        end;

        u9:Destroy();
    end;

    u9:Connect(Sound.Ended, CleanUp);
    u9:Connect(Sound.Stopped, CleanUp);
    pcall(function() -- Line: 46
        -- upvalues: u3 (copy), wait (copy), u7 (copy)
        local v10 = u3[1];
        local v11 = u3[3];

        for i = 1, #v10 do
            if u3[6] then
                wait(u3[6]);
            else
                wait(0.03);
            end;

            u7.Quote.Text = string.sub(v10, 1, i);

            if type(v11) == "table" then
                for i2, v in pairs(v11) do
                    if string.match(u7.Quote.Text, i2) then
                        v11[i2] = nil;
                        wait(v);
                    end;
                end;
            end;
        end;

        if u3[5] then
            wait(u3[5]);

            return;
        end;

        wait(1.5);
    end);
    u8 = true;

    if p4 then
        while not u8 do
            wait(0.1);
        end;

        u9:Destroy();
    end;
end;