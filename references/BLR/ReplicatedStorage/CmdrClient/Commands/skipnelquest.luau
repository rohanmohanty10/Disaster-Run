  

return {
    Name = "skipnelquest",
    Description = "Marks a specific NEL quest as completed for the target player.",
    Group = "Mod",
    Aliases = { "skipnelquest", "completenelquest" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "The target player"
        }, {
            Type = "string",
            Name = "questId",
            Description = "The NEL quest id (e.g. \'bachira_quest_opt1\')"
        } }
};