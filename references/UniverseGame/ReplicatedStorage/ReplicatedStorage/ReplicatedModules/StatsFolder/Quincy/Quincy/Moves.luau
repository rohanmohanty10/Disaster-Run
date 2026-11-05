  

 

return {
    DefaultMoveState = "Universal",
    Groups = {
        Universal = {
            Visible = true,
            Priority = 1
        }
    },
    MovesInfo = {
        ["Rush Attack"] = {
            DefaultKeybind = "MouseButton1",
            Equipped = true,
            MoveCapCount = false
        },
        Block = {
            DefaultKeybind = "F",
            Equipped = true,
            MoveCapCount = false
        },
        Quickstep = {
            DefaultKeybind = "C",
            Equipped = true,
            MoveCapCount = false
        },
        Grab = {
            DefaultKeybind = "X",
            Equipped = true,
            MoveCapCount = false
        },
        ["Triple Strike"] = {
            DefaultKeybind = "E",
            Equipped = true,
            Description = "Three sword slashes, shoot projectile on last slash"
        },
        ["Dash Strike"] = {
            DefaultKeybind = "R",
            Equipped = true,
            Description = "The user dashes forward"
        },
        Pierce = {
            DefaultKeybind = "Q",
            Equipped = true,
            Description = "Quick dash attack"
        },
        ["Double Slash"] = {
            DefaultKeybind = "T",
            Equipped = true,
            Description = "Two slashes"
        },
        ["Auswählen"] = {
            DefaultKeybind = "G",
            Equipped = true,
            Description = ""
        }
    }
};