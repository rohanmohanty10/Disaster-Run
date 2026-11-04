 

 

local u1 = {
    Tiers = {
        {
            Name = "Helper",
            DisplayName = "Helper",
            Level = 1,
            Description = "Player lookup, server status and help."
        },
        {
            Name = "Moderator",
            DisplayName = "Moderator",
            Level = 2,
            Description = "Warnings, kicks and player recovery. Cannot manage matches or ban."
        },
        {
            Name = "SeniorMod",
            DisplayName = "Senior Mod",
            Level = 2.5,
            BanDays = 3,
            Description = "Moderator tools plus ;softban (up to 3 days). No leaderboard wipes."
        },
        {
            Name = "Admin",
            DisplayName = "Admin",
            Level = 3,
            BanDays = 7,
            Description = "Server announcements, match controls, lobby tools and bans up to 7 days."
        },
        {
            Name = "SeniorAdmin",
            DisplayName = "Senior Admin",
            Level = 3.5,
            BanDays = 30,
            Wipe = true,
            SetRank = true,
            Description = "Admin tools, bans up to 30 days with leaderboard wipes, and ;setrank for lower ranks."
        },
        {
            Name = "HeadAdmin",
            DisplayName = "Head Admin",
            Level = 4,
            BanDays = -1,
            Wipe = true,
            SetRank = true,
            Description = "Permanent bans, unbans, leaderboard wipes and ;setrank for lower ranks."
        },
        {
            Name = "OwnerAdmin",
            DisplayName = "Owner Admin",
            Level = 4.5,
            BanDays = -1,
            Wipe = true,
            SetRank = true,
            Description = "Everything a Head Admin has, plus editing staff permissions. Only an owner gives this rank."
        },
        {
            Name = "Owner",
            DisplayName = "Owner",
            Level = 5,
            BanDays = -1,
            Wipe = true,
            SetRank = true,
            Description = "All commands, any rank, global operations. Cannot be assigned."
        }
    }
};

function u1.tierAt(p2) -- Line: 68
    -- upvalues: u1 (copy)
    local v3 = nil;

    for _, v in u1.Tiers do
        if type(p2) == "number" and v.Level <= p2 then
            v3 = v;
        end;
    end;

    return v3;
end;

function u1.banLimit(p4) -- Line: 78
    -- upvalues: u1 (copy)
    local v5 = u1.tierAt(p4);

    if v5 then
        v5 = v5.BanDays;
    end;

    return v5 == -1 and -1 or (v5 or 0) * 86400;
end;

function u1.canWipe(p6) -- Line: 83
    -- upvalues: u1 (copy)
    local v7 = u1.tierAt(p6);
    local v8;

    if v7 == nil then
        v8 = false;
    else
        v8 = v7.Wipe == true;
    end;

    return v8;
end;

function u1.canSetRank(p9) -- Line: 87
    -- upvalues: u1 (copy)
    local v10 = u1.tierAt(p9);
    local v11;

    if v10 == nil then
        v11 = false;
    else
        v11 = v10.SetRank == true;
    end;

    return v11;
end;

u1.SoftbanDays = 3;
u1.GuardExemptLevel = 2.5;
u1.CreatorRank = {
    Name = "ContentCreator",
    Level = 0,
    Creator = true,
    Description = "Title and filming camera only: CONTENT CREATOR above their name. No commands."
};
u1.TesterRank = {
    Name = "Tester",
    Level = 0,
    Tester = true,
    Description = "Title only: TESTER above their name. No commands."
};
u1.TitleRankLevel = 2;

function u1.rank(p12) -- Line: 113
    -- upvalues: u1 (copy)
    local v13 = tostring(p12 or ""):lower():gsub("[%s_-]", "");

    if v13 == "contentcreator" or (v13 == "creator" or (v13 == "promoter" or v13 == "promotionalist")) then
        return u1.CreatorRank;
    end;

    if v13 == "tester" then
        return u1.TesterRank;
    end;

    return u1.tier(p12);
end;

