 
 

return {
    {
        datatitle = "awaketest",
        name = "Awake Test",
        description = "Allows you to use Flow moves without having Flow",
        arguments = { "player" }
    },
    {
        datatitle = "ball",
        name = "Give Ball",
        description = "Gives Ball to Target",
        arguments = { "player" }
    },
    {
        datatitle = "flow",
        name = "Give Flow",
        description = "Gives Flow to Target",
        arguments = { "player" }
    },
    {
        datatitle = "dummy",
        name = "Spawn Dummy",
        description = "Spawns in dummy",
        arguments = { {
                Type = "string",
                Name = "what team?",
                Autofill = "A",
                Description = "this autofills as your own team or A if left empty"
            }, {
                Type = "string",
                Name = "what team placement?",
                Autofill = "LW",
                Description = "this autofills as LW, options CF|RW|LW|CM|GK"
            }, {
                Type = "boolean",
                Name = "tackles?",
                Description = "bro on offensive"
            }, {
                Type = "stylepublic",
                Name = "what style",
                Description = "le style"
            } }
    },
    {
        datatitle = "dummyNCD",
        name = "Dummy No Cooldown",
        description = "Disables cooldowns on selected Dummy"
    },
    {
        datatitle = "dummySkill",
        name = "Dummy Uses Skill",
        description = "Selected dummy uses skill",
        arguments = { {
                Type = "string",
                Name = "what skill?",
                Description = "skill[num]/awaken/Tspecialer"
            } }
    },
    {
        datatitle = "disableKick",
        name = "Disable Kick",
        description = "Disables Kicking"
    },
    {
        datatitle = "disableGoal",
        name = "Disable Goal",
        description = "Disables Goals"
    },
    {
        datatitle = "disableFlow",
        name = "Disable Flow",
        description = "Disables Flow"
    },
    {
        datatitle = "ignoreFlowCooldown",
        name = "ignore Flow Cooldown",
        description = "ignores flow cooldown"
    },
    {
        datatitle = "invisible",
        name = "Invisibility",
        description = "turns u invisible",
        arguments = { "player" }
    },
    {
        datatitle = "kick",
        name = "Kick",
        description = "Kicks player from server",
        arguments = { "player" }
    },
    {
        datatitle = "lockserver",
        name = "Lock Server",
        description = "Prevents Players from joining"
    },
    {
        datatitle = "measure",
        name = "Measuring Tool",
        description = "Allows Player(s) to measure distances",
        arguments = { "player" }
    },
    {
        datatitle = "mercyThreshold",
        name = "Mercy Threshold",
        description = "sets mercy idk what this rlly does go FIGURE OUT!!!!!!!!! I THINK ITS HOW MUCH GOALS U NEED OVER ENEMY TO WIN",
        arguments = { "number" }
    },
    {
        datatitle = "ncd",
        name = "No Cooldown",
        description = "removes cooldowns for player",
        arguments = { "player" }
    },
    {
        datatitle = "noMercy",
        name = "No Mercy",
        description = "disables game end by overpowering enemy team in goal count"
    },
    {
        datatitle = "overtimetest",
        name = "Overtime Test",
        description = "Triggers Overtime for user, primarily for testing overtime exclusive interactions",
        arguments = { "player" }
    },
    {
        datatitle = "recolorStyle",
        name = "Recolor Style",
        description = "Provide Color and Alpha to change command runners effect colors",
        arguments = { "color3", "number" }
    },
    {
        datatitle = "timerspeed",
        name = "Timer Speed",
        description = "Set speed of round timer",
        arguments = { "number" }
    },
    {
        datatitle = "debugtest",
        name = "Debug Test",
        description = "Enables debug related settings"
    },
    {
        datatitle = "endgame",
        name = "End Game",
        description = "ends game",
        arguments = { {
                Type = "number",
                Name = "delay",
                Description = "delay at all?",
                Autofill = 0
            } }
    },
    {
        datatitle = "addgoal",
        name = "Add Goals",
        description = "Adds Goals to a team",
        arguments = { {
                Type = "string",
                Name = "what team?",
                Description = "A or B",
                Autofill = "A"
            }, {
                Type = "number",
                Name = "amount",
                Description = "can be negative of course"
            } }
    },
    {
        datatitle = "addflow",
        name = "Add Flow",
        description = "Provide player with amount of flow",
        arguments = { {
                Type = "player",
                Name = "targets",
                Description = "The players to add flow in this server."
            }, {
                Type = "number",
                Name = "amount",
                Description = "can be negative of course"
            } }
    },
    {
        datatitle = "freeze",
        name = "Freeze Game",
        description = "Freezes game like how it does during Cutscenes",
        arguments = { {
                Type = "number",
                Name = "delay",
                Description = "delay until freeze",
                Autofill = 0
            }, {
                Type = "number",
                Name = "duration",
                Description = "positive to have a specific duration",
                Autofill = -1
            } }
    },
    {
        datatitle = "addtime",
        name = "Add Time",
        description = "Adds time to the Round Timer.",
        arguments = { {
                Type = "number",
                Name = "how much do u want.",
                Description = "how much do u want again lol."
            } }
    },
    {
        datatitle = "announce",
        name = "Announce to Server",
        description = "Sends a message to every player in the server",
        arguments = { {
                Type = "string",
                Name = "what say?",
                Description = "what to announce"
            } }
    },
    {
        datatitle = "freecam",
        name = "Enable Freecam",
        description = "Enables Freecam on Player(s)",
        arguments = { {
                Type = "player",
                Name = "players",
                Description = "The players to give freecam, requires a keyboard."
            } }
    },
    {
        datatitle = "ballcontrol",
        name = "Ball Control",
        description = "Spectate and drive the ball with WASD and mouse look.",
        aliases = { "bc" }
    },
    {
        datatitle = "makereferee",
        name = "Make Player a Referee",
        description = "Gives player(s) access to some commands",
        arguments = { {
                Type = "player",
                Name = "targets",
                Description = "The players to give/take referee in this server."
            } }
    },
    {
        datatitle = "stoproundtimer",
        name = "Stop/Resume Round Timer",
        description = "Self-explanatory."
    },
    {
        datatitle = "exclusivestyle",
        name = "Give PS+ Style",
        description = "Provide player(s) with PS+ styles.",
        arguments = { {
                Type = "player",
                Name = "peoples",
                Description = "The People."
            }, {
                Type = "psstyles",
                Name = "Options",
                Description = "The current catalog, more to come"
            } }
    },
    {
        datatitle = "removeexclusivestyle",
        name = "Removes PS+ Style",
        description = "Removes a PS+ style from player(s).",
        arguments = { {
                Type = "player",
                Name = "peoples",
                Description = "The People."
            }, {
                Type = "psstyles",
                Name = "Options",
                Description = "The current catalog, more to come"
            } }
    },
    {
        datatitle = "skillbuilder",
        name = "Skill Builder",
        description = "gives u skill builder"
    },
    {
        datatitle = "marble",
        name = "Marble",
        description = "Puts the player in a glass marble to roll around in (run again to take them out)",
        arguments = { {
                Type = "player",
                Name = "who",
                Description = "Who gets marbled."
            } }
    },
    {
        datatitle = "marbleball",
        name = "Marble Ball",
        description = "Shrinks the player into the soccer ball everyone plays with (run again to undo)",
        arguments = { {
                Type = "player",
                Name = "who",
                Description = "Who becomes the ball."
            } }
    },
    {
        datatitle = "hostcode",
        name = "Host Code",
        description = "returns the host code"
    }
};