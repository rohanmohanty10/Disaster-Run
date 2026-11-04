 
 

return {
    Description = "Toggle ball mode: the player becomes the soccer ball everyone plays with (one at a time; running it on someone else swaps)",
    Name = script.Name,
    Aliases = {},
    Group = script.Parent.Name,
    Args = { {
            Type = "player",
            Name = "target",
            Description = "who becomes the ball"
        } }
};