u1.Aliases = {
    giftknife = "giftdagger",
    giftskin = "giftdagger",
    cmds = "help",
    commands = "help",
    staff = "admins",
    rank = "setrank",
    admin = "setrank",
    setadmin = "setrank",
    unadmin = "unrank",
    ranks = "tiers",
    re = "respawn",
    m = "announce",
    tp = "goto",
    restart = "restartserver",
    refresh = "restartserver",
    refreshserver = "restartserver",
    refreshglobal = "restartglobal",
    shutdowngame = "restartglobal",
    shutdownglobal = "restartglobal",
    update = "updategame",
    unlock = "unlockserver",
    lock = "lockserver",
    cancelupdate = "cancelglobal",
    serverinfo = "status",
    cmdhistory = "history",
    phistory = "playerhistory",
    bans = "playerhistory"
};
u1.Commands = {
    {
        Name = "globalspin",
        Level = 5,
        Usage = "",
        Description = "Give every online player across all servers one free wheel spin.",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "sparkles",
        Level = 5,
        CreatorOnly = true,
        Usage = "<player> [seconds]",
        Description = "Surround a player with short-lived stars.",
        ReadOnly = false,
        Args = { "player", "seconds" }
    },
    {
        Name = "fire",
        Level = 5,
        CreatorOnly = true,
        Usage = "<player> [seconds]",
        Description = "A harmless fire effect; does not damage health.",
        ReadOnly = false,
        Args = { "player", "seconds" }
    },
    {
        Name = "confetti",
        Level = 5,
        CreatorOnly = true,
        Usage = "<player> [seconds]",
        Description = "Celebrate someone with a burst of colour.",
        ReadOnly = false,
        Args = { "player", "seconds" }
    },
    {
        Name = "rainbow",
        Level = 5,
        CreatorOnly = true,
        Usage = "<player> [seconds]",
        Description = "Cycle a player\'s avatar colours.",
        ReadOnly = false,
        Args = { "player", "seconds" }
    },
    {
        Name = "ghost",
        Level = 5,
        CreatorOnly = true,
        Usage = "<player> [seconds]",
        Description = "Make an avatar almost invisible temporarily.",
        ReadOnly = false,
        Args = { "player", "seconds" }
    },
    {
        Name = "bighead",
        Level = 5,
        CreatorOnly = true,
        Usage = "<player> [seconds]",
        Description = "Temporarily enlarge someone\'s head.",
        ReadOnly = false,
        Args = { "player", "seconds" }
    },
    {
        Name = "spin",
        Level = 5,
        CreatorOnly = true,
        Usage = "<player> [seconds]",
        Description = "Turn a character into a short, spinning spectacle.",
        ReadOnly = false,
        Args = { "player", "seconds" }
    },
    {
        Name = "launch",
        Level = 5,
        CreatorOnly = true,
        Usage = "<player> [seconds]",
        Description = "Launch a player with a bounded impulse; can affect the match.",
        ReadOnly = false,
        Args = { "player", "seconds" }
    },
    {
        Name = "untroll",
        Level = 5,
        CreatorOnly = true,
        Usage = "<player>",
        Description = "Restore all temporary creator effects on a player.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "wheel",
        Level = 5,
        Usage = "",
        Description = "Open the owner’s global giveaway picker. One winner per server; Studio is preview only.",
        ReadOnly = true,
        Args = {}
    },
    {
        Name = "help",
        Level = 1,
        Usage = "[command]",
        Description = "Show commands available to your tier.",
        ReadOnly = true,
        Args = { "command" }
    },
    {
        Name = "tiers",
        Level = 1,
        Usage = "",
        Description = "Explain staff tiers and the ContentCreator filming rank.",
        ReadOnly = true,
        Args = {}
    },
    {
        Name = "admins",
        Level = 1,
        Usage = "",
        Description = "List the owner and assigned staff.",
        ReadOnly = true,
        Args = {}
    },
    {
        Name = "players",
        Level = 1,
        Usage = "",
        Description = "List players and match admission status.",
        ReadOnly = true,
        Args = {}
    },
    {
        Name = "status",
        Level = 1,
        Usage = "",
        Description = "Inspect this server and its match queue.",
        ReadOnly = true,
        Args = {}
    },
    {
        Name = "whois",
        Level = 1,
        Usage = "<player>",
        Description = "Show a player\'s role, readiness and staff tier.",
        ReadOnly = true,
        Args = { "player" }
    },
    {
        Name = "ping",
        Level = 1,
        Usage = "[player]",
        Description = "Show the server-observed network latency.",
        ReadOnly = true,
        Args = { "player" }
    },
    {
        Name = "titles",
        Level = 1,
        Usage = "",
        Description = "List cosmetic titles (these grant no powers).",
        ReadOnly = true,
        Args = {}
    },
    {
        Name = "anticheat",
        Level = 2,
        Usage = "<player>",
        Description = "Read recent movement evidence; not a verdict.",
        ReadOnly = true,
        Args = { "player" }
    },
    {
        Name = "clearcheatwarning",
        Level = 4,
        Usage = "<username/UserId>",
        Description = "Clear false-positive movement warnings; preserves audit evidence.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "logs",
        Level = 2,
        Usage = "",
        Description = "Read recent staff actions in this server.",
        ReadOnly = true,
        Args = {}
    },
    {
        Name = "playerhistory",
        Level = 2,
        Usage = "<username/UserId>",
        Description = "A player\'s bans, kicks and unbans: staff, Roblox and anticheat. Works for offline players.",
        ReadOnly = true,
        Args = { "player" }
    },
    {
        Name = "gifthistory",
        Level = 3,
        Usage = "<username/UserId>",
        Description = "Every gift a player sent or received with Robux, newest first. Works for offline players.",
        ReadOnly = true,
        Args = { "player" }
    },
    {
        Name = "history",
        Level = 3.5,
        Usage = "[YYYY-MM-DD/yesterday] [count 1-40]",
        Description = "Load saved staff commands from every server (UTC day, newest first; default today, 15).",
        ReadOnly = true,
        Args = { "date", "count" }
    },
    {
        Name = "warn",
        Level = 2,
        Usage = "<player> <message>",
        Description = "Send a filtered staff warning.",
        ReadOnly = false,
        Args = { "player", "message" }
    },
    {
        Name = "kick",
        Level = 2,
        Usage = "<player> [reason]",
        Description = "Remove a lower-tier player after saving.",
        ReadOnly = false,
        Args = { "player", "message" }
    },
    {
        Name = "lobby",
        Level = 2,
        Usage = "<player>",
        Description = "Withdraw a player to the lobby with AFK on.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "respawn",
        Level = 2,
        Usage = "<player>",
        Description = "Reset a character safely in the lobby.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "heal",
        Level = 2,
        Usage = "<player>",
        Description = "Restore character health.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "afk",
        Level = 2,
        Usage = "<player> <on/off>",
        Description = "Set lobby participation; never interrupt a match.",
        ReadOnly = false,
        Args = { "player", "toggle" }
    },
    {
        Name = "announce",
        Level = 3,
        Usage = "<message>",
        Description = "Send a filtered announcement to this server.",
        ReadOnly = false,
        Args = { "message" }
    },
    {
        Name = "joinplayer",
        Level = 3,
        Usage = "<username/UserId>",
        Description = "Find someone in any server of this game by username or UserId and join their server (saving yours first).",
        ReadOnly = false,
        Args = { "text" }
    },
    {
        Name = "goto",
        Level = 3,
        Usage = "<player>",
        Description = "Teleport yourself next to someone in the lobby.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "bring",
        Level = 3,
        Usage = "<player>",
        Description = "Bring a lower-tier player to you in the lobby.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "freeze",
        Level = 3,
        Usage = "<player> [seconds]",
        Description = "Hold a lobby player briefly (5–120 seconds).",
        ReadOnly = false,
        Args = { "player", "seconds" }
    },
    {
        Name = "unfreeze",
        Level = 3,
        Usage = "<player>",
        Description = "Release a staff-applied lobby hold.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "pause",
        Level = 3,
        Usage = "",
        Description = "Pause the next match; let this one finish.",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "resume",
        Level = 3,
        Usage = "",
        Description = "Resume the match queue.",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "endmatch",
        Level = 3,
        Usage = "",
        Description = "End this match without awarding a win.",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "haunt",
        Level = 3,
        Usage = "",
        Description = "Halloween: zombies and skeletons rise at the next round reset in this server. In the test game anyone may run it.",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "lightsout",
        Level = 3,
        Usage = "",
        Description = "Halloween: the next round in this server goes dark with no UI (Lights Out).",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "hauntmode",
        Level = 3,
        Usage = "<down|turn>",
        Description = "Test game: a Chaser\'s second monster hit downs them until the next round, or turns them into a monster.",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "forcemap",
        Level = 3,
        Usage = "<map|off>",
        Description = "The next match in this server goes to that map, with no vote (off: vote again).",
        ReadOnly = false,
        Args = { "map" }
    },
    {
        Name = "lockserver",
        Level = 3,
        Usage = "",
        Description = "Prevent new ordinary arrivals to this server.",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "unlockserver",
        Level = 3,
        Usage = "",
        Description = "Allow new arrivals again.",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "softban",
        Level = 2.5,
        Usage = "<username/UserId> <days 1-3> [reason]",
        Description = "Roblox ban for the whole game, up to 3 days. Never wipes stats.",
        ReadOnly = false,
        Args = { "player", "duration", "message" }
    },
    {
        Name = "ban",
        Level = 3,
        Usage = "<username/UserId> <days/perm> [wipe] [reason]",
        Description = "Roblox ban for the whole game. Admin: up to 7 days. SeniorAdmin: 30 days. HeadAdmin: perm. wipe (SeniorAdmin+): also reset their leaderboard stats (;unwipe gives them back).",
        ReadOnly = false,
        Args = { "player", "duration", "message" }
    },
    {
        Name = "unban",
        Level = 4,
        Usage = "<username/UserId>",
        Description = "Remove an experience ban.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "unwipe",
        Level = 3.5,
        Usage = "<username/UserId>",
        Description = "Give back the leaderboard stats a ;ban ... wipe took, on top of anything earned since, and put them back on the boards. Works for offline players (wipes before Oct 8: up to 30 days back).",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "setrank",
        Level = 2,
        Usage = "<username/UserId> <rank/none>",
        Description = "Set a rank. Moderators and Admins: Tester, on players without a staff rank. SeniorAdmin/HeadAdmin: also ContentCreator, and staff ranks below their own on staff below them. Owner: any rank.",
        ReadOnly = false,
        Args = { "player", "tier" }
    },
    {
        Name = "unrank",
        Level = 2,
        Usage = "<username/UserId>",
        Description = "Remove a rank. Moderators and Admins: Tester. SeniorAdmin/HeadAdmin: also ContentCreator and staff below them.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "daggers",
        Level = 5,
        Usage = "",
        Description = "List every giftable dagger and its command ID.",
        ReadOnly = true,
        Args = {}
    },
    {
        Name = "giftdagger",
        Level = 5,
        Usage = "<username/UserId/me> <dagger>",
        Description = "Permanently gift one dagger, including unreleased skins. Owner only; offline targets supported.",
        ReadOnly = false,
        Args = { "player", "skin" }
    },
    {
        Name = "emotes",
        Level = 5,
        Usage = "",
        Description = "List every giftable emote and its command ID.",
        ReadOnly = true,
        Args = {}
    },
    {
        Name = "giftemote",
        Level = 5,
        Usage = "<username/UserId/me> <emote>",
        Description = "Permanently gift one emote (onto their wheel\'s first empty slot), including unreleased ones. Owner only; offline targets supported. A knife emote still needs its knife to play.",
        ReadOnly = false,
        Args = { "player", "emote" }
    },
    {
        Name = "giveall",
        Level = 5,
        Usage = "<username/UserId/me>",
        Description = "Permanently give one player every knife and every emote at once, including unreleased ones (as ;giftdagger and ;giftemote). Owner only; offline targets supported.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "title",
        Level = 5,
        Usage = "<username/UserId> <title>",
        Description = "Award a cosmetic title, with no admin powers.",
        ReadOnly = false,
        Args = { "player", "title" }
    },
    {
        Name = "untitle",
        Level = 5,
        Usage = "<username/UserId>",
        Description = "Remove a manually awarded cosmetic title.",
        ReadOnly = false,
        Args = { "player" }
    },
    {
        Name = "givetitle",
        Level = 5,
        PermissionOf = "title",
        Usage = "<username/UserId> <title text> [gold/white/red/orange/green/cyan/blue/purple/pink]",
        Description = "Award a custom cosmetic title (filtered, up to 24 characters; last word may be a colour). ;untitle removes it.",
        ReadOnly = false,
        Args = { "player", "message" }
    },
    {
        Name = "globalannounce",
        Level = 5,
        Usage = "<message>",
        Description = "Send a filtered announcement to every server.",
        ReadOnly = false,
        Args = { "message" }
    },
    {
        Name = "restartserver",
        Level = 5,
        Usage = "[seconds]",
        Description = "Refresh this server after saving progress.",
        ReadOnly = false,
        Args = { "notice" }
    },
    {
        Name = "shutdownserver",
        Level = 5,
        Usage = "[seconds]",
        Description = "Close this server after saving progress.",
        ReadOnly = false,
        Args = { "notice" }
    },
    {
        Name = "restartglobal",
        Level = 5,
        Usage = "[seconds]",
        Description = "Refresh all existing servers.",
        ReadOnly = false,
        Args = { "notice" }
    },
    {
        Name = "updategame",
        Level = 5,
        Usage = "[seconds]",
        Description = "Announce an update and refresh existing servers.",
        ReadOnly = false,
        Args = { "notice" }
    },
    {
        Name = "cancelshutdown",
        Level = 5,
        Usage = "",
        Description = "Cancel this server\'s pending shutdown.",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "cancelglobal",
        Level = 5,
        Usage = "",
        Description = "Cancel the latest global refresh countdown.",
        ReadOnly = false,
        Args = {}
    },
    {
        Name = "previewupdate",
        Level = 5,
        Usage = "",
        Description = "Preview the update screen without transferring anyone.",
        ReadOnly = false,
        Args = {}
    }
};

