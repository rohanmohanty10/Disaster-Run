 
 

local _ = script.Parent;

return {
    {
        Name = "Experimental",
        Data = { {
                datatitle = "HurtboxSync",
                type = "default",
                name = "Hurtbox Sync",
                description = "Attempts to attach all enemy players to their hurtboxes to ensure consistant visuals, requires visible hitboxes on to function."
            } }
    },
    {
        Name = "Audio",
        Data = {
            {
                datatitle = "music",
                type = "default",
                name = "Flow Music",
                description = "no music when u flow"
            },
            {
                datatitle = "crowdAudio",
                type = "default",
                name = "Crowd Audio",
                description = "disable the annoying crowd rawr xd"
            },
            {
                datatitle = "crowdCheer",
                type = "default",
                name = "Crowd Cheer",
                description = "disable the crowd cheering on goal"
            },
            {
                datatitle = "otherGoalSounds",
                type = "default",
                name = "disable Others Goal Sounds",
                description = "no goal sound from people me no like ur ITOSHI RIN-DA!!"
            },
            {
                datatitle = "otherEmoteSounds",
                type = "default",
                name = "Others Emote Audio",
                description = "hear other players\' emote sounds (your own always plays)"
            },
            {
                datatitle = "CustomDribbleSounds",
                type = "default",
                name = "disable Others Dribble Sounds",
                description = "no dribble sound from people me no like ur ANKLE BREAKER!!"
            },
            {
                datatitle = "CustomVFXEnabled",
                type = "default",
                name = "Enable Others Custom VFX",
                description = "disable other VFX recolorings, does not affect you, the user"
            },
            {
                datatitle = "alternatelines",
                type = "default",
                name = "Alternate Voice Actors/Lines",
                description = "different voice actors for certain sounds (applies currently to Don Lorenzo mastery)"
            },
            {
                datatitle = "modifiedVoices",
                type = "default",
                name = "Modified Voicelines",
                description = "global voicelines"
            },
            {
                datatitle = "RemoveRefereeWhistle",
                type = "default",
                name = "Remove Referee Whistle",
                description = "Removes the start whistle and goal whistle"
            }
        }
    },
    {
        Name = "Gamepass/Quest",
        Data = {
            {
                datatitle = "awakeningOutfitId",
                type = "function",
                name = "Awakening outfit",
                description = "Change your outfit when use flow"
            },
            {
                datatitle = "soundChanger",
                type = "function",
                name = "Custom goal sfx",
                description = "Play cool sound when score"
            },
            {
                datatitle = "dribbleSound",
                type = "function",
                name = "Custom Dribble sfx",
                description = "Play cool sound when successful dribble"
            },
            {
                datatitle = "flowMusicId",
                type = "function",
                name = "Custom Flow Music",
                description = "play your own song when you awaken (only you hear it)"
            },
            {
                datatitle = "VFXRecolor",
                type = "function",
                name = "Custom VFX Colors",
                description = "Change most VFX colors"
            },
            {
                datatitle = "jerseyNumber",
                type = "function",
                name = "Custom jersey number",
                description = "Change the number on your jersey"
            },
            {
                datatitle = "britishaikuevil",
                type = "default",
                name = "enable British aiku",
                description = "British.... (original voice by @PajamaAtticus)"
            },
            {
                datatitle = "HideStats",
                type = "default",
                name = "Hide Stats (VIP)",
                description = "hide ur stats ok? vip only"
            },
            {
                datatitle = "DisableStatGain",
                type = "default",
                name = "Disable Stat Gain (VIP)",
                description = "disable stat gain ok? vip only"
            },
            {
                datatitle = "SpecificJersey",
                type = "function",
                name = "Jersey Of Choice",
                description = "choose the jersey you wear"
            }
        }
    },
    {
        Name = "Visuals",
        Data = {
            {
                datatitle = "epilepsysafe",
                type = "default",
                name = "Epilepsy Safe Mode",
                description = "Disable only if you\'re not epileptic. Please consult a doctor if flashing lights make you feel sick, and you\'re unsure if you have epilepsy."
            },
            {
                datatitle = "loadonbaddeviceanyway",
                type = "default",
                name = "Load assets anyway",
                description = "The game may crash during loading with weaker devices, so if loading gets skipped for you, enabling this will let it run."
            },
            {
                datatitle = "nohideUIcutscene",
                type = "default",
                name = "UI Enabled During Cutscenes",
                description = "Enable to keep UI visible during cutscenes, helpful for mobile players"
            },
            {
                datatitle = "hiderankedicon",
                type = "default",
                name = "Hide Ranked Icon",
                description = "Enable to hide specifically your ranked icon above your head"
            },
            {
                datatitle = "camShake",
                type = "default",
                name = "Camera Shake",
                description = "Disable camera shake to maintain a stable and uninterrupted view"
            },
            {
                datatitle = "flowScreen",
                type = "default",
                name = "Flow Screen Beats",
                description = "to enhance excitement and realism in the gameplay"
            },
            {
                datatitle = "CurrencyUI",
                type = "default",
                name = "Currency Indicator",
                description = "When in-game, there is UI in the bottom right corner which tells you how much currency you have."
            },
            {
                datatitle = "subtitle",
                type = "default",
                name = "Subtitle",
                description = "Disable anime yapping"
            },
            {
                datatitle = "disableConsoleUI",
                type = "default",
                name = "disable button hints for console",
                description = "disable console ui"
            },
            {
                datatitle = "disablePing",
                type = "default",
                name = "disable Ping UI",
                description = "if someone wanna play hardcore game"
            },
            {
                datatitle = "graphicsMode",
                type = "function",
                name = "Graphics Settings",
                description = "Change your graphics to increase fps!"
            },
            {
                datatitle = "ClockTime",
                type = "number",
                min = 0,
                max = 24,
                name = "TimeOfDay",
                description = "Change the time of day from 0 to 24"
            },
            {
                datatitle = "PotatoMaps",
                type = "default",
                name = "Potato Maps",
                description = "Changes the crowd out for a blue-lock training ground type area for 5v5 and 11v11. (⚠️ could cause lag on join + enabling / disabling, as it readds/removes the original crowd)"
            },
            {
                datatitle = "PotatoestMaps",
                type = "default",
                name = "Potatoest Maps",
                description = "Deletes the crowd, there\'s no need for spectators. (⚠️ could cause lag on join + enabling / disabling, as it readds/removes the original crowd)"
            },
            {
                datatitle = "WeakerVFX",
                type = "specialsettings",
                name = "Visual Optimization",
                description = "Changes a lot of parts of the game (primarily orientated on visuals) to improve FPS."
            },
            {
                datatitle = "weather",
                type = "default",
                name = "Weather",
                description = "disable the rain or snow or bra bra bra"
            },
            {
                datatitle = "enableJerseyNumber",
                type = "default",
                name = "Enable jersey text",
                description = "Enables the text on your jersey"
            },
            {
                datatitle = "teamHighlight",
                type = "default",
                name = "Team Highlight",
                description = "disable easy see team ;P"
            },
            {
                datatitle = "FPS",
                type = "default",
                name = "Show FPS & Ping",
                description = "disable see FPS & Ping :("
            },
            {
                datatitle = "ServerLocation",
                type = "default",
                name = "Show Server Location",
                description = "disable show server location ;("
            },
            {
                datatitle = "ServerAge",
                type = "default",
                name = "Show Server Age",
                description = "disable show server age :("
            },
            {
                datatitle = "Style&MVP",
                type = "default",
                name = "Show Current Style + MVP Animation",
                description = "disable see current style and MVP animation"
            },
            {
                datatitle = "GKColoredLine",
                type = "default",
                name = "Colored GK Line",
                description = "colors the gk line according to what style a player is"
            }
        }
    },
    {
        Name = "Gameplay",
        Data = {
            {
                datatitle = "showHitboxes",
                type = "default",
                name = "Show Hitboxes",
                description = "show your own hitboxes"
            },
            {
                datatitle = "NoVFXAtAll",
                type = "default",
                name = "Remove MOST VFX",
                description = "Disables automatic effect playing."
            },
            {
                datatitle = "HoldSpaceForAir",
                type = "default",
                name = "Hold Space For Air Variants",
                description = "air variants can be triggered by holding space instead of having to wait until you\'re off the ground"
            },
            {
                datatitle = "camAim",
                type = "default",
                name = "Camera aim controlling",
                description = "camera aim controlling the height of moves"
            },
            {
                datatitle = "NoFOVChange",
                type = "default",
                name = "NO FOV Changes",
                description = "Turns off FOV Changes"
            },
            {
                datatitle = "autoHeader",
                type = "default",
                name = "Auto Techniques Mode",
                description = "just a auto header + volley"
            },
            {
                datatitle = "volleys",
                type = "default",
                name = "Volleys Enabled",
                description = "disables/enables volleys"
            },
            {
                datatitle = "sensitivity",
                type = "number",
                name = "Camera Sensitivity (PC and Console)",
                description = "Camera sensitivity adjusts how quickly the camera moves in response to player input, allowing for a more responsive or smoother view"
            },
            {
                datatitle = "mobilebuttonPositions",
                type = "function",
                name = "Move Buttons (Mobile)",
                description = "custom mobile button position"
            },
            {
                datatitle = "fasterCharacterCoordinateReplication",
                type = "default",
                name = "Faster Character Coordinate Replication",
                description = "see real character position"
            },
            {
                datatitle = "consoleRemapping",
                type = "function",
                name = "Controller Remapping",
                description = "Change your console controls!"
            },
            {
                datatitle = "customKeybinds",
                type = "function",
                name = "Custom Keybinds",
                description = "Change your controls!"
            }
        }
    },
    {
        Name = "Miscellanous",
        Data = { {
                datatitle = "DuoMvp",
                type = "function",
                name = "Duo MVP Friend",
                description = "duo in mvps that support it"
            }, {
                datatitle = "DUOEmote",
                type = "default",
                name = "disable Duo Emote",
                description = "Disable duo emote"
            } }
    },
    {
        Name = "Fun",
        Data = { {
                datatitle = "TableSoccer",
                type = "default",
                name = "Table Soccer",
                description = "Removes all animation from players. Behaves slightly differently when playing as GK."
            } }
    }
};