 
 

return {
    Name = "candycorn",
    Group = "Admin",
    Description = "Spawns collectible candy corn randomly on the court, including outside matches",
    Args = { {
            Type = "number",
            Name = "amount",
            Description = "Number of pickups to spawn (1-50, up to 50 active)"
        } }
};