if game.GameId == 10768621983 and game.PlaceId == 130574217370467 then
    table.insert(u1.Commands, {
        Name = "testwheelknife",
        Level = 5,
        Usage = "<username/UserId/me> <on/off>",
        Description = "Dev place, owner only: while on, that player\'s free wheel spins land on the Kitsune or the Kusarigama (50/50).",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "giveknife",
        Level = 5,
        Usage = "<username/UserId/me> <knife> [amount 1-99]",
        Description = "Dev place, owner only: add copies of any knife to a player in this server, for testing COMBINE. A knife that doesn\'t stack gives one.",
        ReadOnly = false,
        Args = { "player", "skin" }
    });
    table.insert(u1.Commands, {
        Name = "giveeventknives",
        Level = 5,
        Usage = "<username/UserId/me> [amount 1-99]",
        Description = "Dev place, owner only: give a player in this server every Void Blades event knife at once, amount copies (default 1) of each of the 6 path knives and the Ultimate Void Blades once, for testing COMBINE.",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "resetmergeevent",
        Level = 5,
        Usage = "<username/UserId/me> confirm",
        Description = "Dev place, owner only: take every Void Blades event knife off a player in this server (copies, used copies and the Ultimate\'s one-per-player mark) to replay the merge event from zero. Other knives stay.",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "listknives",
        Level = 5,
        Usage = "<username/UserId/me>",
        Description = "Dev place, owner only: list a player\'s knife UUIDs from their save, online or offline. Read-only.",
        ReadOnly = true,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "testgift",
        Level = 5,
        Usage = "<UserId/username/off>",
        Description = "Dev place, owner only: the shop\'s gift list also offers that account even when it is offline (your alt), to test gifting from Studio.",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "eventteam",
        Level = 5,
        Usage = "<Football/Futbol>",
        Description = "Dev place, owner only: join a FOOTBALL vs FÚTBOL team now, whatever the event\'s phase.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "eventpoints",
        Level = 5,
        Usage = "<1-1000>",
        Description = "Dev place, owner only: add event points to yourself. They save like match points and count toward your team\'s total and board.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "eventtotal",
        Level = 5,
        Usage = "<Football/Futbol> <points>",
        Description = "Dev place, owner only: set a team\'s total in this server\'s event snapshot, to try the team levels.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "eventfinal",
        Level = 5,
        Usage = "",
        Description = "Dev place, owner only: make the event\'s final results now; everyone here gets their rewards delivered.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "level25",
        Level = 5,
        Usage = "",
        Description = "Dev place, owner only: give everyone in this server the XP for level 25 (Pro Servers). It saves; anyone at 25+ is left alone.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "resetlevel",
        Level = 5,
        Usage = "[username/UserId/me]",
        Description = "Dev place, owner only: set a player\'s level back to 1 (lifetime XP 0, saved) and rejoin them to this server, to try the Pro Servers unlock again with ;level25.",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "eventreset",
        Level = 5,
        Usage = "",
        Description = "Dev place, owner only: clear your own event record (team, points and claims) to start over.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "resetdata",
        Level = 0,
        Usage = "",
        Description = "Test game, anyone: reset your own data (coins, gems, knives, gear, emotes, quests, Journey, tutorial; level back to 1) and rejoin as a brand-new player. Leaderboard stats stay.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "eventknife",
        Level = 0,
        Usage = "[amount 1-5]",
        Description = "Test game, anyone: give yourself 1 to 5 each of the Kitsune and the Kusarigama (the level 1 Void Blades knives) to test merging.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "givecandy",
        Level = 5,
        Usage = "<username/UserId/me> <amount 1-100000>",
        Description = "Owner: give a player in this server Halloween candy corn (saved; only while the Halloween event is on).",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "givepumpkins",
        Level = 5,
        Usage = "<username/UserId/me> <amount 1-100> [knife chance 0.25-1]",
        Description = "Dev place, owner only: give a player in this server Pumpkin Hunt pumpkins at a knife chance (default 0.25%).",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "pumpkinknife",
        Level = 5,
        Usage = "<username/UserId/me> <on/off>",
        Description = "Dev place, owner only: while on, that player\'s next pumpkin opens the knife (to test the 3D reveal).",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "pot",
        Level = 5,
        Usage = "<coins|goal|max|reset|cooldown>",
        Description = "Dev place, owner only: set this server\'s Pumpkin Hunt pot (no coins taken), or reset it / start its cooldown.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "rollshow",
        Level = 5,
        Usage = "[Ember/Celestial/Emote/pumpkin/wheel] [legendary] [kitsune/kusarigama]",
        Description = "Dev place, owner only: play a made-up crate, pumpkin or spin wheel knife (wheel) opening above your own head, on your screen only (rolls over heads), from the lobby. Nothing is given.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "noabilities",
        Level = 5,
        Usage = "<ballot/status/off>",
        Description = "Dev place, owner only: put THE VALLEY · NO ABILITIES on the next map ballot (with THE VALLEY), take that back, or show where the every-third-Valley count is.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "souls",
        Level = 5,
        Usage = "<count 1-8|clear>",
        Description = "Dev place, owner only: lay test souls 12 studs in front of you to try Soul Reap alone during a crossing; clear takes them away.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "bloodmoon",
        Level = 5,
        Usage = "on|off|auto",
        Description = "Test game, owner only: raise the Blood Moon in this server now (on, for its usual length), hold it down (off), or put it back on its schedule (auto). No word says where it is.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "cuptrailer",
        Level = 5,
        Usage = "[from seconds 0-29]",
        Description = "Test game, owner only: play the 30-second Valley Run Cup trailer on your screen (HUD hidden, ready to screen record), from the start or from that second.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "kingsouls",
        Level = 0,
        Usage = "[souls 1-1000|here]",
        Description = "Test game, anyone: put that many Fallen King souls in your lantern (walk to the cauldron to offer them); no number lays 3 round you to pick up, here lays one more than a lantern holds at your feet.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "giveability",
        Level = 5,
        Usage = "<username/UserId/me> <ability>",
        Description = "Test game, owner only: give one player an ability for good (owned and equipped in its role\'s slot), online or offline, e.g. ;giveability me Burrow.",
        ReadOnly = false,
        Args = { "player", "text" }
    });
    table.insert(u1.Commands, {
        Name = "kingtarget",
        Level = 5,
        Usage = "[souls]",
        Description = "Owner only: set the Fallen King offering\'s hidden global target (souls for 100%) for every server; no number shows it.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "myrolls",
        Level = 5,
        Usage = "on|off",
        Description = "Dev place, owner only: your own real crate, pumpkin and spin wheel shows also play above your head on your screen, to test them without a second player.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "norandom",
        Level = 5,
        Usage = "on|off",
        Description = "Dev place: anyone there, on themselves: play as a player Roblox keeps from paid random items (no odds or pumpkins, coins for pumpkin heads); off goes back to Roblox\'s answer.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "slowbots",
        Level = 5,
        Usage = "[10-90|off]",
        Description = "Dev place, owner only: runner bots run at that percent of their speed (35 if left out) so chasers catch them; off puts them back.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "outbreakpct",
        Level = 5,
        Usage = "<0-100|off>",
        Description = "Test game, owner only: pin THE OUTBREAK\'s infection percentage to try its milestones; off goes back to the curve.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "ranked",
        Level = 0,
        Usage = "on|off",
        Description = "Test game, anyone: the server starts over as a Ranked server (loadout, map vote, match, results; bots fill it to 20), or back to normal matches.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "kingpct",
        Level = 0,
        Usage = "<0-100|off>",
        Description = "Test game, anyone: pin THE FALLEN KING\'s global percentage in this server to try its stages; off goes back to the week-long track.",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "boss",
        Level = 0,
        Usage = "live|summon|win|stone|fill|off|x10|cards [plain]",
        Description = "Test game, anyone: the Fallen King boss fight takes this server\'s next match (live: its 13-minute timer starts now; summon: health by player count); win: the fight that\'s on ends with him falling (to try the rewards); stone: the live fight counts as won here (his stone body and its re-summon coin meter); fill: the meter fills now (no coins taken) and its countdown starts; off cancels and empties the meter; x10: 10x damage on him and his shrines, on/off; cards: only the reward screen on your screen, freshly rolled, nothing given (with the KINGSLAYER banner and TOP 10 odds; cards plain: a normal fighter\'s).",
        ReadOnly = false,
        Args = { "text" }
    });
    table.insert(u1.Commands, {
        Name = "resetshop",
        Level = 5,
        Usage = "[username/UserId/me]",
        Description = "Dev place, owner only: take back the Halloween shop\'s titles and knife from a player in this server (default you) so they can be bought again to test. Crate prizes stay.",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "ghostkeys",
        Level = 5,
        Usage = "[username/UserId/me] [amount 1-9999]",
        Description = "Dev place: anyone there (on themselves; owners on anyone): give Ghost Keys for the Ghost Key Trader (default you; no amount gives a random 5 to 15).",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "resettrader",
        Level = 5,
        Usage = "[username/UserId/me]",
        Description = "Dev place: anyone there (on themselves; owners on anyone): clear the Ghost Key Trader cooldown and today\'s skips and deal new cards (default you). Keys stay. During a ;showcards showcase it only clears the cooldown, so the cards stay.",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "showcards",
        Level = 5,
        Usage = "[username/UserId/me] [off]",
        Description = "Dev place: anyone there (on themselves; owners on anyone): two Ghost Key Trader deals in a row with one of each card: every rarity, a Legendary turning gold, and the red card\'s Mythical, then its Legendary. Keys and the cooldown work as always (;resettrader keeps the showcase); ;showcards off ends it.",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "nextcard",
        Level = 5,
        Usage = "[username/UserId/me] <reward> | off",
        Description = "Dev place: anyone there (on themselves; owners on anyone): your next Ghost Key Trader flip of a card that can give it gives that reward (skeletonkey, ghostlock, lastdoor, or any reward\'s name). Clears the cooldown; a red-card-only reward deals fresh cards with a red card if needed. Keys as always.",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "cursedodds",
        Level = 5,
        Usage = "[username/UserId/me] <0-100|off>",
        Description = "Dev place: anyone there (on themselves; owners on anyone): how often your Ghost Key Trader deals have a red Cursed card, from your next deal (;resettrader deals one now); off goes back to the game\'s odds. Until you leave the server.",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "keydrops",
        Level = 5,
        Usage = "[username/UserId/me] <0-100|off>",
        Description = "Dev place, owner only: how often the zombies and skeletons a player takes down in a haunt drop a Ghost Key (the game\'s is 15%); off goes back to it. Until they leave the server.",
        ReadOnly = false,
        Args = { "player" }
    });
    table.insert(u1.Commands, {
        Name = "removebots",
        Level = 0,
        Usage = "[off]",
        Description = "Test game, anyone: no bots in this server from the next match on, and none in the lobby; ;removebots off brings them back.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "giveallall",
        Level = 0,
        Usage = "",
        Description = "Test game, anyone: give everyone in this server every knife, emote and ability, and 100 of each item, for good.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "testspins",
        Level = 0,
        Usage = "",
        Description = "Test game, anyone: give yourself 100 wheel spins.",
        ReadOnly = false,
        Args = {}
    });
    table.insert(u1.Commands, {
        Name = "david",
        Level = 0,
        Usage = "[off]",
        Description = "Dev place, anyone: everyone looks like user 11551976004 (avatar, name, OWNER title; cosmetic, no commands) until ;david off.",
        ReadOnly = false,
        Args = {}
    });
