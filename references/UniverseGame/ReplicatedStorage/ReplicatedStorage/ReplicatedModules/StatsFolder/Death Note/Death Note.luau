  

 

return {
    Stats = {
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Toggle = {
            Active = true,
            Actionable = {
                Active = true
            }
        }
    },
    Animations = require(script.Animations),
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 4
            }
        },
        MovesInfo = require(script.Moves)
    },
    Sounds = {}
};