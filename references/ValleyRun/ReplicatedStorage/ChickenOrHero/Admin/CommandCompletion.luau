 

 

local CommandCatalog = require(script.Parent:WaitForChild("CommandCatalog"));
local v1 = {};
local u2 = { "OwnersFriend", "Collaborator", "Supporter", "Developer", "Tester", "Creator", "Artist", "Animator", "CommunityStar", "ValleyLegend", "OG", "EventChampion" };

function v1.suggest(p3, p4, p5, p6, p7, p8, p9) -- Line: 7
    -- upvalues: CommandCatalog (copy), u2 (copy)
    if type(p3) ~= "string" or #p3 > 512 then
        return {};
    end;

    local math_clamp_ret = math.clamp(p4 or #p3 + 1, 1, #p3 + 1);

    if p3:sub(1, 1) ~= ";" then
        p3 = ";" .. p3;
        math_clamp_ret = math_clamp_ret + 1;
    end;

    local v10, v11 = p3:sub(1, math_clamp_ret - 1):match("()(%S*)$");
    local u12 = p3:sub(1, (v10 or math_clamp_ret) - 1);
    local u13 = p3:sub(math_clamp_ret):gsub("^%S*", "");
    local v14 = {};
    local u15 = v11 or "";

    for i in u12:gmatch("%S+") do
        table.insert(v14, i);
    end;

    local u16 = {};

    local function add(p17, p18, p19) -- Line: 17
        -- upvalues: u15 (ref), u13 (copy), u12 (copy), u16 (copy)
        if p17:lower():sub(1, #u15) ~= u15:lower() then
            return;
        end;

        local v20 = u13:match("^%s") and "" or " ";
        local v21 = {
            Text = u12 .. p17 .. v20 .. u13,
            Cursor = #u12 + #p17 + (u13:match("^%s") and 1 or #v20) + 1,
            Label = p18 or p17,
            Detail = p19 or ""
        };
        table.insert(u16, v21);
    end;

    if #v14 == 0 then
        if u15:sub(1, 1) ~= ";" then
            u15 = ";" .. u15;
        end;

        for _, v in CommandCatalog.Commands do
            if CommandCatalog.allowed(p5, v.Name, p7, p8) then
                add(";" .. v.Name, ";" .. v.Name .. " " .. v.Usage, v.Description);
            end;
        end;
    else
        local v22 = v14[1]:gsub("^;", ""):lower();
        local v23 = CommandCatalog.find(v22);

        if not (v23 and CommandCatalog.allowed(p5, v23.Name, p7, p8)) then
            return {};
        end;

        local v24 = v23.Args[#v14];

        if v24 == "player" then
            add("me", "me", "Your own character");

            for _, v in p6 do
                if v.Name:lower():sub(1, #u15) == u15:lower() then
                    add(v.Name, v.Name, v.DisplayName);
                elseif v.DisplayName:lower():sub(1, #u15) == u15:lower() then
                    local v25 = u15;
                    u15 = "";
                    add(v.Name, v.Name, v.DisplayName);
                    u15 = v25;
                end;
            end;
        elseif v24 == "skin" then
            local SkinCatalog = require(script.Parent.Parent.Weapons.SkinCatalog);

            for _, v in SkinCatalog.Order do
                local v26 = SkinCatalog.get(v);

                if v26 then
                    if v:lower():sub(1, #u15) == u15:lower() then
                        add(v, v, v26.Name);
                    elseif v26.Name:lower():sub(1, #u15) == u15:lower() then
                        local v27 = u15;
                        u15 = "";
                        add(v, v, v26.Name);
                        u15 = v27;
                    end;
                end;
            end;
        elseif v24 == "map" then
            add("off", "off", "Players vote on the map again");
            local u28 = script.Parent.Parent:FindFirstChild("Game") and script.Parent.Parent.Game:FindFirstChild("MapCatalog");
            local success, result = pcall(function() -- Line: 54
                -- upvalues: u28 (copy)
                return game:GetService("HttpService"):JSONDecode(u28.Value);
            end);

            if success and type(result) == "table" then
                for _, v in result do
                    if type(v) == "table" and type(v.id) == "string" then
                        add(v.id, v.id, (tostring(v.name or v.id)));
                    end;
                end;
            end;
        elseif v24 == "emote" then
            for _, v in require(script.Parent.Parent.Emotes.EmoteCatalog).Entries do
                if not v.Ultimate then
                    if v.Id:lower():sub(1, #u15) == u15:lower() then
                        add(v.Id, v.Id, v.Name);
                    elseif v.Name:lower():sub(1, #u15) == u15:lower() then
                        local v29 = u15;
                        u15 = "";
                        add(v.Id, v.Id, v.Name);
                        u15 = v29;
                    end;
                end;
            end;
        elseif v24 == "tier" then
            local CreatorRank = CommandCatalog.CreatorRank;

            if v23.Name == "setrank" then
                add("none", "none", "Remove their staff rank");

                if #u16 < #u16 then
                    u16[#u16].Order = -1;
                end;
            end;

            for _, v in { CommandCatalog.TesterRank, CreatorRank } do
                if CommandCatalog.allows(p5, v == CreatorRank and "staff.creator" or "staff.titles", p8) and (v.Name:lower():sub(1, #u15) == u15:lower() or CommandCatalog.rank(u15) == v) then
                    local v30 = u15;
                    u15 = "";
                    add(v.Name, v.Name .. (v == CreatorRank and " · creator tools" or " · title only"), v.Description);
                    u15 = v30;
                    u16[#u16].Order = 0;
                end;
            end;

            for _, v in CommandCatalog.Tiers do
                if v.Level < 5 and (p5 >= 5 or CommandCatalog.allows(p5, "staff.ranks", p8) and v.Level < p5) then
                    local v31 = CommandCatalog.tier(u15);

                    if v.Name:lower():sub(1, #u15) == u15:lower() or (tostring(v.Level):sub(1, #u15) == u15 or v31 and v31.Level == v.Level) then
                        local v32 = u15;
                        u15 = "";
                        add(v.Name, v.Level .. " · " .. v.Name, v.Description);
                        u15 = v32;
                        u16[#u16].Order = v.Level;
                    end;
                end;
            end;
        elseif v24 == "duration" then
            local v33 = CommandCatalog.banSeconds(p5, p8);

            if v23.Name == "softban" then
                v33 = v33 == -1 and CommandCatalog.SoftbanDays * 86400 or (math.min(v33, CommandCatalog.SoftbanDays * 86400) or v33);
            end;

            for _, v in v23.Name == "softban" and ({ "1", "2", "3" } or { "1", "3", "7", "30", "365", "perm" }) or { "1", "3", "7", "30", "365", "perm" } do
                local v34 = v == "perm" and -1 or tonumber(v) * 86400;

                if v33 == -1 or v34 ~= -1 and v34 <= v33 then
                    add(v, v, v == "perm" and "Permanent" or "Days");
                end;
            end;
        elseif v24 == "title" then
            for _, v in u2 do
                add(v, v, "Cosmetic only — no commands");
            end;
        elseif v24 == "toggle" then
            add("on", "on", "Stay in lobby");
            add("off", "off", "Join the next match");
        elseif v24 == "seconds" then
            for _, v in { "15", "30", "60", "120" } do
                add(v, v, v .. " seconds");
            end;
        elseif v24 == "notice" then
            for _, v in { "10", "30", "60", "120" } do
                add(v, v, v .. " seconds before refresh");
            end;
        elseif v24 == "command" then
            for _, v in CommandCatalog.Commands do
                if CommandCatalog.allowed(p5, v.Name, p7, p8) then
                    add(v.Name, v.Name, v.Description);
                end;
            end;
        end;
    end;

    table.sort(u16, function(p35, p36) -- Line: 103
        return (p35.Order or 99) == (p36.Order or 99) and p35.Label:lower() < p36.Label:lower() and true or (p35.Order or 99) < (p36.Order or 99);
    end);

    while (p9 or 6) < #u16 do
        table.remove(u16);
    end;

    return u16;
end;

return v1;