end;

local u14 = {};

for _, v in u1.Commands do
    u14[v.Name] = v;
end;

function u1.find(p15) -- Line: 1018
    -- upvalues: u14 (copy), u1 (copy)
    return u14[u1.Aliases[p15] or p15];
end;

function u1.tier(p16) -- Line: 1021
    -- upvalues: u1 (copy)
    if type(p16) ~= "string" and type(p16) ~= "number" then
        return nil;
    end;

    local v17 = tostring(p16):lower():gsub("[%s_-]", "");
    local v18 = ({
        mod = "moderator",
        head = "headadmin",
        srmod = "seniormod",
        seniormoderator = "seniormod",
        sradmin = "senioradmin",
        coowner = "owneradmin"
    })[v17] or v17;

    for _, v in u1.Tiers do
        if v18 == v.Name:lower() or tonumber(p16) == v.Level then
            return v;
        end;
    end;
end;

function u1.tierName(p19) -- Line: 1041
    -- upvalues: u1 (copy)
    for _, v in u1.Tiers do
        if v.Level == p19 then
            return v.Name;
        end;
    end;

    return "Player";
end;

u1.CreatorCommands = {};

for _, v in { "help", "tiers", "admins", "players", "status", "whois", "ping", "titles", "anticheat", "logs", "warn", "kick", "lobby", "respawn", "heal", "afk", "announce", "goto", "bring", "freeze", "unfreeze", "pause", "resume", "endmatch", "lockserver", "unlockserver" } do
    u1.CreatorCommands[v] = true;
end;

function u1.commandLevel(p20) -- Line: 1083
    return p20.CreatorOnly and 5 or p20.Level;
end;

function u1.allowed(p21, p22, p23, p24) -- Line: 1089
    -- upvalues: u1 (copy)
    local v25 = u1.find(p22);

    if not v25 or type(p21) ~= "number" then
        return false;
    end;

    if p21 >= 5 then
        return true;
    end;

    if p21 > 0 and type(p24) == "table" then
        local v26 = p24["cmd." .. (v25.PermissionOf or v25.Name)];

        if v26 ~= nil then
            return v26 == true;
        end;
    end;

    if v25.CreatorOnly then
        return false;
    end;

    return v25.Level <= p21;
end;

function u1.help(p27, p28, p29, p30) -- Line: 1109
    -- upvalues: u1 (copy)
    if p28 and p28 ~= "" then
        local v31 = u1.find(p28:lower():gsub("^;", ""));

        return not (v31 and u1.allowed(p27, v31.Name, p29, p30)) and "No available command with that name." or ";" .. v31.Name .. " " .. v31.Usage .. "\n" .. v31.Description .. "\nAccess: " .. (v31.CreatorOnly and "Owner" or u1.tierName(v31.Level));
    end;

    local v32 = { "VALLEY RUN · " .. (p29 and p27 == 0 and "ContentCreator" or u1.tierName(p27)):upper() .. " COMMANDS" };

    for _, v in u1.Commands do
        if u1.allowed(p27, v.Name, p29, p30) then
            table.insert(v32, ";" .. v.Name .. " " .. v.Usage .. "  ·  " .. v.Description);
        end;
    end;

    table.insert(v32, "Tab completes. Up/Down selects a suggestion. Alt+Up/Down recalls history. Tap a suggestion on mobile.");
    table.insert(v32, "Targets: username, unique prefix, UserId or me. Use ;setrank for staff ranks and ;title for cosmetic recognition.");

    return table.concat(v32, "\n");
end;

function u1.tierDisplay(p33) -- Line: 1145
    -- upvalues: u1 (copy)
    for _, v in u1.Tiers do
        if v.Level == p33 then
            return v.DisplayName or v.Name;
        end;
    end;

    return "Player";
end;

u1.Categories = { "Moderation", "Players", "Server", "Info", "Staff", "Gifts", "Effects", "Dev" };
local u34 = {
    warn = "Moderation",
    kick = "Moderation",
    softban = "Moderation",
    ban = "Moderation",
    unban = "Moderation",
    unwipe = "Moderation",
    anticheat = "Moderation",
    clearcheatwarning = "Moderation",
    playerhistory = "Moderation",
    gifthistory = "Moderation",
    lobby = "Players",
    respawn = "Players",
    heal = "Players",
    afk = "Players",
    goto = "Players",
    joinplayer = "Players",
    bring = "Players",
    freeze = "Players",
    unfreeze = "Players",
    announce = "Server",
    globalannounce = "Server",
    pause = "Server",
    resume = "Server",
    endmatch = "Server",
    forcemap = "Server",
    haunt = "Server",
    hauntmode = "Server",
    lightsout = "Server",
    lockserver = "Server",
    unlockserver = "Server",
    restartserver = "Server",
    shutdownserver = "Server",
    restartglobal = "Server",
    updategame = "Server",
    cancelshutdown = "Server",
    cancelglobal = "Server",
    previewupdate = "Server",
    globalspin = "Server",
    wheel = "Server",
    help = "Info",
    tiers = "Info",
    admins = "Info",
    players = "Info",
    status = "Info",
    whois = "Info",
    ping = "Info",
    titles = "Info",
    logs = "Info",
    history = "Info",
    setrank = "Staff",
    unrank = "Staff",
    title = "Staff",
    untitle = "Staff",
    givetitle = "Staff",
    daggers = "Gifts",
    giftdagger = "Gifts",
    givecandy = "Gifts",
    emotes = "Gifts",
    giftemote = "Gifts",
    giveall = "Gifts",
    giveallall = "Gifts",
    giveability = "Gifts",
    sparkles = "Effects",
    fire = "Effects",
    confetti = "Effects",
    rainbow = "Effects",
    ghost = "Effects",
    bighead = "Effects",
    spin = "Effects",
    launch = "Effects",
    untroll = "Effects"
};

function u1.category(p35) -- Line: 1173
    -- upvalues: u34 (copy)
    return u34[p35.Name] or "Dev";
end;

u1.Capabilities = { {
        Id = "ban.3d",
        Name = "Ban up to 3 days",
        Category = "Moderation",
        Level = 2.5
    }, {
        Id = "ban.7d",
        Name = "Ban up to 7 days",
        Category = "Moderation",
        Level = 3
    }, {
        Id = "ban.30d",
        Name = "Ban up to 30 days",
        Category = "Moderation",
        Level = 3.5
    }, {
        Id = "ban.perm",
        Name = "Permanent bans",
        Category = "Moderation",
        Level = 4
    }, {
        Id = "data.wipe",
        Name = "Wipe and restore leaderboard stats",
        Category = "Moderation",
        Level = 3.5
    }, {
        Id = "staff.titles",
        Name = "Give or remove the Tester title",
        Category = "Staff",
        Level = 2
    }, {
        Id = "staff.creator",
        Name = "Give or remove ContentCreator",
        Category = "Staff",
        Level = 3.5
    }, {
        Id = "staff.ranks",
        Name = "Set staff ranks below their own",
        Category = "Staff",
        Level = 3.5
    }, {
        Id = "staff.permissions",
        Name = "Edit staff permissions",
        Category = "Staff",
        Level = 4.5
    } };
local u36 = {};

for _, v in u1.Capabilities do
    u36[v.Id] = v;
end;

function u1.permission(p37) -- Line: 1195
    -- upvalues: u14 (copy), u1 (copy), u36 (copy)
    if type(p37) ~= "string" then
        return nil;
    end;

    local v38 = p37:match("^cmd%.(%w+)$");

    if not v38 then
        return u36[p37];
    end;

    local v39 = u14[v38];

    return v39 and {
        Id = p37,
        Name = ";" .. v39.Name,
        Category = u1.category(v39),
        Level = u1.commandLevel(v39),
        Command = v39.Name
    } or nil;
end;

function u1.permissionIds() -- Line: 1209
    -- upvalues: u1 (copy)
    local v40 = {};

    for _, v in u1.Capabilities do
        table.insert(v40, v.Id);
    end;

    for _, v in u1.Commands do
        if not v.PermissionOf then
            table.insert(v40, "cmd." .. v.Name);
        end;
    end;

    return v40;
end;

function u1.defaultAllows(p41, p42) -- Line: 1223
    -- upvalues: u1 (copy)
    local v43 = u1.permission(p42);

    if v43 and (type(p41) == "number" and p41 > 0) then
        return v43.Level <= p41;
    end;

    local v44;

    if type(p41) == "number" then
        v44 = p41 >= 5;
    else
        v44 = false;
    end;

    return v44;
end;

function u1.allows(p45, p46, p47) -- Line: 1231
    -- upvalues: u1 (copy)
    if type(p45) ~= "number" or p45 <= 0 then
        return false;
    end;

    if p45 >= 5 then
        return true;
    end;

    if type(p47) ~= "table" or p47[p46] == nil then
        return u1.defaultAllows(p45, p46);
    end;

    local v48;

    if p47[p46] == true then
        v48 = u1.permission(p46) ~= nil;
    else
        v48 = false;
    end;

    return v48;
end;

function u1.banSeconds(p49, p50) -- Line: 1244
    -- upvalues: u1 (copy)
    if u1.allows(p49, "ban.perm", p50) then
        return -1;
    end;

    for _, v in { { "ban.30d", 30 }, { "ban.7d", 7 }, { "ban.3d", 3 } } do
        if u1.allows(p49, v[1], p50) then
            return v[2] * 86400;
        end;
    end;

    return 0;
end;

return u1;